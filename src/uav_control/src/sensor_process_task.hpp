#ifndef _SENSOR_PROCESS_TASK_H
#define _SENSOR_PROCESS_TASK_H

#include <ros/ros.h>
#include <queue>
#include <vector>
#include <nav_msgs/Odometry.h>
#include <nav_msgs/Path.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <sensor_msgs/Image.h>
#include <tf/transform_datatypes.h>

class sensorProcess
{
private:
    void mocapPosCallBack(const geometry_msgs::PoseStampedConstPtr &msg);
    // void mocapPosCallBack(const nav_msgs::OdometryConstPtr &msg);
    // void mocapVelCallBack(const geometry_msgs::TwistStampedConstPtr &msg);
    void mocapOdomCallBack(const nav_msgs::OdometryConstPtr &msg);
    void target1Pos1CallBack(const geometry_msgs::PoseConstPtr &msg);
    void target1Pos2CallBack(const geometry_msgs::PoseConstPtr &msg);
    void target2Pos1CallBack(const geometry_msgs::PoseConstPtr &msg);
    void target2Pos2CallBack(const geometry_msgs::PoseConstPtr &msg);
    void targetVelCallBack(const geometry_msgs::TwistStampedConstPtr &msg);
    ros::Subscriber mocap_pos_sub_, mocap_vel_sub_, mocap_odom_sub_;
    ros::Subscriber target1_pos1_sub_, target1_pos2_sub_, target2_pos1_sub_, target2_pos2_sub_;
    ros::Publisher mocap_odom_pub_, target1_pos_pub_, target2_pos_pub_, multirotor_path_pub_;
    nav_msgs::Path multirotor_path_;
    nav_msgs::Odometry mocap_odom_; // 动捕的定位里程计
    geometry_msgs::PoseStamped target_pos_, init_pose_;
    geometry_msgs::Pose target1_pos_, target2_pos_;
    geometry_msgs::TwistStamped target_vel_;
    std::queue<sensor_msgs::ImageConstPtr> gray_img0_buf_;
    std::queue<sensor_msgs::ImageConstPtr> gray_img1_buf_; // stereo_img
    bool init_odom_flag_ = true;
    bool init_target1_flag_ = true, init_target2_flag_ = true;
    int frame_cnt = 0;

public:
    bool finish_target1_flag_ = false, finish_target2_flag_ = true;
    sensorProcess(ros::NodeHandle &nh);
    ~sensorProcess() {}
    void processTask(void);
    geometry_msgs::PoseStamped getTarget(void) { return target_pos_; }
};

#endif
