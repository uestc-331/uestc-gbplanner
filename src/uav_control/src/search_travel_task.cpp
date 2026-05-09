#include "search_travel_task.hpp"

void searchTravel::searchTravelTask(void)
{
    droneFdbUpdate(); // 1.无人机所需的反馈信息更新 里程计等
    // circlePosionWorldUpdate();
    // signal_generator(1.0,1.0);

    if (drone_mode_ == LAND)
    {
        quadrotor_msgs::TakeoffLand land_msg;
        land_msg.takeoff_land_cmd = 2;
        drone_takeoff_land_pub_.publish(land_msg); // 发布起飞命令给底层无人机控制器
        std_msgs::UInt32 mission_state;
        mission_state.data = 5;                    // MANUAL_CTRL = 1, AUTO_HOVER=2, CMD_CTRL=3,AUTO_TAKEOFF=4,AUTO_LAND=5
        mission_state_pub_.publish(mission_state); // 发送状态到px4ctrl
        // ROS_INFO("drone_mode:LAND");
    }
    else if (drone_mode_ == TAKEOFF) // 起飞模式
    {
        quadrotor_msgs::TakeoffLand takeoff_msg;
        takeoff_msg.takeoff_land_cmd = 1;
        drone_takeoff_land_pub_.publish(takeoff_msg); // 发布起飞命令给底层无人机控制器

        set_px4_mode(4);

        // ROS_INFO("px4ctrlmode: %d", px4ctrl_mode);
        if (px4ctrl_mode == AUTO_HOVER)
        {

            drone_mode_ = AUTO; // 如果px4是命令控制模式，则切换到自动模式
        }
        // ROS_INFO("drone_mode:TAKEOFF");
    }
    else if (drone_mode_ == AUTO) // 自动模式
    {
        // set_px4_mode(2);
        // droneSetGoalPosion(); // 设置无人机目标点

        // ROS_WARN("YAW: %lf", quat2yaw(drone_odom_.pose.pose.orientation));

        // ROS_INFO("drone_mode:AUTO");
    }
    else if (drone_mode_ == HOVER) // 悬停模式
    {
        std_msgs::UInt32 mission_state;
        mission_state.data = 2;                    // MANUAL_CTRL = 1, AUTO_HOVER=2, CMD_CTRL=3,AUTO_TAKEOFF=4,AUTO_LAND=5
        mission_state_pub_.publish(mission_state); // 发送状态到px4ctrl
        ROS_INFO(PURPLE "drone_mode:HOVER" COLOR_RESET);
    }
}

searchTravel::searchTravel(ros::NodeHandle &nh) //: circle_detection_(nh)
{
    nh.param("publish_position_cmd", publish_position_cmd_, true);
    nh.param<std::string>("position_cmd_topic", position_cmd_topic_, "/position_cmd");

    drone_takeoff_land_pub_ = nh.advertise<quadrotor_msgs::TakeoffLand>("/px4ctrl/takeoff_land", 1); // 发布起飞命令
    // vision_pose_for_px4_ = nh.advertise<geometry_msgs::PoseStamped>("/iris_0/mavros/vision_pose/pose", 10);
    detect_pos_pub_ = nh.advertise<geometry_msgs::PoseStamped>("/circle_pos_world_test", 1);
    // local_pos_px4_pub_ = nh.advertise<geometry_msgs::PoseStamped>("/iris_0/mavros/setpoint_position/local", 10);
    px4ctrl_state_sub_ = nh.subscribe("/px4ctrl_state", 1, &searchTravel::Px4ctrlStateCallback, this); // 接收送px4ctrl当前状态
    mission_state_pub_ = nh.advertise<std_msgs::UInt32>("/mission_state", 1);                          // 发送任务飞行的状态
    visual_odom_sub_ = nh.subscribe("/vins_fusion/imu_propagate", 1, &searchTravel::visualOdometryCallBack, this);
    // rc_sub_ = nh.subscribe("/mavros/rc/in",1,&searchTravel::rcMsgCallBack,this);
    rc_sub_ = nh.subscribe("/iris_0/mavros/rc/in", 1, &searchTravel::rcMsgCallBack, this);
    // ego_pose_sub_ = nh.subscribe("/position_cmd", 10, &searchTravel::egoPoseCallBack, this);

    // 创建一个客户端，该客户端用来请求PX4无人机的解锁
    arming_client_ = nh.serviceClient<mavros_msgs::CommandBool>("/iris_0/mavros/cmd/arming");
    // 创建一个客户端，该客户端用来请求进入offboard模式
    set_mode_client_ = nh.serviceClient<mavros_msgs::SetMode>("/iris_0/mavros/set_mode");

    if (publish_position_cmd_)
    {
        force_pos_pub = nh.advertise<quadrotor_msgs::PositionCommand>(position_cmd_topic_, 1);
        ROS_INFO("[uav_control] publishing PositionCommand on %s", position_cmd_topic_.c_str());
    }
    else
    {
        ROS_WARN("[uav_control] PositionCommand publisher disabled; trajectory bridge owns /position_cmd.");
    }
    travel_path_sub = nh.subscribe("/waypoints", 1, &searchTravel::waypointsCallback, this, ros::TransportHints().tcpNoDelay().reliable().maxDatagramSize(52428800));
    travel_goal_pub = nh.advertise<geometry_msgs::PoseStamped>("/global_goal", 1);
    pos_cmd_pub = nh.advertise<geometry_msgs::PoseStamped>("/ego_planner/goal_point", 1);

    first_pos_sub_ = nh.subscribe("/zhihang/first_point", 1, &searchTravel::firstPointPosCallBack, this);
    target1_pos_sub_ = nh.subscribe("/target1_pose", 1, &searchTravel::target1PosCallBack, this);
    target2_pos_sub_ = nh.subscribe("/target2_pose", 1, &searchTravel::target2PosCallBack, this);
    healthy_pos_pub_ = nh.advertise<geometry_msgs::Pose>("/zhihang2025/iris_healthy_man/pose", 1);
    bad_pos_pub_ = nh.advertise<geometry_msgs::Pose>("/zhihang2025/iris_bad_man/pose", 1);
    // force_pos_pub = nh.advertise<geometry_msgs::Pose>("/xtdrone/iris_0/cmd_pose_enu", 10);

    state_sub_ = nh.subscribe("/iris_0/mavros/state", 1, &searchTravel::stateCallBack, this);
    vtol_state_sub_ = nh.subscribe("/standard_vtol_0/mavros/state", 1, &searchTravel::vtolStateCallBack, this);
}

void searchTravel::publishForcePositionCommand(void)
{
    if (!publish_position_cmd_)
    {
        ROS_WARN_THROTTLE(5.0, "[uav_control] PositionCommand output disabled, skipping force command publish.");
        return;
    }
    force_pos_pub.publish(force_position_cmd_);
}

void searchTravel::stateCallBack(const mavros_msgs::State::ConstPtr &msg)
{
    mavros_current_state_ = *msg;
}

void searchTravel::vtolStateCallBack(const mavros_msgs::State::ConstPtr &msg)
{
    // ROS_INFO("vtol armed: %d", msg->armed);
    if ((!msg->armed) && vtol_is_armed)
    {
        drone_mode_ = TAKEOFF; // 如果vtol状态是armed，则切换到起飞模式
        // ROS_INFO("vtol armed, switch to TAKEOFF mode");
    }
    vtol_is_armed = msg->armed; // 获取vtol的armed状态
}

void searchTravel::set_px4_mode(int msg) // 设置px4状态
{
    std_msgs::UInt32 mission_state;
    mission_state.data = msg;                  // MANUAL_CTRL = 1, AUTO_HOVER=2, CMD_CTRL=3,AUTO_TAKEOFF=4,AUTO_LAND=5,STEREO_TRACK=6
    mission_state_pub_.publish(mission_state); // 发送状态到px4ctrl
}

void searchTravel::Px4ctrlStateCallback(const std_msgs::UInt32 &msg)
{
    int state_int = (int)(msg.data);
    switch (state_int)
    {
    case 1:
        px4ctrl_mode = MANUAL_CTRL;
        break;
    case 2: // 悬停
        px4ctrl_mode = AUTO_HOVER;
        break;
    case 3:
        px4ctrl_mode = CMD_CTRL;
        break;
    case 4: // 起飞
        px4ctrl_mode = AUTO_TAKEOFF;
        break;
    case 5:
        px4ctrl_mode = AUTO_LAND;
        break;
    case 6:
        px4ctrl_mode = STEREO_TRACK;
        break;
    case 7:
        px4ctrl_mode = TURN_DIRECTION;
        break;
    // Handle other values if needed
    default:
        ROS_WARN("Unhandled uint32 value: %u", msg.data);
        // Return a default value or throw an exception
        // state = MANUAL_CTRL;
        break;
    }
}

void searchTravel::droneFdbUpdate(void)
{
    if (visual_odom_.pose.pose.position.x != NULL)
    {
        drone_odom_.pose.pose.position.x = visual_odom_.pose.pose.position.x;
        drone_odom_.pose.pose.position.y = visual_odom_.pose.pose.position.y;
        drone_odom_.pose.pose.position.z = visual_odom_.pose.pose.position.z;
        drone_odom_.pose.pose.orientation = visual_odom_.pose.pose.orientation;
    }
    else
    {
        ROS_ERROR("no visual odom!!!");
    }
}

void searchTravel::egoPoseCallBack(const quadrotor_msgs::PositionCommand::ConstPtr &msg)
{
    ego_pose_.header = msg->header;
    ego_pose_.header.stamp = ros::Time::now();
    ego_pose_.pose.position = msg->position;

    Eigen::AngleAxisd rollAngle(0, Eigen::Vector3d::UnitX());
    Eigen::AngleAxisd pitchAngle(0, Eigen::Vector3d::UnitY());
    Eigen::AngleAxisd yawAngle(msg->yaw, Eigen::Vector3d::UnitZ());

    Eigen::Quaterniond quaternion = yawAngle * pitchAngle * rollAngle;
    ego_pose_.pose.orientation.w = quaternion.w();
    ego_pose_.pose.orientation.x = quaternion.x();
    ego_pose_.pose.orientation.y = quaternion.y();
    ego_pose_.pose.orientation.z = quaternion.z();
    // ROS_ERROR("EGO:%f,%f,%f",ego_pose_buf.pose.position.x,ego_pose_buf.pose.position.y,ego_pose_buf.pose.position.z);
}

void searchTravel::droneSetGoalPosion(void)
{
    switch (auto_travel_state_)
    {
    case TRAVEL: // 巡航模式
    {
        if (droneReachedLocation_xy(drone_odom_, target1_pose_, 3))
        {
            auto_travel_state_ = SEARCHING_1; // 切换到搜索目标一状态
            time_start = ros::Time::now();
            ROS_WARN("switch to SEARCHING_1");
        }

        if (current_idx < travel_waypoints.size())
        {
            force_position_cmd_.position.x = travel_waypoints[current_idx].pose.position.x;
            force_position_cmd_.position.y = travel_waypoints[current_idx].pose.position.y;
            force_position_cmd_.position.z = travel_waypoints[current_idx].pose.position.z;

            double dx = force_position_cmd_.position.x - drone_odom_.pose.pose.position.x;
            double dy = force_position_cmd_.position.y - drone_odom_.pose.pose.position.y;
            if (dx != 0 && dy != 0)
            {
                double yaw_rad = std::atan2(dy, dx);
                if (yaw_rad < 0)
                    yaw_rad += 2 * M_PI; // 确保yaw在0到2π之间
                force_position_cmd_.yaw = yaw_rad;
            }

            if (droneReachedLocation_xy(drone_odom_, travel_waypoints[current_idx].pose, 10.0))
            {
                current_idx++;
            }
            force_position_cmd_.header.stamp = ros::Time::now();
            force_position_cmd_.header.frame_id = "world";
            publishForcePositionCommand();
        }
        else if (!droneReachedLocation_xy(drone_odom_, target1_pose_, 10))
        {
            drone_target_pose_.pose.position.x = target1_pose_.position.x;
            drone_target_pose_.pose.position.y = target1_pose_.position.y;
            drone_target_pose_.pose.position.z = 8;      // 设置无人机目标点
            travel_goal_pub.publish(drone_target_pose_); // 发布无人机目标位置给A*
        }

        break;
    }
    case SEARCHING_1: // 搜索目标一
    {
        // ROS_WARN("SEARCHING_1 mode!!!");
        // 动态更新最低点位置
        if (target1_pose_.position.x < min_target_x)
        {
            min_target_x = target1_pose_.position.x;
            locked_min_pose.pose = target1_pose_; // 锁定当前最低点位置
        }

        // 主控制逻辑
        if (droneReachedLocation_xy(drone_odom_, locked_min_pose.pose, 1.2))
        {
            // // 飞到1.5m高度重置一次识别
            // if (drone_odom_.pose.pose.position.z <= 1.0 && !redetect_flag)
            // {
            //     min_target_x = std::numeric_limits<float>::max(); // 重置最低点为极大值（如2000m）
            //     locked_min_pose.pose.position.x = drone_odom_.pose.pose.position.x;
            //     locked_min_pose.pose.position.y = drone_odom_.pose.pose.position.y;
            //     if ((ros::Time::now() - last_detection_time_).toSec() < 0.3)
            //     {
            //         locked_min_pose.pose = target1_pose_;
            //         redetect_flag = true;
            //     }
            //     else
            //     {
            //         locked_min_pose.pose.position.z = 1.0;
            //     }
            // }
            // 安全时执行降落
            drone_target_pose_.pose.position.x = locked_min_pose.pose.position.x + locked_min_pose.pose.position.z * 0.15;
            drone_target_pose_.pose.position.y = locked_min_pose.pose.position.y;
            drone_target_pose_.pose.position.z = locked_min_pose.pose.position.z + 0.4; // 降低无人机高度
            // 当高度达标且标靶到达最低点附近时触发任务完成
            if (drone_odom_.pose.pose.position.z <= 0.65)
            {
                drone_target_pose_.pose.position.z = 0.6; // 限制无人机高度
                // if (fabs(drone_odom_.pose.pose.position.y - target1_pose_.position.y) < 0.1)
                if (droneReachedLocation_xy(drone_odom_, target1_pose_, 0.2) && target1_is_received(ros::Time::now()))
                {
                    healthy_pos_pub_.publish(target1_pose_);
                    auto_travel_state_ = SEARCHING_2;
                    // ROS_WARN("Target1 completed -------------->switch to SEARCHING_2");
                    ROS_WARN("Target1 time cost: %.2f", (ros::Time::now() - time_start).toSec());
                    time_start = ros::Time::now();
                }
            }
            // 检查目标是否冻结（15秒无变化）或超时
            if ((ros::Time::now() - last_detection_time_).toSec() > 15.0)
            {
                min_target_x = std::numeric_limits<float>::max();         // 重置最低点为极大值（如2000m）
                locked_min_pose.pose.position.z = 8.0;                    // 初始化最低点高度
                locked_min_pose.pose.position.x = first_pose_.position.x; // 初始化最低点位置
                // ROS_WARN("Target frozen or lost! Ascending to 8m for re-search.");
            }

            force_position_cmd_.position.x = drone_target_pose_.pose.position.x;
            force_position_cmd_.position.y = drone_target_pose_.pose.position.y;
            force_position_cmd_.position.z = drone_target_pose_.pose.position.z;
            force_position_cmd_.yaw = 0.0; // 设置无人机位置指令
            force_position_cmd_.header.stamp = ros::Time::now();
            force_position_cmd_.header.frame_id = "world";
            publishForcePositionCommand(); // 强行降低
        }
        else
        {
            // 未到达最低点：向锁定位置巡航
            drone_target_pose_ = locked_min_pose;
            drone_target_pose_.pose.position.z -= 0.5; // 设置无人机目标点
            if (drone_target_pose_.pose.position.z < 4.5)
            {
                drone_target_pose_.pose.position.z = 4.5; // 限制无人机高度
            }
            // 发布无人机目标位置
            if (droneReachedLocation_xy(drone_odom_, drone_target_pose_.pose, 200.0))
            {
                drone_target_pose_.header.frame_id = "world";
                pos_cmd_pub.publish(drone_target_pose_);
            }
        }
        // pos_cmd_pub.publish(drone_target_pose_);
        break;
    }
    case SEARCHING_2: // 搜索目标二
    {
        // ROS_WARN("SEARCHING_2 mode!!!");
        if (droneReachedLocation_xy(drone_odom_, target2_pose_, 1.0))
        {
            drone_target_pose_.pose.position.x = target2_pose_.position.x + target2_pose_.position.z * 0.15;
            drone_target_pose_.pose.position.y = target2_pose_.position.y;
            drone_target_pose_.pose.position.z = target2_pose_.position.z + 0.2; // 设置无人机目标点
            // drone_target_pose_.pose.position.z -= 0.21;
            if (drone_odom_.pose.pose.position.z <= 0.49)
            {
                drone_target_pose_.pose.position.z = 0.45; // 限制无人机高度
                bad_pos_pub_.publish(target2_pose_);       // 发布危重位置
                // ROS_WARN("Target2 completed -------------->switch to RETURN");
                ROS_WARN("Target2 time cost: %.2f", (ros::Time::now() - time_start).toSec());
                auto_travel_state_ = RETURN;
            }
            force_position_cmd_.position.x = drone_target_pose_.pose.position.x;
            force_position_cmd_.position.y = drone_target_pose_.pose.position.y;
            force_position_cmd_.position.z = drone_target_pose_.pose.position.z;
            force_position_cmd_.yaw = 0.0; // 设置无人机位置指令
            force_position_cmd_.header.stamp = ros::Time::now();
            force_position_cmd_.header.frame_id = "world";
            publishForcePositionCommand(); // 强行降低
        }
        else
        {
            drone_target_pose_.pose.position.x = target2_pose_.position.x;
            drone_target_pose_.pose.position.y = target2_pose_.position.y;
            drone_target_pose_.pose.position.z = 5.0;
            // 发布无人机目标位置
            if (droneReachedLocation_xy(drone_odom_, drone_target_pose_.pose, 350.0))
            {
                drone_target_pose_.header.frame_id = "world";
                pos_cmd_pub.publish(drone_target_pose_);
            }
        } // 设置无人机目标点

        // pos_cmd_pub.publish(drone_target_pose_);
        break;
    }
    case RETURN: // 返回旋翼模式区域切换降落锁浆
    {
        if (droneReachedLocation_xy(drone_odom_, init_pose_.pose, 14))
        {
            force_position_cmd_.position.x = init_pose_.pose.position.x;
            force_position_cmd_.position.y = init_pose_.pose.position.y;
            force_position_cmd_.position.z = 5.0; // 设置无人机目标点
            if (droneReachedLocation_xy(drone_odom_, init_pose_.pose, 0.15))
                drone_mode_ = LAND; // 如果无人机到达起飞点附近则进入降落模式
        }
        else
        {
            drone_target_pose_.pose.position.x = init_pose_.pose.position.x;
            drone_target_pose_.pose.position.y = init_pose_.pose.position.y;
            drone_target_pose_.pose.position.z = 5.0;
            travel_goal_pub.publish(drone_target_pose_);

            if (current_idx < travel_waypoints.size())
            {
                force_position_cmd_.position.x = travel_waypoints[current_idx].pose.position.x;
                force_position_cmd_.position.y = travel_waypoints[current_idx].pose.position.y;
                force_position_cmd_.position.z = travel_waypoints[current_idx].pose.position.z;

                if (droneReachedLocation_xy(drone_odom_, travel_waypoints[current_idx].pose, 10.0))
                {
                    current_idx++;
                }

                double dx = force_position_cmd_.position.x - drone_odom_.pose.pose.position.x;
                double dy = force_position_cmd_.position.y - drone_odom_.pose.pose.position.y;
                if (dx != 0 && dy != 0)
                {
                    double yaw_rad = std::atan2(dy, dx);
                    if (yaw_rad < 0)
                        yaw_rad += 2 * M_PI; // 确保yaw在0到2π之间
                    force_position_cmd_.yaw = yaw_rad;
                }
            }
        }
        // 发布无人机目标位置
        force_position_cmd_.header.stamp = ros::Time::now();
        force_position_cmd_.header.frame_id = "world";
        // force_position_cmd_.yaw = M_PI; // 设置无人机位置指令
        // if (droneReachedLocation_xy(drone_odom_, drone_target_pose_.pose, 100.0))
        // {
        //     force_position_cmd_.yaw = 0;
        // }
        publishForcePositionCommand();
        // pos_cmd_pub.publish(force_position_cmd_);
        break;
    }
    default:
        break;
    }
}

// bool searchTravel::droneReachedLocation(cv::Point3f ref, nav_msgs::Odometry fdb, double distance_dxyz)
// {
//     double dx, dy, dz;
//     dx = fabs(ref.x - fdb.pose.pose.position.x);
//     dy = fabs(ref.y - fdb.pose.pose.position.y);
//     dz = fabs(ref.z - fdb.pose.pose.position.z);
//     if (dx < distance_dxyz && dy < distance_dxyz && dz < distance_dxyz)
//     {
//         return true;
//     }
//     return false;
// }

bool searchTravel::droneReachedLocation_xy(nav_msgs::Odometry ref, geometry_msgs::Pose fdb, double distance_dxyz)
{
    double dx, dy;
    dx = fabs(ref.pose.pose.position.x - fdb.position.x);
    dy = fabs(ref.pose.pose.position.y - fdb.position.y);
    if (dx < distance_dxyz && dy < distance_dxyz)
    {
        return true;
    }
    return false;
}

bool searchTravel::droneReachedLocation_xy(geometry_msgs::Pose ref, geometry_msgs::Pose fdb, double distance_dxyz)
{
    double dx, dy;
    dx = fabs(ref.position.x - fdb.position.x);
    dy = fabs(ref.position.y - fdb.position.y);
    if (dx < distance_dxyz && dy < distance_dxyz)
    {
        return true;
    }
    return false;
}

void searchTravel::visualOdometryCallBack(const nav_msgs::Odometry &msg)
{
    if (init_odom_flag_)
    {
        init_pose_.pose = msg.pose.pose;
        init_odom_flag_ = false;
    }
    geometry_msgs::PoseStamped vins_odom;
    visual_odom_ = msg;
    // 将时间戳设置为与Odometry消息相同
    vins_odom.header.stamp = msg.header.stamp;

    // 将帧ID设置为与Odometry消息相同
    vins_odom.header.frame_id = msg.header.frame_id;

    // 设置vins_odom的姿态信息
    vins_odom.pose = msg.pose.pose;
    // vision_pose_for_px4_.publish(vins_odom);
}

void searchTravel::rcMsgCallBack(const mavros_msgs::RCInConstPtr msg)
{
    rc_msg_ = *msg;
    droneStatusEnum temp = last_mode_;
    if (true)
    {
        // 急停按钮打开 或 不处于指令控制模式
        if (msg->channels.at(6) > 1500)
        {
            temp = PROTECT;
            ROS_INFO("don't set on cmd mode! PROTECT!!!");
        }
        else if (land_flag)
        {
            temp = LAND;
            // ROS_INFO("drone_mode:LAND");
        }
        else if (msg->channels.at(7) < 900)
        {
            temp = PROTECT;
            ROS_ERROR("rc msg error!");
        }
        else if (msg->channels.at(7) < 1400)
        {
            temp = PROTECT;
            // ROS_INFO("drone_mode:PROTECT");
        }
        else if (msg->channels.at(7) < 1900)
        {
            temp = TAKEOFF;
            // ROS_INFO("drone_mode:TAKEOFF");
        }
        else if (msg->channels.at(7) < 2100)
        {
            temp = AUTO;
            // ROS_INFO("drone_mode:AUTO");
        }
        if (temp == last_mode_)
            return;
        else
            drone_mode_ = temp;

        if ((last_mode_ == TAKEOFF && drone_mode_ == PROTECT) || (last_mode_ == AUTO && drone_mode_ == TAKEOFF))
        {
            drone_mode_ = LAND;
            // ROS_INFO("drone_mode:LAND");
            land_flag = true;
        }
        last_mode_ = drone_mode_;
    }

    if (msg->channels.at(4) > 1400)
    {
        drone_mode_ = HOVER;
    }
}

void searchTravel::target1PosCallBack(const geometry_msgs::Pose::ConstPtr &msg)
{
    if (fabs(msg->position.x - last_valid_target_pose_.position.x) > 0.01)
    {
        last_detection_time_ = ros::Time::now();
        last_valid_target_pose_ = *msg;
    }
    target1_pose_ = *msg;
}
void searchTravel::target2PosCallBack(const geometry_msgs::Pose::ConstPtr &msg)
{
    target2_pose_ = *msg;
}

void searchTravel::firstPointPosCallBack(const geometry_msgs::Pose::ConstPtr &msg)
{
    first_pose_.position = msg->position;
}

void searchTravel::waypointsCallback(const nav_msgs::Path::ConstPtr &msg)
{
    // 检查是否与上一次相同
    bool is_same = true;
    if (msg->poses.size() != travel_waypoints.size())
    {
        is_same = false;
    }
    else
    {
        const double tolerance = 1e-5; // 容差
        for (size_t i = 0; i < msg->poses.size(); i++)
        {
            if (!droneReachedLocation_xy(msg->poses[i].pose, travel_waypoints[i].pose, tolerance))
            {
                is_same = false;
                break;
            }
        }
    }

    if (is_same)
    {
        // ROS_INFO("Received same waypoints as last time. Ignoring.");
        return;
    }
    travel_waypoints.clear();
    travel_waypoints = msg->poses;
    current_idx = 0;
}

double searchTravel::quat2yaw(geometry_msgs::Quaternion q)
{
    tf::Quaternion quat_buf; // 四元数转欧拉角
    tf::quaternionMsgToTF(q, quat_buf);
    double target_roll, target_pitch, target_yaw; // 定义存储r\p\y的容器
    quat_buf.normalize();
    tf::Matrix3x3(quat_buf).getRPY(target_roll, target_pitch, target_yaw); // 进行转换
    return target_yaw;
}

geometry_msgs::Quaternion searchTravel::oula2quat(double roll, double pitch, double yaw)
{
    tf::Quaternion tfQuaternion;
    tfQuaternion.setRPY(roll, pitch, yaw);
    // 将tf::Quaternion转换为geometry_msgs::Quaternion
    geometry_msgs::Quaternion quaternion;
    tf::quaternionTFToMsg(tfQuaternion, quaternion);
    return quaternion;
}

bool searchTravel::target1_is_received(const ros::Time &now_time)
{
    return (now_time - last_detection_time_).toSec() < 0.1;
}
