#include <ros/ros.h>

#include <cmath>
#include <utility>
#include <vector>

#include <Eigen/Dense>
#include <trajectory_msgs/MultiDOFJointTrajectory.h>
#include <quadrotor_msgs/PositionCommand.h>

ros::Publisher pos_cmd_pub;

quadrotor_msgs::PositionCommand cmd;
double pos_gain[3] = {0, 0, 0};
double vel_gain[3] = {0, 0, 0};

bool receive_traj_ = false;
trajectory_msgs::MultiDOFJointTrajectory traj_msg_;
ros::Time start_time_;
uint32_t traj_id_ = 0;

double normalizeAngle(double angle)
{
  constexpr double kPi = 3.1415926;
  while (angle > kPi)
    angle -= 2.0 * kPi;
  while (angle < -kPi)
    angle += 2.0 * kPi;
  return angle;
}

double clamp01(double value)
{
  if (value < 0.0)
    return 0.0;
  if (value > 1.0)
    return 1.0;
  return value;
}

double yawFromQuat(const geometry_msgs::Quaternion &q)
{
  double siny_cosp = 2.0 * (q.w * q.z + q.x * q.y);
  double cosy_cosp = 1.0 - 2.0 * (q.y * q.y + q.z * q.z);
  return std::atan2(siny_cosp, cosy_cosp);
}

void trajCallback(const trajectory_msgs::MultiDOFJointTrajectoryConstPtr &msg)
{
  if (msg->points.empty())
  {
    ROS_WARN("[Traj server]: empty trajectory message.");
    receive_traj_ = false;
    return;
  }

  traj_msg_ = *msg;
  start_time_ = msg->header.stamp;
  if (start_time_.isZero())
    start_time_ = ros::Time::now();

  traj_id_ = msg->header.seq;
  receive_traj_ = true;
}

bool extractPoint(const trajectory_msgs::MultiDOFJointTrajectoryPoint &pt,
                  Eigen::Vector3d &pos,
                  Eigen::Vector3d &vel,
                  Eigen::Vector3d &acc,
                  double &yaw,
                  double &yawdot)
{
  if (pt.transforms.empty())
    return false;

  const auto &t = pt.transforms.front();
  pos.x() = t.translation.x;
  pos.y() = t.translation.y;
  pos.z() = t.translation.z;
  yaw = yawFromQuat(t.rotation);

  if (!pt.velocities.empty())
  {
    const auto &v = pt.velocities.front();
    vel.x() = v.linear.x;
    vel.y() = v.linear.y;
    vel.z() = v.linear.z;
    yawdot = v.angular.z;
  }
  else
  {
    vel.setZero();
    yawdot = 0.0;
  }

  if (!pt.accelerations.empty())
  {
    const auto &a = pt.accelerations.front();
    acc.x() = a.linear.x;
    acc.y() = a.linear.y;
    acc.z() = a.linear.z;
  }
  else
  {
    acc.setZero();
  }

  return true;
}

void cmdCallback(const ros::TimerEvent &)
{
  if (!receive_traj_)
    return;

  ros::Time time_now = ros::Time::now();
  double t_cur = (time_now - start_time_).toSec();

  if (t_cur < 0.0)
    return;

  const auto &points = traj_msg_.points;
  if (points.empty())
    return;

  size_t idx = 0;
  double t_point = points[0].time_from_start.toSec();
  while (idx + 1 < points.size() && t_cur > t_point)
  {
    ++idx;
    t_point = points[idx].time_from_start.toSec();
  }

  Eigen::Vector3d pos(Eigen::Vector3d::Zero());
  Eigen::Vector3d vel(Eigen::Vector3d::Zero());
  Eigen::Vector3d acc(Eigen::Vector3d::Zero());
  double yaw = 0.0;
  double yawdot = 0.0;

  if (idx == 0 || points.size() == 1)
  {
    extractPoint(points.front(), pos, vel, acc, yaw, yawdot);
  }
  else if (idx >= points.size())
  {
    extractPoint(points.back(), pos, vel, acc, yaw, yawdot);
  }
  else
  {
    const auto &pt_prev = points[idx - 1];
    const auto &pt_curr = points[idx];
    double t_prev = pt_prev.time_from_start.toSec();
    double t_curr = pt_curr.time_from_start.toSec();
    double dt = t_curr - t_prev;
    double ratio = 0.0;
    if (dt > 1e-6)
      ratio = clamp01((t_cur - t_prev) / dt);

    Eigen::Vector3d pos_prev(Eigen::Vector3d::Zero());
    Eigen::Vector3d vel_prev(Eigen::Vector3d::Zero());
    Eigen::Vector3d acc_prev(Eigen::Vector3d::Zero());
    double yaw_prev = 0.0;
    double yawdot_prev = 0.0;

    Eigen::Vector3d pos_curr(Eigen::Vector3d::Zero());
    Eigen::Vector3d vel_curr(Eigen::Vector3d::Zero());
    Eigen::Vector3d acc_curr(Eigen::Vector3d::Zero());
    double yaw_curr = 0.0;
    double yawdot_curr = 0.0;

    if (!extractPoint(pt_prev, pos_prev, vel_prev, acc_prev, yaw_prev, yawdot_prev) ||
        !extractPoint(pt_curr, pos_curr, vel_curr, acc_curr, yaw_curr, yawdot_curr))
    {
      return;
    }

    pos = pos_prev + ratio * (pos_curr - pos_prev);
    vel = vel_prev + ratio * (vel_curr - vel_prev);
    acc = acc_prev + ratio * (acc_curr - acc_prev);

    double yaw_diff = normalizeAngle(yaw_curr - yaw_prev);
    yaw = normalizeAngle(yaw_prev + ratio * yaw_diff);
    yawdot = yawdot_prev + ratio * (yawdot_curr - yawdot_prev);
  }

  cmd.header.stamp = time_now;
  cmd.header.frame_id = "world";
  cmd.trajectory_flag = quadrotor_msgs::PositionCommand::TRAJECTORY_STATUS_READY;
  cmd.trajectory_id = traj_id_;

  cmd.position.x = pos(0);
  cmd.position.y = pos(1);
  cmd.position.z = pos(2);

  cmd.velocity.x = vel(0);
  cmd.velocity.y = vel(1);
  cmd.velocity.z = vel(2);

  cmd.acceleration.x = acc(0);
  cmd.acceleration.y = acc(1);
  cmd.acceleration.z = acc(2);

  cmd.yaw = yaw;
  cmd.yaw_dot = yawdot;

  pos_cmd_pub.publish(cmd);
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "traj_server");
  ros::NodeHandle node;

  ros::Subscriber traj_sub = node.subscribe("rmf_obelix/command/trajectory", 10, trajCallback);
  (void)traj_sub;

  pos_cmd_pub = node.advertise<quadrotor_msgs::PositionCommand>("/position_cmd", 50);
  ros::Timer cmd_timer = node.createTimer(ros::Duration(0.01), cmdCallback);
  (void)cmd_timer;

  cmd.kx[0] = pos_gain[0];
  cmd.kx[1] = pos_gain[1];
  cmd.kx[2] = pos_gain[2];

  cmd.kv[0] = vel_gain[0];
  cmd.kv[1] = vel_gain[1];
  cmd.kv[2] = vel_gain[2];

  ros::Duration(1.0).sleep();
  ROS_WARN("[Traj server]: ready.");

  ros::spin();
  return 0;
}
