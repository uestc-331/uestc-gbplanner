#include "sensor_process_task.hpp"

sensorProcess::sensorProcess(ros::NodeHandle &nh)
{
    // mocap_pos_sub_ = nh.subscribe("/iris_0/mavros/vision_pose/pose",
    //                               10, &sensorProcess::mocapPosCallBack, this);
    // mocap_pos_sub_ = nh.subscribe("/iris_0/mavros/odometry/in",
    //                               10, &sensorProcess::mocapPosCallBack, this);

    mocap_odom_sub_ = nh.subscribe("/iris_0/mavros/odometry/in",
                                   1, &sensorProcess::mocapOdomCallBack, this);
    // 健康人员初始位置from固定翼
    target1_pos1_sub_ = nh.subscribe("/zhihang2025/third_man/pose",
                                     1, &sensorProcess::target1Pos1CallBack, this);
    // 健康人员实时位置from识别
    target1_pos2_sub_ = nh.subscribe("/iris_0/platform_pose/gray_platform",
                                     1, &sensorProcess::target1Pos2CallBack, this);

    // 危重人员初始位置from固定翼
    target2_pos1_sub_ = nh.subscribe("/zhihang2025/first_man/pose",
                                     1, &sensorProcess::target2Pos1CallBack, this);
    // 危重人员实时位置from识别
    target2_pos2_sub_ = nh.subscribe("/iris_0/platform_pose/red_platform",
                                     1, &sensorProcess::target2Pos2CallBack, this);
    // vrpn_target_vel_sub_ = nh.subscribe("/vrpn_client_node/mark1/twist",
    //                               10, &sensorProcess::targetVelCallBack,this);

    mocap_odom_pub_ = nh.advertise<nav_msgs::Odometry>("/vins_fusion/imu_propagate", 1);
    target1_pos_pub_ = nh.advertise<geometry_msgs::Pose>("/target1_pose", 1);
    target2_pos_pub_ = nh.advertise<geometry_msgs::Pose>("/target2_pose", 1);
    multirotor_path_pub_ = nh.advertise<nav_msgs::Path>("/multirotor_path", 1);
}

void sensorProcess::processTask(void)
{
    if (mocap_odom_.pose.pose.position.x != 0)
    {
        mocap_odom_pub_.publish(mocap_odom_);
    }
    if (target1_pos_.position.x != 0)
    {
        target1_pos_pub_.publish(target1_pos_);
    }
    if (target2_pos_.position.x != 0)
    {
        target2_pos_pub_.publish(target2_pos_);
    }
}

void sensorProcess::mocapOdomCallBack(const nav_msgs::OdometryConstPtr &msg)
{
    // 严格检查 twist.covariance 是否满足 36 个元素
    if (msg->twist.covariance.size() != 36)
    {
        ROS_ERROR_STREAM("Dropped odometry message: twist.covariance size = "
                         << msg->twist.covariance.size() << " (expected 36)");
        // return; // 丢弃这条消息
    }
    mocap_odom_.pose.pose = msg->pose.pose;
    mocap_odom_.twist.twist = msg->twist.twist;
    // mocap_odom_.pose.covariance.assign(0.0); // 清除位置协方差
    mocap_odom_.header.stamp = ros::Time::now();
    mocap_odom_.header.frame_id = "world";

    // 转发path用于rviz,取1/3的频率
    if (++frame_cnt % 3 != 0)
        return;
    geometry_msgs::PoseStamped poses_for_mul;
    multirotor_path_.header = mocap_odom_.header;
    poses_for_mul.pose = msg->pose.pose;
    multirotor_path_.poses.push_back(poses_for_mul);
    multirotor_path_pub_.publish(multirotor_path_);
}

void sensorProcess::target1Pos1CallBack(const geometry_msgs::PoseConstPtr &msg)
{
    if (init_target1_flag_)
    {
        // ROS_INFO("T1P1");
        target1_pos_.position.x = msg->position.x;
        target1_pos_.position.y = msg->position.y;
        target1_pos_.position.z = 5;
        target1_pos_.orientation.x = msg->orientation.x;
        target1_pos_.orientation.y = msg->orientation.y;
        target1_pos_.orientation.z = msg->orientation.z;
        target1_pos_.orientation.w = msg->orientation.w;
    }
}

void sensorProcess::target1Pos2CallBack(const geometry_msgs::PoseConstPtr &msg)
{
    if (init_target1_flag_)
        init_target1_flag_ = false;
    if (!init_target1_flag_)
    {
        // ROS_INFO("T1P2");
        target1_pos_.position.x = msg->position.x;
        target1_pos_.position.y = msg->position.y;
        target1_pos_.position.z = msg->position.z;
        target1_pos_.orientation.x = msg->orientation.x;
        target1_pos_.orientation.y = msg->orientation.y;
        target1_pos_.orientation.z = msg->orientation.z;
        target1_pos_.orientation.w = msg->orientation.w;
    }
}

void sensorProcess::target2Pos1CallBack(const geometry_msgs::PoseConstPtr &msg)
{
    if (init_target2_flag_)
    {
        target2_pos_.position.x = msg->position.x;
        target2_pos_.position.y = msg->position.y;
        target2_pos_.position.z = 5;
        target2_pos_.orientation.x = msg->orientation.x;
        target2_pos_.orientation.y = msg->orientation.y;
        target2_pos_.orientation.z = msg->orientation.z;
        target2_pos_.orientation.w = msg->orientation.w;
        // ROS_INFO("T2P1");
    }
}

void sensorProcess::target2Pos2CallBack(const geometry_msgs::PoseConstPtr &msg)
{
    if (init_target2_flag_)
        init_target2_flag_ = false;
    if (!init_target2_flag_)
    {
        // ROS_INFO("T2P2");
        target2_pos_.position.x = msg->position.x;
        target2_pos_.position.y = msg->position.y;
        target2_pos_.position.z = msg->position.z;
        target2_pos_.orientation.x = msg->orientation.x;
        target2_pos_.orientation.y = msg->orientation.y;
        target2_pos_.orientation.z = msg->orientation.z;
        target2_pos_.orientation.w = msg->orientation.w;
    }
}

void sensorProcess::targetVelCallBack(const geometry_msgs::TwistStampedConstPtr &msg)
{
    target_vel_.twist.linear.x = msg->twist.linear.x;
    target_vel_.twist.linear.y = msg->twist.linear.y;
    target_vel_.twist.linear.z = msg->twist.linear.z;

    target_vel_.twist.angular.x = msg->twist.angular.x;
    target_vel_.twist.angular.y = msg->twist.angular.y;
    target_vel_.twist.angular.z = msg->twist.angular.z;
}