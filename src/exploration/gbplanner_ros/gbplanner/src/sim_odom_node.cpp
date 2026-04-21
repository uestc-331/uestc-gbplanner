#include <ros/ros.h>
#include <gazebo_msgs/ModelStates.h>
#include <tf/transform_listener.h>
#include <tf/tf.h> // 添加此行
#include <nav_msgs/Odometry.h>

ros::Publisher odom_pub;
nav_msgs::Odometry init_pose_;
bool init_odom_flag_ = true;

void poseCallback(const gazebo_msgs::ModelStates::ConstPtr &msg)
{
  // 根据机器人名称查找对应的位姿信息
  std::string robotName = "iris_0"; // 替换为您的机器人名称
  int index = -1;

  for (int i = 0; i < msg->name.size(); ++i)
  {
    if (msg->name[i] == robotName)
    {
      index = i;
      break;
    }
  }

  if (index >= 0)
  {
    geometry_msgs::Pose pose = msg->pose[index];
    // 在这里可以获取机器人的真实位姿信息
    double x = pose.position.x;
    double y = pose.position.y;
    double z = pose.position.z;

    // 从四元数中获取机器人的姿态信息
    tf::Quaternion quat;
    tf::quaternionMsgToTF(pose.orientation, quat);
    double roll, pitch, yaw;
    tf::Matrix3x3(quat).getRPY(roll, pitch, yaw);

    // 发布odom消息
    nav_msgs::Odometry odom;

    odom.header.stamp = ros::Time::now();
    odom.header.frame_id = "world";
    // odom.header.frame_id = "map";
    odom.child_frame_id = "base_link";
    odom.pose.pose.position.x = x;
    odom.pose.pose.position.y = y;
    odom.pose.pose.position.z = z;
    odom.pose.pose.orientation.x = quat.x();
    odom.pose.pose.orientation.y = quat.y();
    odom.pose.pose.orientation.z = quat.z();
    odom.pose.pose.orientation.w = quat.w();

    if (init_odom_flag_)
    {
      init_pose_ = odom;
      init_odom_flag_ = false;
    }
    // odom.pose.pose.position.x = odom.pose.pose.position.x - init_pose_.pose.pose.position.x;
    // odom.pose.pose.position.y = odom.pose.pose.position.y - init_pose_.pose.pose.position.y;
    // odom.pose.pose.position.z = odom.pose.pose.position.z - init_pose_.pose.pose.position.z;

    odom_pub.publish(odom);

    // 打印机器人的真实位姿信息
    // ROS_INFO("Robot Ground Truth: x=%f, y=%f, z=%f, roll=%f, pitch=%f, yaw=%f", x, y, z, roll, pitch, yaw);
  }
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "robot_ground_truth");
  ros::NodeHandle nh;

  ros::Subscriber poseSub = nh.subscribe("/gazebo/model_states", 10, poseCallback);
  odom_pub = nh.advertise<nav_msgs::Odometry>("/iris_0/mavros/vision_odom/odom", 10);
  ros::spin();

  return 0;
}
