#include <signal.h>
#include <ros/ros.h>
#include <ros/assert.h>
#include <thread>
#include <iostream>
#include <mutex>

#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <nav_msgs/Odometry.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/CommandLong.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/RCIn.h>
#include <quadrotor_msgs/TakeoffLand.h>
#include <std_msgs/UInt32.h>



#include <iostream>

std::string rc_cmd_ = "start";
std::mutex cmd_mutex_;

void checkCmd(void) {
    std::cout << "Please input mode you want to enter!" << std::endl;
    std::cout << "remote/REMOTE   cmdctl/CMDCTL   auto/AUTO   stop/STOP   qstop/QSTOP   q/Q" << std::endl;
    while (true) {
        std::string input;
        std::cout << "Enter a command (remote, cmdctl): ";
        std::cin >> input;

        if (input == "remote" || input == "REMOTE") {
            // Manual mode
            std::cout << "Executing command remote control" << std::endl;
        } else if (input == "cmdctl" || input == "CMDCTL") {
            // cmd_control
            std::cout << "Executing command cmd control" << std::endl;
        } else if (input == "auto" || input == "AUTO") {
        // cmd_control
        std::cout << "Executing automatic flight mode" << std::endl;
        } else if (input == "stop" || input == "STOP") {
        // cmd_control
        std::cout << "Executing emergency stop!" << std::endl;
        } else if (input == "qstop" || input == "QSTOP") {
        // cmd_control
        std::cout << "Executing exit stop!" << std::endl;
        } else if (input == "Q" || input == "q") {
            std::cout << "EXIT!" << std::endl;
            break;
        } else {
            // 无效的命令
            std::cout << "Invalid command" << std::endl;
            continue;
        }
        // std::lock_guard<std::mutex> lock(cmd_mutex_);
        cmd_mutex_.lock();
        rc_cmd_ = input;
        cmd_mutex_.unlock();
        std::cout << rc_cmd_ << std::endl;
    }
}

int main(int argc, char** argv) {
    
    std::thread inputCmd(checkCmd);

    ros::init(argc, argv, "cmd_ctl_node");
    ros::NodeHandle nh;
    ros::Publisher cmd_ctl_pub = nh.advertise<mavros_msgs::RCIn>("/cmd_ctl_node/rc/in", 10);
    ros::Publisher drone_takeoff_land_pub_ = nh.advertise<quadrotor_msgs::TakeoffLand>("/Ctrl/takeoff_land", 1); // 
    ros::Publisher mission_state_pub_ = nh.advertise<std_msgs::UInt32>("/mission_state", 1);   //发布起飞命令
    mavros_msgs::RCIn cmd;
    cmd.channels.resize(8);
    ros::Rate rc_rate(30);
    while(ros::ok()){
        // std::lock_guard<std::mutex> lock(cmd_mutex_);
        cmd_mutex_.lock();
        std::string rc_cmd_buff = rc_cmd_;
        cmd_mutex_.unlock();
        if(rc_cmd_buff == "stop" || rc_cmd_buff == "STOP"){
            cmd.channels.at(6) = 1999;
        }
        else if (rc_cmd_buff == "qstop" || rc_cmd_buff == "QSTOP"){
            cmd.channels.at(6) = 1000;
        }
        else if (rc_cmd_buff == "remote" || rc_cmd_buff == "REMOTE"){
            // cmd.channels.at(4) = 1500;
            cmd.channels.at(7) = 1500;
            std_msgs::UInt32 mission_state;
            mission_state.data = 4;                  // MANUAL_CTRL = 1, AUTO_HOVER=2, CMD_CTRL=3,AUTO_TAKEOFF=4,AUTO_LAND=5,STEREO_TRACK=6
            mission_state_pub_.publish(mission_state); // 发送状态到px4ctrl
            quadrotor_msgs::TakeoffLand takeoff_msg;
            takeoff_msg.takeoff_land_cmd = 1;
            drone_takeoff_land_pub_.publish(takeoff_msg); // 发布起飞命令给底层无人机控制器
        }
        else if(rc_cmd_buff == "cmdctl" || rc_cmd_buff == "CMDCTL"){
            cmd.channels.at(7) = 1999;
        }
        else if (rc_cmd_buff == "auto" || rc_cmd_buff == "AUTO"){
            // cmd.channels.at(7) = 1500;
            // cmd.channels.at(5) = 1999;
        }
        else if(rc_cmd_buff == "Q" || rc_cmd_buff == "q"){
            break;
        }
        else{
            cmd.channels.at(4) = 1000;
            cmd.channels.at(5) = 1000;
            cmd.channels.at(6) = 1000;
            cmd.channels.at(7) = 1000;
        }
        cmd.header.stamp = ros::Time::now();
        cmd.header.frame_id = "world";
        cmd.channels.at(0) = 1500;
        cmd.channels.at(1) = 1500;
        cmd.channels.at(2) = 1500;
        cmd.channels.at(3) = 1500;
        cmd_ctl_pub.publish(cmd);
        rc_rate.sleep();
    }
    
    inputCmd.join();
    return 0;
}