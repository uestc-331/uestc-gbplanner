#ifndef __PX4CTRLFSM_H
#define __PX4CTRLFSM_H

#if __INTELLISENSE__
#undef __ARM_NEON
#undef __ARM_NEON__
#endif

#include <ros/ros.h>
#include <ros/assert.h>

#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <nav_msgs/Odometry.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/CommandLong.h>
#include <mavros_msgs/CommandBool.h>
#include <std_msgs/UInt32.h>
#include <tf/transform_datatypes.h>

#include "input.h"
// #include "ThrustCurve.h"
#include "controller.h"

#define CTRL_MODE 1 // 1为LQR,2为线性控制器

struct AutoTakeoffLand_t
{
	bool landed{true};
	ros::Time toggle_takeoff_land_time;
	std::pair<bool, ros::Time> delay_trigger{std::pair<bool, ros::Time>(false, ros::Time(0))};
	Eigen::Vector4d start_pose;

	static constexpr double MOTORS_SPEEDUP_TIME = 3.0; // motors idle running for 3 seconds before takeoff
	static constexpr double DELAY_TRIGGER_TIME = 2.0;  // Time to be delayed when reach at target height
};

struct mission_state_t
{
	bool is_hover_mode = false;
	bool is_cmd_mode = false;
	bool is_stereo_mode = false;
	bool is_turnyaw_mode = false;
};

struct stereo_state_t
{
	Eigen::Vector3d p;
	Eigen::Quaterniond q;
	ros::Time rcv_stamp;
};

struct turnyaw_state_t
{
	Eigen::Vector3d p;
	Eigen::Quaterniond q;
	ros::Time rcv_stamp;
};

class PX4CtrlFSM
{
public:
	Parameter_t &param;

	RC_Data_t rc_data;
	State_Data_t state_data;
	ExtendedState_Data_t extended_state_data;
	Odom_Data_t odom_data;
	Imu_Data_t imu_data;
	Command_Data_t cmd_data;
	Battery_Data_t bat_data;
	Takeoff_Land_Data_t takeoff_land_data;
	stereo_state_t stereo_data;
	turnyaw_state_t turnyaw_data;

	LinearControl &controller;

	ros::Publisher traj_start_trigger_pub;
	ros::Publisher ctrl_FCU_pub;
	ros::Publisher local_pos_pub;
	ros::Publisher debug_pub; // debug
	ros::Publisher des_position_pub_;
	ros::Publisher px4ctrl_state_pub_;
	ros::ServiceClient set_FCU_mode_srv;
	ros::ServiceClient arming_client_srv;
	ros::ServiceClient reboot_FCU_srv;
	ros::Subscriber mission_state_sub;
	ros::Subscriber steoreoTrack_sub;
	ros::Subscriber turnyaw_sub;

	quadrotor_msgs::Px4ctrlDebug debug_msg; // debug

	Eigen::Vector4d hover_pose;
	ros::Time last_set_hover_pose_time;

	enum State_t
	{
		MANUAL_CTRL = 1, // px4ctrl is deactived. FCU is controled by the remote controller only
		AUTO_HOVER,		 // px4ctrl is actived, it will keep the drone hover from odom measurments while waiting for commands from PositionCommand topic.
		CMD_CTRL,		 // px4ctrl is actived, and controling the drone.
		AUTO_TAKEOFF,
		AUTO_LAND,
		STEREO_TRACK,
		TURN_DIRECTION
	};

	PX4CtrlFSM(Parameter_t &, LinearControl &, ros::NodeHandle &nh);
	void process();
	bool rc_is_received(const ros::Time &now_time);
	bool cmd_is_received(const ros::Time &now_time);
	bool odom_is_received(const ros::Time &now_time);
	bool imu_is_received(const ros::Time &now_time);
	bool bat_is_received(const ros::Time &now_time);
	bool stereo_is_received(const ros::Time &now_time);
	bool turnyaw_is_received(const ros::Time &now_time);
	bool recv_new_odom();
	State_t get_state() { return state; }
	bool get_landed() { return takeoff_land.landed; }
	bool cmd_init_flag = false;
	void publish_pose_ctrl_px4(Desired_State_t des);
	geometry_msgs::Quaternion oula2quat(double roll, double pitch, double yaw);
	// State_t convertUInt32ToEnum(const std_msgs::UInt32 value);

private:
	int ctrl_mode = CTRL_MODE;
	State_t state; // Should only be changed in PX4CtrlFSM::process() function!
	AutoTakeoffLand_t takeoff_land;
	mission_state_t m_state;

	// ---- control related ----
	Desired_State_t get_hover_des();
	Desired_State_t get_cmd_des();

	// ---- auto takeoff/land ----
	void motors_idling(const Imu_Data_t &imu, Controller_Output_t &u);
	void land_detector(const State_t state, const Desired_State_t &des, const Odom_Data_t &odom); // Detect landing
	void set_start_pose_for_takeoff_land(const Odom_Data_t &odom);
	Desired_State_t get_rotor_speed_up_des(const ros::Time now);
	Desired_State_t get_takeoff_land_des(const double speed);
	Desired_State_t get_stereoTrack_des();
	Desired_State_t get_turnyaw_des();

	// ---- tools ----
	void set_hov_with_odom();
	void set_hov_with_rc();

	bool toggle_offboard_mode(bool on_off); // It will only try to toggle once, so not blocked.
	bool toggle_arm_disarm(bool arm);		// It will only try to toggle once, so not blocked.
	void reboot_FCU();

	void publish_bodyrate_ctrl(const Controller_Output_t &u, const ros::Time &stamp);
	void publish_attitude_ctrl(const Controller_Output_t &u, const ros::Time &stamp);
	void publish_pose_ctrl(const Controller_Output_t &u, const ros::Time &stamp);
	void publish_trigger(const nav_msgs::Odometry &odom_msg);
	void publish_des_msg(const Desired_State_t &des);
	void mission_state_Callback(const std_msgs::UInt32 &msg);
	void publish_pose_ctrl_stereo(Desired_State_t des);
	void steoreoTrackCallback(const geometry_msgs::PoseStamped &msg);
	void turnYawposeCallback(const geometry_msgs::PoseStamped &msg);
};

#endif