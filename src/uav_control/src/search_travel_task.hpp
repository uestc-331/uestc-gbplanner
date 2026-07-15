#ifndef _CIRCLE_TRAVEL_TASK_H
#define _CIRCLE_TRAVEL_TASK_H

#if __INTELLISENSE__
#undef __ARM_NEON
#undef __ARM_NEON__
#endif

#include <ros/ros.h>
#include <queue>
#include <vector>
#include <mavros_msgs/RCIn.h>
#include <nav_msgs/Odometry.h>
#include <nav_msgs/Path.h>
#include <geometry_msgs/PoseStamped.h>
#include <quadrotor_msgs/TakeoffLand.h>
#include <eigen3/Eigen/Core>
#include <eigen3/Eigen/Geometry>
#include <std_msgs/String.h>
#include <string>
#include <geometry_msgs/PoseArray.h>
#include <geometry_msgs/Quaternion.h>
#include <tf/transform_datatypes.h>
#include <mutex>
#include <quadrotor_msgs/PositionCommand.h>
#include <std_msgs/UInt32.h>

#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/State.h>

#define CAMERA_FX 607.4056396484375
#define CAMERA_FY 606.4461669921875
#define CAMERA_CX 319.19927978515625
#define CAMERA_CY 234.546142578125

#define REACH_DISTANCE 0.7
#define TRAVEL_DISTANCE 0.8
#define DETECT_DISTANCE 2.0
#define RQTIO_VECTOR_LENGTH 3

#define PURPLE "\x1b[35m" // Purple
#define BLUE "\x1b[34m"   // Blue
#define GREEN "\x1b[32m"  // Green
#define GREEN1 "\x1b[36m" // Green

// ANSI color code for resetting text color to default
#define COLOR_RESET "\x1b[0m"

enum droneStatusEnum
{
    PROTECT,
    TAKEOFF,
    AUTO,
    LAND,
    MANUL,
    HOVER
};

enum autoTravelStateEnum
{
    TRAVEL,
    SEARCHING_1, // 搜索目标一
    SEARCHING_2, // 搜素目标二
    RETURN,      // 返回旋翼模式区域切换降落锁浆
};

enum refPosType
{
    SUB = 1,
    MUNAL
};

class searchTravel
{
private:
    // 静态变量用于记录最低点
    float min_target_x = std::numeric_limits<float>::max();
    geometry_msgs::PoseStamped locked_min_pose;
    bool redetect_flag = false;
    bool vtol_is_armed = false; // 获取vtol的armed状态
    ros::Time last_detection_time_;
    ros::Time time_start;
    int fly_mode_;
    double takeoff_height_, limit_height;
    bool takeoff_flag_ = false;
    bool reach_aim_point_flag_ = false;
    bool launch_flag_ = false;
    bool land_flag = false;
    bool init_odom_flag_ = true; // 初始化odom标志位=
    std::vector<double> ratio_vector_;
    ros::Publisher ego_goal_point_pub_, drone_takeoff_pub_, img_detect_pub_;
    ros::Publisher circle_pos_world_pub_, detect_pos_pub_, vision_pose_for_px4_, local_pos_px4_pub_, mission_state_pub_, drone_takeoff_land_pub_;
    ros::Publisher pos_cmd_pub, travel_goal_pub;
    ros::Publisher healthy_pos_pub_, bad_pos_pub_, force_pos_pub;
    ros::Subscriber visual_odom_sub_, rc_sub_, image_sub_, ref_pos_sub_, ego_pose_sub_, state_sub_, px4ctrl_state_sub_, target1_pos_sub_, target2_pos_sub_, vtol_state_sub_, first_pos_sub_;
    ros::Subscriber travel_path_sub;
    ros::ServiceClient arming_client_, set_mode_client_;
    bool publish_position_cmd_ = true;
    std::string position_cmd_topic_ = "/position_cmd";
    // std::vector<circleMsg> circle_msg_ref_;                  // 圈的位姿参考值
    // std::vector<circleMsg> circle_msg_res_;                  // 目标检测中世界坐标
    // std::vector<circleMsg> circle_msg_mid_;                  // 提前对位用的中间点
    nav_msgs::Odometry drone_odom_;                                                         // 无人机使用的odom
    nav_msgs::Odometry visual_odom_;                                                        // 视觉里程计
    geometry_msgs::PoseStamped drone_target_pose_;                                          // 无人机的目标点
    geometry_msgs::PoseStamped circle_target_pose_;                                         // 目标圈的目标点
    geometry_msgs::PoseStamped ego_pose_, init_pose_;                                       //
    geometry_msgs::Pose target1_pose_, target2_pose_, last_valid_target_pose_, first_pose_; // 目标一和目标二的位姿
    quadrotor_msgs::PositionCommand force_position_cmd_;                                    // 无人机位置指令
    mavros_msgs::RCIn rc_msg_;                                                              // 遥控器模式
    geometry_msgs::PoseStamped remote_pose_;                                                // 遥控器模式下目标位置
    mavros_msgs::State mavros_current_state_;
    droneStatusEnum drone_mode_, last_mode_ = PROTECT; // 无人机模式 由遥控器SWB控制
    autoTravelStateEnum auto_travel_state_ = TRAVEL;   // 自动巡航状态
    int circle_num_ = 0, circle_count_ = 0;            // 记录当前在第几个障碍以及圈的总数
    int point_num = 0;
    double mid_point_yaw_record;
    std::vector<geometry_msgs::PoseStamped> travel_waypoints; // 全局目标点
    unsigned int current_idx = 0;                             // 当前全局目标点索引

    void
    droneFdbUpdate(void); // 更新无人机反馈信息
    // void circlePosionWorldUpdate(void); //更新障碍圈世界坐标
    void droneStateUpdate(void);   // 更新无人机状态 主要是最大速度、控制参数
    void droneSetGoalPosion(void); // 更新无人机的目标点
    // bool droneReachedLocation(cv::Point3f circle_taget, nav_msgs::Odometry fdb, double distance_dxyz);
    bool droneReachedLocation_xy(geometry_msgs::Pose ref, geometry_msgs::Pose fdb, double distance_dxyz);
    bool droneReachedLocation_xy(nav_msgs::Odometry ref, geometry_msgs::Pose fdb, double distance_dxyz);
    void visualOdometryCallBack(const nav_msgs::Odometry &msg);
    void rcMsgCallBack(const mavros_msgs::RCInConstPtr msg);
    // void refPosCallBack(const airsim_ros::CirclePosesConstPtr& circle_pose);
    void refPosCallBack(const geometry_msgs::PoseArray::ConstPtr &circle_pose);
    void egoPoseCallBack(const quadrotor_msgs::PositionCommand::ConstPtr &msg);
    void target1PosCallBack(const geometry_msgs::Pose::ConstPtr &msg);
    void target2PosCallBack(const geometry_msgs::Pose::ConstPtr &msg);
    void stateCallBack(const mavros_msgs::State::ConstPtr &msg);
    void vtolStateCallBack(const mavros_msgs::State::ConstPtr &msg);
    void waypointsCallback(const nav_msgs::Path::ConstPtr &msg);
    void firstPointPosCallBack(const geometry_msgs::Pose::ConstPtr &msg);
    void publishForcePositionCommand(void);
    void set_hov_with_rc(void);
    double quat2yaw(geometry_msgs::Quaternion q);
    geometry_msgs::Quaternion oula2quat(double roll, double pitch, double yaw);
    void Px4ctrlStateCallback(const std_msgs::UInt32 &msg);
    void set_px4_mode(int msg);
    bool target1_is_received(const ros::Time &now_time);

public:
    enum State_t
    {
        MANUAL_CTRL = 1, // px4ctrl is deactived. FCU is controled by the remote controller only
        AUTO_HOVER,      // px4ctrl is actived, it will keep the drone hover from odom measurments while waiting for commands from PositionCommand topic.
        CMD_CTRL,        // px4ctrl is actived, and controling the drone.
        AUTO_TAKEOFF,
        AUTO_LAND,
        STEREO_TRACK,
        TURN_DIRECTION
    };
    State_t px4ctrl_mode = MANUAL_CTRL;
    searchTravel(ros::NodeHandle &nh);
    ~searchTravel() {}
    void searchTravelTask(void);
    void setTarget(geometry_msgs::PoseStamped target) { drone_target_pose_ = target; }
    bool securityCheck(double limitAngle);
    double configCircleDiameter(int circle_num);
    double getDifAngle(double angle1, double angle2);
    bool detectRantLaunch(void);
};

#endif
