#include "PX4CtrlFSM.h"
#include <uav_utils/converters.h>

using namespace std;
using namespace uav_utils;

PX4CtrlFSM::PX4CtrlFSM(Parameter_t &param_, LinearControl &controller_, ros::NodeHandle &nh) : param(param_), controller(controller_) /*, thrust_curve(thrust_curve_)*/
{
	mission_state_sub = nh.subscribe("/mission_state", 1, &PX4CtrlFSM::mission_state_Callback, this);
	steoreoTrack_sub = nh.subscribe("/final_steoreoTrack", 1, &PX4CtrlFSM::steoreoTrackCallback, this);
	turnyaw_sub = nh.subscribe("/turn_yaw_pose", 1, &PX4CtrlFSM::turnYawposeCallback, this);
	px4ctrl_state_pub_ = nh.advertise<std_msgs::UInt32>("/px4ctrl_state", 1); // 发送px4ctrl当前状态
	state = MANUAL_CTRL;
	hover_pose.setZero();
}

/*
		Finite State Machine

		  system start
				|
				|
				v
	----- > MANUAL_CTRL <-----------------
	|         ^   |    \                 |
	|         |   |     \                |
	|         |   |      > AUTO_TAKEOFF  |
	|         |   |        /             |
	|         |   |       /              |
	|         |   |      /               |
	|         |   v     /                |
	|       AUTO_HOVER <                 |
	|         ^   |  \  \                |
	|         |   |   \  \               |
	|         |	  |    > AUTO_LAND -------
	|         |   |
	|         |   v
	-------- CMD_CTRL

*/

void PX4CtrlFSM::process()
{
	ros::Time now_time = ros::Time::now();
	Controller_Output_t u;
	Desired_State_t des(odom_data);
	bool rotor_low_speed_during_land = false;

	// STEP1: state machine runs
	switch (state)
	{
	case MANUAL_CTRL:
	{
		std_msgs::UInt32 px4ctrl_state;
		px4ctrl_state.data = 1;					   // MANUAL_CTRL = 1, AUTO_HOVER=2, CMD_CTRL=3,AUTO_TAKEOFF=4,AUTO_LAND=5
		px4ctrl_state_pub_.publish(px4ctrl_state); // 发送状态到px4ctrl
		if (rc_data.enter_hover_mode)			   // Try to jump to AUTO_HOVER
		{
			if (!odom_is_received(now_time))
			{
				ROS_ERROR("[px4ctrl] Reject AUTO_HOVER(L2). No odom!");
				break;
			}
			if (cmd_is_received(now_time))
			{
				ROS_ERROR("[px4ctrl] Reject AUTO_HOVER(L2). You are sending commands before toggling into AUTO_HOVER, which is not allowed. Stop sending commands now!");
				break;
			}
			if (odom_data.v.norm() > 3.0)
			{
				ROS_ERROR("[px4ctrl] Reject AUTO_HOVER(L2). Odom_Vel=%fm/s, which seems that the locolization module goes wrong!", odom_data.v.norm());
				break;
			}

			state = AUTO_HOVER;
			controller.resetThrustMapping();
			set_hov_with_odom();
			toggle_offboard_mode(true);

			ROS_INFO("\033[32m[px4ctrl] MANUAL_CTRL(L1) --> AUTO_HOVER(L2)\033[32m");
		}
		else if (param.takeoff_land.enable && takeoff_land_data.triggered && takeoff_land_data.takeoff_land_cmd == quadrotor_msgs::TakeoffLand::TAKEOFF) // Try to jump to AUTO_TAKEOFF
		{
			if (!odom_is_received(now_time))
			{
				ROS_ERROR("[px4ctrl] Reject AUTO_TAKEOFF. No odom!");
				break;
			}
			if (cmd_is_received(now_time))
			{
				ROS_ERROR("[px4ctrl] Reject AUTO_TAKEOFF. You are sending commands before toggling into AUTO_TAKEOFF, which is not allowed. Stop sending commands now!");
				break;
			}
			if (odom_data.v.norm() > 0.1)
			{
				ROS_ERROR("[px4ctrl] Reject AUTO_TAKEOFF. Odom_Vel=%fm/s, non-static takeoff is not allowed!", odom_data.v.norm());
				break;
			}
			if (!get_landed())
			{
				ROS_ERROR("[px4ctrl] Reject AUTO_TAKEOFF. land detector says that the drone is not landed now!");
				break;
			}
			if (rc_is_received(now_time)) // Check this only if RC is connected.
			{
				if (!m_state.is_hover_mode || !m_state.is_cmd_mode || !rc_data.check_centered())
				{
					ROS_ERROR("[px4ctrl] Reject AUTO_TAKEOFF. If you have your RC connected, keep its switches at \"auto hover\" and \"command control\" states, and all sticks at the center, then takeoff again.");
					while (ros::ok())
					{
						ros::Duration(0.01).sleep();
						ros::spinOnce();
						if (m_state.is_hover_mode && m_state.is_cmd_mode && rc_data.check_centered())
						{
							ROS_INFO("\033[32m[px4ctrl] OK, you can takeoff again.\033[32m");
							break;
						}
					}
					break;
				}
			}
			// ROS_ERROR("111111111");
			state = AUTO_TAKEOFF;
			controller.resetThrustMapping();
			set_start_pose_for_takeoff_land(odom_data);
			toggle_offboard_mode(true);				  // toggle on offboard before arm
			for (int i = 0; i < 10 && ros::ok(); ++i) // wait for 0.1 seconds to allow mode change by FMU // mark
			{
				ros::Duration(0.01).sleep();
				ros::spinOnce();
			}
			if (param.takeoff_land.enable_auto_arm)
			{
				toggle_arm_disarm(true);
			}
			takeoff_land.toggle_takeoff_land_time = now_time;

			ROS_INFO("\033[32m[px4ctrl] MANUAL_CTRL(L1) --> AUTO_TAKEOFF\033[32m");
		}

		if (rc_data.toggle_reboot) // Try to reboot. EKF2 based PX4 FCU requires reboot when its state estimator goes wrong.
		{
			if (state_data.current_state.armed)
			{
				ROS_ERROR("[px4ctrl] Reject reboot! Disarm the drone first!");
				break;
			}
			reboot_FCU();
		}
		// ROS_ERROR("1111111111111111111111111");
		break;
	}

	case AUTO_HOVER:
	{
		std_msgs::UInt32 px4ctrl_state;
		px4ctrl_state.data = 2;					   // MANUAL_CTRL = 1, AUTO_HOVER=2, CMD_CTRL=3,AUTO_TAKEOFF=4,AUTO_LAND=5
		px4ctrl_state_pub_.publish(px4ctrl_state); // 发送状态到px4ctrl
		const bool hover_mode_ok = param.takeoff_land.no_RC || m_state.is_hover_mode;
		const bool cmd_mode_ok = param.takeoff_land.no_RC || m_state.is_cmd_mode;
		if (!hover_mode_ok || !odom_is_received(now_time))
		{
			state = MANUAL_CTRL;
			toggle_offboard_mode(false);

			ROS_WARN("[px4ctrl] AUTO_HOVER(L2) --> MANUAL_CTRL(L1)");
		}
		else if (cmd_mode_ok && cmd_is_received(now_time))
		{
			if (state_data.current_state.mode == "OFFBOARD")
			{
				state = CMD_CTRL;
				des = get_cmd_des();
				ROS_INFO("\033[32m[px4ctrl] AUTO_HOVER(L2) --> CMD_CTRL(L3)\033[32m");
			}
		}
		else if (m_state.is_stereo_mode && stereo_is_received(now_time))
		{
			if (state_data.current_state.mode == "OFFBOARD")
			{
				state = STEREO_TRACK;
				des = get_stereoTrack_des();
				ROS_INFO("\033[32m[px4ctrl] AUTO_HOVER(L2) --> STEREO_TRACK(L6)\033[32m");
			}
		}
		else if (m_state.is_turnyaw_mode && turnyaw_is_received(now_time))
		{
			if (state_data.current_state.mode == "OFFBOARD")
			{
				state = TURN_DIRECTION;
				des = get_turnyaw_des();
				ROS_INFO("\033[32m[px4ctrl] AUTO_HOVER(L2) --> TURN_DIRECTION(L7)\033[32m");
			}
		}
		else if (takeoff_land_data.triggered && takeoff_land_data.takeoff_land_cmd == quadrotor_msgs::TakeoffLand::LAND)
		{

			state = AUTO_LAND;
			set_start_pose_for_takeoff_land(odom_data);

			ROS_INFO("\033[32m[px4ctrl] AUTO_HOVER(L2) --> AUTO_LAND\033[32m");
		}
		else
		{
			if (param.takeoff_land.no_RC)
			{
				set_hov_with_odom();
			}
			else
			{
				set_hov_with_rc();
			}
			des = get_hover_des(); // 从遥控器中获得期望位置
			if (!cmd_init_flag)
			{
				if ((cmd_mode_ok) ||
					(takeoff_land.delay_trigger.first && now_time > takeoff_land.delay_trigger.second))
				{
					takeoff_land.delay_trigger.first = false;
					publish_trigger(odom_data.msg);
					ROS_INFO("\033[32m[px4ctrl] TRIGGER sent, allow user command.\033[32m");
				}
				cmd_init_flag = true;
			}
			// cout << "des.p=" << des.p.transpose() << endl;
		}
		break;
	}

	case CMD_CTRL:
	{
		std_msgs::UInt32 px4ctrl_state;
		px4ctrl_state.data = 3;					   // MANUAL_CTRL = 1, AUTO_HOVER=2, CMD_CTRL=3,AUTO_TAKEOFF=4,AUTO_LAND=5
		px4ctrl_state_pub_.publish(px4ctrl_state); // 发送状态到px4ctrl
		const bool hover_mode_ok = param.takeoff_land.no_RC || m_state.is_hover_mode;
		const bool cmd_mode_ok = param.takeoff_land.no_RC || m_state.is_cmd_mode;
		if (!hover_mode_ok || !odom_is_received(now_time))
		{
			state = MANUAL_CTRL;
			toggle_offboard_mode(false);

			ROS_WARN("[px4ctrl] From CMD_CTRL(L3) to MANUAL_CTRL(L1)!");
		}
		else if (!cmd_mode_ok || !cmd_is_received(now_time))
		{
			state = AUTO_HOVER;
			set_hov_with_odom();
			des = get_hover_des();
			ROS_INFO("[px4ctrl] From CMD_CTRL(L3) to AUTO_HOVER(L2)!");
		}
		else
		{
			des = get_cmd_des();
		}

		if (takeoff_land_data.triggered && takeoff_land_data.takeoff_land_cmd == quadrotor_msgs::TakeoffLand::LAND)
		{
			ROS_ERROR("[px4ctrl] Reject AUTO_LAND, which must be triggered in AUTO_HOVER. \
					Stop sending control commands for longer than %fs to let px4ctrl return to AUTO_HOVER first.",
					  param.msg_timeout.cmd);
		}

		break;
	}

	case STEREO_TRACK:
	{
		std_msgs::UInt32 px4ctrl_state;
		px4ctrl_state.data = 6;					   // MANUAL_CTRL = 1, AUTO_HOVER=2, CMD_CTRL=3,AUTO_TAKEOFF=4,AUTO_LAND=5
		px4ctrl_state_pub_.publish(px4ctrl_state); // 发送状态到px4ctrl
		if (!m_state.is_hover_mode || !odom_is_received(now_time))
		{
			state = MANUAL_CTRL;
			toggle_offboard_mode(false);

			ROS_WARN("[px4ctrl] From STEREO_TRACK(L6) to MANUAL_CTRL(L1)!");
		}
		else if (!m_state.is_stereo_mode || !stereo_is_received(now_time))
		{
			state = AUTO_HOVER;
			set_hov_with_odom();
			des = get_hover_des();
			ROS_INFO("[px4ctrl] From STEREO_TRACK(L6) to AUTO_HOVER(L2)!");
		}
		// else
		// {
		// 	des = get_stereoTrack_des();
		// }
		break;
	}

	case TURN_DIRECTION:
	{
		std_msgs::UInt32 px4ctrl_state;
		px4ctrl_state.data = 7;					   // MANUAL_CTRL = 1, AUTO_HOVER=2, CMD_CTRL=3,AUTO_TAKEOFF=4,AUTO_LAND=5
		px4ctrl_state_pub_.publish(px4ctrl_state); // 发送状态到px4ctrl
		if (!m_state.is_hover_mode || !odom_is_received(now_time))
		{
			state = MANUAL_CTRL;
			toggle_offboard_mode(false);

			ROS_WARN("[px4ctrl] From TURN_DIRECTION(L7) to MANUAL_CTRL(L1)!");
		}
		else if (!m_state.is_turnyaw_mode || !turnyaw_is_received(now_time))
		{
			state = AUTO_HOVER;
			set_hov_with_odom();
			des = get_hover_des();
			ROS_INFO("[px4ctrl] From TURN_DIRECTION(L7) to AUTO_HOVER(L2)!");
		}
		else
		{
			des = get_turnyaw_des();
		}

		break;
	}

	case AUTO_TAKEOFF:
	{
		std_msgs::UInt32 px4ctrl_state;
		px4ctrl_state.data = 4;																					 // MANUAL_CTRL = 1, AUTO_HOVER=2, CMD_CTRL=3,AUTO_TAKEOFF=4,AUTO_LAND=5
		px4ctrl_state_pub_.publish(px4ctrl_state);																 // 发送状态到px4ctrl
		if ((now_time - takeoff_land.toggle_takeoff_land_time).toSec() < AutoTakeoffLand_t::MOTORS_SPEEDUP_TIME) // Wait for several seconds to warn prople.
		{
			controller.adrc_eso_enable = false;
			des = get_rotor_speed_up_des(now_time);
		}
		else if (odom_data.p(2) >= (takeoff_land.start_pose(2) + param.takeoff_land.height)) // reach the desired height
		{
			controller.adrc_eso_enable = true;
			state = AUTO_HOVER;
			set_hov_with_odom();
			ROS_INFO("\033[32m[px4ctrl] AUTO_TAKEOFF --> AUTO_HOVER(L2)\033[32m");

			takeoff_land.delay_trigger.first = true;
			takeoff_land.delay_trigger.second = now_time + ros::Duration(AutoTakeoffLand_t::DELAY_TRIGGER_TIME);
		}
		else
		{
			controller.adrc_eso_enable = true;
			des = get_takeoff_land_des(param.takeoff_land.speed);
		}

		break;
	}

	case AUTO_LAND:
	{
		std_msgs::UInt32 px4ctrl_state;
		px4ctrl_state.data = 5;					   // MANUAL_CTRL = 1, AUTO_HOVER=2, CMD_CTRL=3,AUTO_TAKEOFF=4,AUTO_LAND=5
		px4ctrl_state_pub_.publish(px4ctrl_state); // 发送状态到px4ctrl
		if (!m_state.is_hover_mode || !odom_is_received(now_time))
		{
			state = MANUAL_CTRL;
			toggle_offboard_mode(false);

			ROS_WARN("[px4ctrl] From AUTO_LAND to MANUAL_CTRL(L1)!");
		}
		// else if (!rc_data.is_command_mode)
		// {
		// 	state = AUTO_HOVER;
		// 	set_hov_with_odom();
		// 	des = get_hover_des();
		// 	ROS_INFO("[px4ctrl] From AUTO_LAND to AUTO_HOVER(L2)!");
		// }
		else if (!get_landed())
		{
			des = get_takeoff_land_des(-param.takeoff_land.speed);
			des.p.x() = des.p.x() + param.takeoff_land.land_bias_x;
			des.p.y() = des.p.y() + param.takeoff_land.land_bias_y;
		}
		else
		{
			rotor_low_speed_during_land = true;

			static bool print_once_flag = true;
			if (print_once_flag)
			{
				ROS_INFO("\033[32m[px4ctrl] Wait for abount 10s to let the drone arm.\033[32m");
				print_once_flag = false;
			}

			// if (extended_state_data.current_extended_state.landed_state == mavros_msgs::ExtendedState::LANDED_STATE_ON_GROUND) // PX4 allows disarm after this
			if (true)
			{
				static double last_trial_time = 0; // Avoid too frequent calls
				// ROS_ERROR("last_trial_time : %f",last_trial_time);
				// ROS_ERROR("now_time : %f",now_time.toSec());
				// ROS_ERROR("wait arm time : %f",now_time.toSec()-last_trial_time);
				if (now_time.toSec() - last_trial_time > 1)
				{
					// ROS_INFO("\033[32m[px4ctrl] 11111111111111111111111111111");
					if (toggle_arm_disarm(false)) // disarm
					{
						print_once_flag = true;
						state = MANUAL_CTRL;
						toggle_offboard_mode(false); // toggle off offboard after disarm
						ROS_INFO("\033[32m[px4ctrl] AUTO_LAND --> MANUAL_CTRL(L1)\033[32m");
					}

					last_trial_time = now_time.toSec();
				}
			}
		}

		break;
	}
	default:
		break;
	}

	// STEP2: estimate thrust model
	if (state == AUTO_HOVER || state == CMD_CTRL)
	{
		// controller.estimateThrustModel(imu_data.a, bat_data.volt, param);
		controller.estimateThrustModel(imu_data.a, param);
	}

	publish_des_msg(des);

	// if(state == AUTO_HOVER || state == CMD_CTRL)
	// {
	// 	publish_pose_ctrl_px4(des);
	// }
	// else if(state == STEREO_TRACK || state == TURN_DIRECTION)
	// {
	// 	publish_pose_ctrl_stereo(des);
	// }
	// else
	// {
	// 			// STEP3: solve and update new control commands
	// 	if (rotor_low_speed_during_land) // used at the start of auto takeoff
	// 	{
	// 		motors_idling(imu_data, u);
	// 	}
	// 	else
	// 	{
	// 		if(param.ctrl_mode == 1)
	// 		{
	// 			debug_msg = controller.DLQR_Control(des, odom_data, imu_data, u);//采用LQR控制器,使用位置控制无法起飞
	// 		}
	// 		if(param.ctrl_mode == 2)
	// 		{
	// 			debug_msg = controller.calculateControl(des, odom_data, imu_data, u);//采用线下控制器
	// 		}
	// 		debug_msg.header.stamp = now_time;
	// 		debug_pub.publish(debug_msg);
	// 	}

	// 	// STEP4: publish control commands to mavros
	// 	if (param.ctrl_type == 1)
	// 	{
	// 		publish_bodyrate_ctrl(u, now_time);
	// 	}
	// 	else if (param.ctrl_type == 2)
	// 	{
	// 		if(state == AUTO_TAKEOFF){
	// 			publish_attitude_ctrl(u, now_time);//
	// 			// publish_pose_ctrl(u, now_time);
	// 		}
	// 		else{
	// 			publish_attitude_ctrl(u, now_time);
	// 		}
	// 	}
	// 	else if (param.ctrl_type == 3){

	// 	}
	// }

	// STEP3: solve and update new control commands
	if (rotor_low_speed_during_land) // used at the start of auto takeoff
	{
		motors_idling(imu_data, u);
	}
	else
	{
		if (param.ctrl_mode == 1)
		{
			debug_msg = controller.DLQR_Control(des, odom_data, imu_data, u); // 采用LQR控制器,使用位置控制无法起飞
		}
		if (param.ctrl_mode == 2)
		{
			debug_msg = controller.calculateControl(des, odom_data, imu_data, u); // 采用线下控制器
		}
		if (param.ctrl_mode == 3)
		{
			debug_msg = controller.ADRC_Control(des, odom_data, imu_data, u); // 采用ADRC控制器
		}
		debug_msg.header.stamp = now_time;
		debug_pub.publish(debug_msg);
	}

	// STEP4: publish control commands to mavros
	// 裁剪异常推力值
	if (u.thrust < 0.0)
		u.thrust = 0.0;
	else if (u.thrust > 1.0)
		u.thrust = 1.0;

	if (param.ctrl_type == 1)
	{
		publish_bodyrate_ctrl(u, now_time);
	}
	else if (param.ctrl_type == 2)
	{
		publish_attitude_ctrl(u, now_time);
	}

	// STEP5: Detect if the drone has landed
	land_detector(state, des, odom_data);
	// cout << takeoff_land.landed << " ";
	// fflush(stdout);

	// STEP6: Clear flags beyound their lifetime
	rc_data.enter_hover_mode = false;
	rc_data.enter_command_mode = false;
	rc_data.toggle_reboot = false;
	takeoff_land_data.triggered = false;
}

void PX4CtrlFSM::motors_idling(const Imu_Data_t &imu, Controller_Output_t &u)
{
	u.q = imu.q;
	u.bodyrates = Eigen::Vector3d::Zero();
	u.thrust = 0.04;
}

void PX4CtrlFSM::land_detector(const State_t state, const Desired_State_t &des, const Odom_Data_t &odom)
{
	static State_t last_state = State_t::MANUAL_CTRL;
	if (last_state == State_t::MANUAL_CTRL && (state == State_t::AUTO_HOVER || state == State_t::AUTO_TAKEOFF))
	{
		takeoff_land.landed = false; // Always holds
	}
	last_state = state;

	if (state == State_t::MANUAL_CTRL && !state_data.current_state.armed)
	{
		takeoff_land.landed = true;
		return; // No need of other decisions
	}

	// land_detector parameters
	constexpr double POSITION_DEVIATION_C = -0.5; // Constraint 1: target position below real position for POSITION_DEVIATION_C meters.
	constexpr double VELOCITY_THR_C = 0.1;		  // Constraint 2: velocity below VELOCITY_MIN_C m/s.
	constexpr double TIME_KEEP_C = 3.0;			  // Constraint 3: Time(s) the Constraint 1&2 need to keep.

	static ros::Time time_C12_reached; // time_Constraints12_reached
	static bool is_last_C12_satisfy;
	if (takeoff_land.landed)
	{
		time_C12_reached = ros::Time::now();
		is_last_C12_satisfy = false;
	}
	else
	{
		bool C12_satisfy = (des.p(2) - odom.p(2)) < POSITION_DEVIATION_C && odom.v.norm() < VELOCITY_THR_C;
		if (C12_satisfy && !is_last_C12_satisfy)
		{
			time_C12_reached = ros::Time::now();
		}
		else if (C12_satisfy && is_last_C12_satisfy)
		{
			if ((ros::Time::now() - time_C12_reached).toSec() > TIME_KEEP_C) // Constraint 3 reached
			{
				takeoff_land.landed = true;
			}
		}

		is_last_C12_satisfy = C12_satisfy;
	}
}

Desired_State_t PX4CtrlFSM::get_hover_des()
{
	Desired_State_t des;
	des.p = hover_pose.head<3>();
	Eigen::Vector3d kp(1.0, 1.0, 1.0);
	// des.v = kp.asDiagonal() * (des.p - odom_data.p);
	des.v = Eigen::Vector3d::Zero();
	des.a = Eigen::Vector3d::Zero();
	des.j = Eigen::Vector3d::Zero();
	des.yaw = hover_pose(3);
	des.yaw_rate = 0.0;

	return des;
}

Desired_State_t PX4CtrlFSM::get_cmd_des()
{
	Desired_State_t des;
	des.p = cmd_data.p;
	des.v = cmd_data.v;
	des.a = cmd_data.a;
	des.j = cmd_data.j;
	des.yaw = cmd_data.yaw;
	des.yaw_rate = cmd_data.yaw_rate;

	return des;
}

// Desired_State_t PX4CtrlFSM::get_stereoTrack_des()
// {
// 	Desired_State_t des;
// 	des.p.x() = stereo_data.p.x();
// 	des.p.y() = stereo_data.p.y();
// 	des.p.z() = stereo_data.p.z();

// 	des.q.x() = odom_data.q.x();
// 	des.q.y() = odom_data.q.y();
// 	des.q.z() = odom_data.q.z();
// 	des.q.w() = odom_data.q.w();

// 	return des;
// }

Desired_State_t PX4CtrlFSM::get_stereoTrack_des()
{
	Desired_State_t des;
	des.p.x() = stereo_data.p.x();
	des.p.y() = stereo_data.p.y();
	des.p.z() = stereo_data.p.z();

	des.v.x() = 0;
	des.v.y() = 0;
	des.v.z() = 0;

	des.a.x() = 0;
	des.a.y() = 0;
	des.a.z() = 0;

	des.yaw = get_yaw_from_quaternion(odom_data.q);

	return des;
}

// Desired_State_t PX4CtrlFSM::get_turnyaw_des()
// {
// 	Desired_State_t des;
// 	des.p.x() = turnyaw_data.p.x();
// 	des.p.y() = turnyaw_data.p.y();
// 	des.p.z() = turnyaw_data.p.z();

// 	des.q.x() = turnyaw_data.q.x();
// 	des.q.y() = turnyaw_data.q.y();
// 	des.q.z() = turnyaw_data.q.z();
// 	des.q.w() = turnyaw_data.q.w();

// 	return des;
// }

Desired_State_t PX4CtrlFSM::get_turnyaw_des()
{
	Desired_State_t des;
	des.p.x() = turnyaw_data.p.x();
	des.p.y() = turnyaw_data.p.y();
	des.p.z() = turnyaw_data.p.z();

	des.v.x() = 0;
	des.v.y() = 0;
	des.v.z() = 0;

	des.a.x() = 0;
	des.a.y() = 0;
	des.a.z() = 0;

	des.yaw = get_yaw_from_quaternion(turnyaw_data.q);

	return des;
}

Desired_State_t PX4CtrlFSM::get_rotor_speed_up_des(const ros::Time now)
{
	double delta_t = (now - takeoff_land.toggle_takeoff_land_time).toSec();
	double des_a_z = exp((delta_t - AutoTakeoffLand_t::MOTORS_SPEEDUP_TIME) * 6.0) * 7.0 - 7.0; // Parameters 6.0 and 7.0 are just heuristic values which result in a saticfactory curve.
	if (des_a_z > 0.1)
	{
		ROS_ERROR("des_a_z > 0.1!, des_a_z=%f", des_a_z);
		des_a_z = 0.0;
	}

	Desired_State_t des;
	des.p = takeoff_land.start_pose.head<3>();
	des.v = Eigen::Vector3d::Zero();
	des.a = Eigen::Vector3d(0, 0, des_a_z);
	des.j = Eigen::Vector3d::Zero();
	des.yaw = takeoff_land.start_pose(3);
	des.yaw_rate = 0.0;

	return des;
}

Desired_State_t PX4CtrlFSM::get_takeoff_land_des(const double speed)
{
	ros::Time now = ros::Time::now();

	double delta_t = (now - takeoff_land.toggle_takeoff_land_time).toSec() - (speed > 0 ? AutoTakeoffLand_t::MOTORS_SPEEDUP_TIME : 0); // speed > 0 means takeoff
	// takeoff_land.last_set_cmd_time = now;

	// takeoff_land.start_pose(2) += speed * delta_t;

	Desired_State_t des;
	des.p = takeoff_land.start_pose.head<3>() + Eigen::Vector3d(0, 0, speed * delta_t);
	Eigen::Vector3d kp(1.0, 1.0, 1.0);
	// des.v = kp.asDiagonal() * (Eigen::Vector3d(0, 0, 0.5) - odom_data.p);
	des.v = Eigen::Vector3d(0, 0, speed);
	des.a = Eigen::Vector3d::Zero();
	des.j = Eigen::Vector3d::Zero();
	des.yaw = takeoff_land.start_pose(3);
	des.yaw_rate = 0.0;

	return des;
}

void PX4CtrlFSM::set_hov_with_odom()
{
	hover_pose.head<3>() = odom_data.p;
	hover_pose(3) = get_yaw_from_quaternion(odom_data.q);

	last_set_hover_pose_time = ros::Time::now();
}

void PX4CtrlFSM::set_hov_with_rc()
{
	ros::Time now = ros::Time::now();
	double delta_t = (now - last_set_hover_pose_time).toSec();
	last_set_hover_pose_time = now;

	hover_pose(0) += rc_data.ch[1] * param.max_manual_vel * delta_t * (param.rc_reverse.pitch ? 1 : -1);
	hover_pose(1) += rc_data.ch[0] * param.max_manual_vel * delta_t * (param.rc_reverse.roll ? 1 : -1);
	hover_pose(2) += rc_data.ch[2] * param.max_manual_vel * delta_t * (param.rc_reverse.throttle ? 1 : -1);
	hover_pose(3) += rc_data.ch[3] * param.max_manual_vel * delta_t * (param.rc_reverse.yaw ? 1 : -1);

	if (hover_pose(2) < -0.3)
		hover_pose(2) = -0.3;

	// if (param.print_dbg)
	// {
	// 	static unsigned int count = 0;
	// 	if (count++ % 100 == 0)
	// 	{
	// 		cout << "hover_pose=" << hover_pose.transpose() << endl;
	// 		cout << "ch[0~3]=" << rc_data.ch[0] << " " << rc_data.ch[1] << " " << rc_data.ch[2] << " " << rc_data.ch[3] << endl;
	// 	}
	// }
}

void PX4CtrlFSM::set_start_pose_for_takeoff_land(const Odom_Data_t &odom)
{
	takeoff_land.start_pose.head<3>() = odom_data.p;
	takeoff_land.start_pose(3) = get_yaw_from_quaternion(odom_data.q);

	takeoff_land.toggle_takeoff_land_time = ros::Time::now();
}

bool PX4CtrlFSM::rc_is_received(const ros::Time &now_time)
{
	return (now_time - rc_data.rcv_stamp).toSec() < param.msg_timeout.rc;
}

bool PX4CtrlFSM::cmd_is_received(const ros::Time &now_time)
{
	return (now_time - cmd_data.rcv_stamp).toSec() < param.msg_timeout.cmd;
}

bool PX4CtrlFSM::odom_is_received(const ros::Time &now_time)
{
	return (now_time - odom_data.rcv_stamp).toSec() < param.msg_timeout.odom;
}

bool PX4CtrlFSM::imu_is_received(const ros::Time &now_time)
{
	return (now_time - imu_data.rcv_stamp).toSec() < param.msg_timeout.imu;
}

bool PX4CtrlFSM::bat_is_received(const ros::Time &now_time)
{
	return (now_time - bat_data.rcv_stamp).toSec() < param.msg_timeout.bat;
}

bool PX4CtrlFSM::stereo_is_received(const ros::Time &now_time)
{
	return (now_time - stereo_data.rcv_stamp).toSec() < param.msg_timeout.stereo;
}

bool PX4CtrlFSM::turnyaw_is_received(const ros::Time &now_time)
{
	return (now_time - turnyaw_data.rcv_stamp).toSec() < param.msg_timeout.turnyaw;
}

bool PX4CtrlFSM::recv_new_odom()
{
	if (odom_data.recv_new_msg)
	{
		odom_data.recv_new_msg = false;
		return true;
	}

	return false;
}

void PX4CtrlFSM::publish_bodyrate_ctrl(const Controller_Output_t &u, const ros::Time &stamp)
{
	mavros_msgs::AttitudeTarget msg;

	msg.header.stamp = stamp;
	msg.header.frame_id = std::string("FCU");

	msg.type_mask = mavros_msgs::AttitudeTarget::IGNORE_ATTITUDE;

	msg.body_rate.x = u.bodyrates.x();
	msg.body_rate.y = u.bodyrates.y();
	msg.body_rate.z = u.bodyrates.z();

	msg.thrust = u.thrust;

	ctrl_FCU_pub.publish(msg);
}

void PX4CtrlFSM::publish_attitude_ctrl(const Controller_Output_t &u, const ros::Time &stamp)
{
	mavros_msgs::AttitudeTarget msg;

	msg.header.stamp = stamp;
	msg.header.frame_id = std::string("FCU");

	msg.type_mask = mavros_msgs::AttitudeTarget::IGNORE_ROLL_RATE |
					mavros_msgs::AttitudeTarget::IGNORE_PITCH_RATE |
					mavros_msgs::AttitudeTarget::IGNORE_YAW_RATE;

	msg.orientation.x = u.q.x();
	msg.orientation.y = u.q.y();
	msg.orientation.z = u.q.z();
	msg.orientation.w = u.q.w();

	msg.thrust = u.thrust;

	ctrl_FCU_pub.publish(msg);
}

void PX4CtrlFSM::publish_pose_ctrl(const Controller_Output_t &u, const ros::Time &stamp)
{

	geometry_msgs::PoseStamped msg;
	msg.header.stamp = stamp;
	msg.header.frame_id = std::string("FCU");

	msg.pose.orientation.x = u.q.x();
	msg.pose.orientation.y = u.q.y();
	msg.pose.orientation.z = u.q.z();
	msg.pose.orientation.w = u.q.w();

	msg.pose.position.x = u.pose.x();
	msg.pose.position.y = u.pose.y();
	msg.pose.position.z = u.pose.z();
	if (state == AUTO_TAKEOFF && msg.pose.position.z > param.takeoff_land.height)
	{
		msg.pose.position.z = param.takeoff_land.height + 0.1;
	}

	local_pos_pub.publish(msg);
}

void PX4CtrlFSM::publish_pose_ctrl_stereo(Desired_State_t des)
{
	geometry_msgs::PoseStamped msg;

	msg.pose.orientation.x = des.q.x();
	msg.pose.orientation.y = des.q.y();
	msg.pose.orientation.z = des.q.z();
	msg.pose.orientation.w = des.q.w();

	msg.pose.position.x = des.p.x();
	msg.pose.position.y = des.p.y();
	msg.pose.position.z = des.p.z();

	local_pos_pub.publish(msg);
}

void PX4CtrlFSM::publish_pose_ctrl_px4(Desired_State_t des)
{

	geometry_msgs::PoseStamped msg;

	msg.pose.orientation = oula2quat(0.0, 0.0, des.yaw);
	// msg.pose.orientation.x = des.q.x();
	// msg.pose.orientation.y = des.q.y();
	// msg.pose.orientation.z = des.q.z();
	// msg.pose.orientation.w = des.q.w();

	msg.pose.position.x = des.p.x();
	msg.pose.position.y = des.p.y();
	msg.pose.position.z = des.p.z();
	// if(state == AUTO_TAKEOFF && msg.pose.position.z > param.takeoff_land.height){
	// 	msg.pose.position.z = param.takeoff_land.height + 0.1;
	// }

	local_pos_pub.publish(msg);
}

void PX4CtrlFSM::publish_des_msg(const Desired_State_t &des)
{
	geometry_msgs::PoseStamped msg;

	msg.pose.orientation.x = des.q.x();
	msg.pose.orientation.y = des.q.y();
	msg.pose.orientation.z = des.q.z();
	msg.pose.orientation.w = des.q.w();

	msg.pose.position.x = des.p.x();
	msg.pose.position.y = des.p.y();
	msg.pose.position.z = des.p.z();

	des_position_pub_.publish(msg);
}

void PX4CtrlFSM::publish_trigger(const nav_msgs::Odometry &odom_msg)
{
	geometry_msgs::PoseStamped msg;
	msg.header.frame_id = "world";
	msg.pose = odom_msg.pose.pose;

	traj_start_trigger_pub.publish(msg);
}

bool PX4CtrlFSM::toggle_offboard_mode(bool on_off)
{
	mavros_msgs::SetMode offb_set_mode;

	if (on_off)
	{
		state_data.state_before_offboard = state_data.current_state;
		if (state_data.state_before_offboard.mode == "OFFBOARD") // Not allowed
			state_data.state_before_offboard.mode = "MANUAL";

		offb_set_mode.request.custom_mode = "OFFBOARD";
		if (!(set_FCU_mode_srv.call(offb_set_mode) && offb_set_mode.response.mode_sent))
		{
			ROS_ERROR("Enter OFFBOARD rejected by PX4!");
			return false;
		}
	}
	else
	{
		offb_set_mode.request.custom_mode = state_data.state_before_offboard.mode;
		if (!(set_FCU_mode_srv.call(offb_set_mode) && offb_set_mode.response.mode_sent))
		{
			ROS_ERROR("Exit OFFBOARD rejected by PX4!");
			return false;
		}
	}

	return true;

	// if (param.print_dbg)
	// 	printf("offb_set_mode mode_sent=%d(uint8_t)\n", offb_set_mode.response.mode_sent);
}

bool PX4CtrlFSM::toggle_arm_disarm(bool arm)
{
	mavros_msgs::CommandBool arm_cmd;
	arm_cmd.request.value = arm;
	if (!(arming_client_srv.call(arm_cmd) && arm_cmd.response.success))
	{
		if (arm)
			ROS_ERROR("ARM rejected by PX4!");
		else
			ROS_ERROR("DISARM rejected by PX4!");

		return false;
	}

	return true;
}

void PX4CtrlFSM::reboot_FCU()
{
	// https://mavlink.io/en/messages/common.html, MAV_CMD_PREFLIGHT_REBOOT_SHUTDOWN(#246)
	mavros_msgs::CommandLong reboot_srv;
	reboot_srv.request.broadcast = false;
	reboot_srv.request.command = 246; // MAV_CMD_PREFLIGHT_REBOOT_SHUTDOWN
	reboot_srv.request.param1 = 1;	  // Reboot autopilot
	reboot_srv.request.param2 = 0;	  // Do nothing for onboard computer
	reboot_srv.request.confirmation = true;

	reboot_FCU_srv.call(reboot_srv);

	ROS_INFO("Reboot FCU");

	// if (param.print_dbg)
	// 	printf("reboot result=%d(uint8_t), success=%d(uint8_t)\n", reboot_srv.response.result, reboot_srv.response.success);
}

geometry_msgs::Quaternion PX4CtrlFSM::oula2quat(double roll, double pitch, double yaw)
{
	tf::Quaternion tfQuaternion;
	tfQuaternion.setRPY(roll, pitch, yaw);
	// 将tf::Quaternion转换为geometry_msgs::Quaternion
	geometry_msgs::Quaternion quaternion;
	tf::quaternionTFToMsg(tfQuaternion, quaternion);
	return quaternion;
}

void PX4CtrlFSM::mission_state_Callback(const std_msgs::UInt32 &msg)
{
	int state_int = (int)(msg.data);
	switch (state_int)
	{
	case 1:
		// state = MANUAL_CTRL;
		break;
	case 2: // 悬停
		m_state.is_cmd_mode = false;
		m_state.is_stereo_mode = false;
		m_state.is_turnyaw_mode = false;
		break;
	case 3:
		m_state.is_cmd_mode = true;
		m_state.is_stereo_mode = false;
		m_state.is_turnyaw_mode = false;
		break;
	case 4: // 起飞
		m_state.is_hover_mode = true;
		m_state.is_cmd_mode = true;
		break;
	case 5:
		// state = AUTO_LAND;
		break;
	case 6: // 视觉伺服
		m_state.is_cmd_mode = false;
		m_state.is_stereo_mode = true;
		m_state.is_turnyaw_mode = false;
		break;
	case 7: // 单独转yaw
		m_state.is_cmd_mode = false;
		m_state.is_stereo_mode = false;
		m_state.is_turnyaw_mode = true;
		break;
	// Handle other values if needed
	default:
		ROS_WARN("Unhandled uint32 value: %u", msg.data);
		// Return a default value or throw an exception
		// state = MANUAL_CTRL;
		break;
	}

	// if(state == AUTO_TAKEOFF){ //接收起飞指令，切换到悬停和指令控制
	// ROS_WARN("22222222222222222");
	// 	m_state.is_hover_mode = true ;
	// 	m_state.is_cmd_mode = true ;
	// }
}

void PX4CtrlFSM::steoreoTrackCallback(const geometry_msgs::PoseStamped &msg)
{
	stereo_data.rcv_stamp = ros::Time::now();

	stereo_data.p.x() = msg.pose.position.x;
	stereo_data.p.y() = msg.pose.position.y;
	stereo_data.p.z() = msg.pose.position.z;

	stereo_data.q.x() = msg.pose.orientation.x;
	stereo_data.q.y() = msg.pose.orientation.y;
	stereo_data.q.z() = msg.pose.orientation.z;
	stereo_data.q.w() = msg.pose.orientation.w;
}

void PX4CtrlFSM::turnYawposeCallback(const geometry_msgs::PoseStamped &msg)
{
	turnyaw_data.rcv_stamp = ros::Time::now();

	turnyaw_data.p.x() = msg.pose.position.x;
	turnyaw_data.p.y() = msg.pose.position.y;
	turnyaw_data.p.z() = msg.pose.position.z;

	turnyaw_data.q.x() = msg.pose.orientation.x;
	turnyaw_data.q.y() = msg.pose.orientation.y;
	turnyaw_data.q.z() = msg.pose.orientation.z;
	turnyaw_data.q.w() = msg.pose.orientation.w;
}
