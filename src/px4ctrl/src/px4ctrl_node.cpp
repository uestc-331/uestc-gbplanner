#include <ros/ros.h>
#include <signal.h>
#include "PX4CtrlFSM.h"

void mySigintHandler(int sig)
{
    ROS_INFO("[PX4Ctrl] exit...");
    ros::shutdown();
}

int main(int argc, char *argv[])
{
    ros::init(argc, argv, "px4ctrl");
    ros::NodeHandle nh("~");

    signal(SIGINT, mySigintHandler);
    ros::Duration(1.0).sleep();

    Parameter_t param;
    param.config_from_ros_handle(nh);

    // Controller controller(param);
    LinearControl controller(param);
    PX4CtrlFSM fsm(param, controller, nh);

    ros::Subscriber state_sub =
        nh.subscribe<mavros_msgs::State>("/iris_0/mavros/state",
                                         10,
                                         boost::bind(&State_Data_t::feed, &fsm.state_data, _1));

    ros::Subscriber extended_state_sub =
        nh.subscribe<mavros_msgs::ExtendedState>("/iris_0/mavros/extended_state",
                                                 10,
                                                 boost::bind(&ExtendedState_Data_t::feed, &fsm.extended_state_data, _1));

    // if(param.use_mocap_ctrl)
    // {
    // ROS_ERROR("pub mocap msg!");
    // ros::Subscriber mocap_pos_sub =
    //     nh.subscribe<geometry_msgs::PoseStamped>("/vrpn_client_node/uav6/pose",
    //                                             100,
    //                                             boost::bind(&Odom_Data_t::mocap_pos_feed, &fsm.odom_data, _1),
    //                                             ros::VoidConstPtr(),
    //                                             ros::TransportHints().tcpNoDelay());

    // ros::Subscriber mocap_vel_sub =
    //     nh.subscribe<geometry_msgs::TwistStamped>("/vrpn_client_node/uav6/twist",
    //                                         100,
    //                                         boost::bind(&Odom_Data_t::mocap_vel_feed, &fsm.odom_data, _1),
    //                                         ros::VoidConstPtr(),
    //                                         ros::TransportHints().tcpNoDelay());
    // }
    // else
    // {
    ros::Subscriber odom_sub =
        nh.subscribe<nav_msgs::Odometry>("/vins_fusion/imu_propagate",
                                         100,
                                         boost::bind(&Odom_Data_t::feed, &fsm.odom_data, _1),
                                         ros::VoidConstPtr(),
                                         ros::TransportHints().tcpNoDelay());
    // }

    ros::Subscriber cmd_sub =
        nh.subscribe<quadrotor_msgs::PositionCommand>("/position_cmd",
                                                      100,
                                                      boost::bind(&Command_Data_t::feed, &fsm.cmd_data, _1),
                                                      ros::VoidConstPtr(),
                                                      ros::TransportHints().tcpNoDelay());

    ros::Subscriber imu_sub =
        nh.subscribe<sensor_msgs::Imu>("/iris_0/mavros/imu/data", // Note: do NOT change it to /iris_0/mavros/imu/data_raw !!!
                                       100,
                                       boost::bind(&Imu_Data_t::feed, &fsm.imu_data, _1),
                                       ros::VoidConstPtr(),
                                       ros::TransportHints().tcpNoDelay());

    ros::Subscriber rc_sub;
    if (!param.takeoff_land.no_RC) // mavros will still publish wrong rc messages although no RC is connected
    {
        rc_sub = nh.subscribe<mavros_msgs::RCIn>("/iris_0/mavros/rc/in",
                                                 10,
                                                 boost::bind(&RC_Data_t::feed, &fsm.rc_data, _1));
    }

    ros::Subscriber bat_sub =
        nh.subscribe<sensor_msgs::BatteryState>("/iris_0/mavros/battery",
                                                100,
                                                boost::bind(&Battery_Data_t::feed, &fsm.bat_data, _1),
                                                ros::VoidConstPtr(),
                                                ros::TransportHints().tcpNoDelay());

    ros::Subscriber takeoff_land_sub =
        nh.subscribe<quadrotor_msgs::TakeoffLand>("/px4ctrl/takeoff_land",
                                                  100,
                                                  boost::bind(&Takeoff_Land_Data_t::feed, &fsm.takeoff_land_data, _1),
                                                  ros::VoidConstPtr(),
                                                  ros::TransportHints().tcpNoDelay());

    fsm.des_position_pub_ = nh.advertise<geometry_msgs::PoseStamped>("/des_position", 10);
    fsm.ctrl_FCU_pub = nh.advertise<mavros_msgs::AttitudeTarget>("/iris_0/mavros/setpoint_raw/attitude", 10);
    // 创建一个发布者，发布"mavros/setpoint_position/local"话题
    fsm.local_pos_pub = nh.advertise<geometry_msgs::PoseStamped>("/iris_0/mavros/setpoint_position/local", 10);
    fsm.traj_start_trigger_pub = nh.advertise<geometry_msgs::PoseStamped>("/traj_start_trigger", 10);

    fsm.debug_pub = nh.advertise<quadrotor_msgs::Px4ctrlDebug>("/debugPx4ctrl", 10); // debug

    fsm.set_FCU_mode_srv = nh.serviceClient<mavros_msgs::SetMode>("/iris_0/mavros/set_mode");
    fsm.arming_client_srv = nh.serviceClient<mavros_msgs::CommandBool>("/iris_0/mavros/cmd/arming");
    fsm.reboot_FCU_srv = nh.serviceClient<mavros_msgs::CommandLong>("/iris_0/mavros/cmd/command");

    ros::Duration(0.5).sleep();

    if (param.takeoff_land.no_RC)
    {
        ROS_WARN("PX4CTRL] Remote controller disabled, be careful!");
    }
    else
    {
        ROS_INFO("PX4CTRL] Waiting for RC");
        while (ros::ok())
        {
            ros::spinOnce();
            if (fsm.rc_is_received(ros::Time::now()))
            {
                ROS_INFO("[PX4CTRL] RC received.");
                break;
            }
            ros::Duration(0.1).sleep();
        }
    }

    int trials = 0;
    while (ros::ok() && !fsm.state_data.current_state.connected)
    {
        ros::spinOnce();
        ros::Duration(1.0).sleep();
        if (trials++ > 5)
            ROS_ERROR("Unable to connnect to PX4!!!");
    }

    ros::Rate r(param.ctrl_freq_max);
    while (ros::ok())
    {
        r.sleep();
        ros::spinOnce();
        fsm.process(); // We DO NOT rely on feedback as trigger, since there is no significant performance difference through our test.
    }

    return 0;
}
