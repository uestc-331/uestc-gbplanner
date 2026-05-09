#include "controller.h"
#include <Eigen/Dense>
#include <Eigen/Geometry>
#include <uav_utils/converters.h>
#include <geometry_msgs/Vector3Stamped.h>
#include <geometry_msgs/QuaternionStamped.h>
#include <boost/format.hpp>
#include "std_msgs/Float32.h"

using namespace std;
using namespace Eigen;
using std::cout;
using std::endl;
using namespace uav_utils;

double LinearControl::fromQuaternion2yaw(Eigen::Quaterniond q)
{
	double yaw = atan2(2 * (q.x() * q.y() + q.w() * q.z()), q.w() * q.w() + q.x() * q.x() - q.y() * q.y() - q.z() * q.z());
	return yaw;
}

LinearControl::LinearControl(Parameter_t &param) : param_(param)
{
	resetThrustMapping();
}

/**
 * https://github.com/schlagenhauf/lqr_solve/blob/master/lqr_solve.cpp
 * @brief Computes the LQR gain matrix (usually denoted K) for a discrete time
 * infinite horizon problem.
 *
 * @param A State matrix of the underlying system
 * @param B Input matrix of the underlying system
 * @param Q Weight matrix penalizing the state
 * @param R Weight matrix penalizing the controls
 * @param N Weight matrix penalizing state / control pairs
 * @param K Pointer to the generated matrix (has to be a double/dynamic size
 * matrix!)
 * @param eps Delta between iterations that determines when convergence is
 * reached
 */

void LinearControl::DARE(const Eigen::MatrixXd &A, const Eigen::MatrixXd &B, const Eigen::MatrixXd &Q, const Eigen::MatrixXd &R,
						 const Eigen::MatrixXd &N, Eigen::MatrixXd *K, const double eps)
{
	// check if dimensions are compatible
	if (A.rows() != A.cols() || B.rows() != A.rows() || Q.rows() != Q.cols() ||
		Q.rows() != A.rows() || R.rows() != R.cols() || R.rows() != B.cols() ||
		N.rows() != A.rows() || N.cols() != B.cols())
	{
		std::cout << "One or more matrices have incompatible dimensions. Aborting."
				  << std::endl;
	}

	ros::Time now_time_lqr_start = ros::Time::now();

	// precompute as much as possible
	Eigen::MatrixXd B_T = B.transpose();
	Eigen::MatrixXd Acal = A - B * R.inverse() * N.transpose();
	Eigen::MatrixXd Acal_T = Acal.transpose();
	Eigen::MatrixXd Qcal = Q - N * R.inverse() * N.transpose();

	// initialize P with Q
	Eigen::MatrixXd P = Q;

	// iterate until P converges
	unsigned int numIterations = 0;
	Eigen::MatrixXd Pold = P;
	while (true)
	{
		numIterations++;

		// compute new P
		P = Acal_T * P * Acal -
			Acal_T * P * B * (R + B_T * P * B).inverse() * B_T * P * Acal + Qcal;

		// update delta
		Eigen::MatrixXd delta = P - Pold;
		if (fabs(delta.maxCoeff()) < eps)
		{
			//   std::cout << "Number of iterations until convergence: " << numIterations
			//             << std::endl;
			break;
		}
		Pold = P;
	}

	// compute K from P
	*K = (R + B_T * P * B).inverse() * (B_T * P * A + N.transpose());

	ros::Time now_time_lqr_end = ros::Time::now();
	ros::Duration cost_time = now_time_lqr_end - now_time_lqr_start;
	static bool print_flag = true;
	// if(print_flag)
	// {
	//     ROS_ERROR("LQR COST TIME : %f",cost_time.toSec());
	//     print_flag = false;
	// }
}

// 扩展状态观测器(ESO)函数
void LinearControl::updateESO(Eigen::Vector3d &z1, Eigen::Vector3d &z2, Eigen::Vector3d &z3,
							  const Eigen::Vector3d &y, const Eigen::Vector3d &u, double dt,
							  const Eigen::Vector3d &w0, const Eigen::Vector3d &b0)
{
	// Linear ADRC: 3rd-order ESO for a 2nd-order plant (per axis)
	// y: measured position
	// u: control input (desired acceleration command without gravity)
	// Eigen::Vector3d beta1 = 3.0 * w0;
	Eigen::Vector3d beta1 = 2.0 * w0;
	Eigen::Vector3d beta2 = 3.0 * w0.cwiseProduct(w0);
	Eigen::Vector3d beta3 = 0.5 * w0.cwiseProduct(w0).cwiseProduct(w0);

	Eigen::Vector3d e = z1 - y;

	Eigen::Vector3d z1_dot = z2 - beta1.cwiseProduct(e);
	Eigen::Vector3d z2_dot = z3 + b0.cwiseProduct(u) - beta2.cwiseProduct(e);
	Eigen::Vector3d z3_dot = -beta3.cwiseProduct(e);

	z1 += dt * z1_dot;
	z2 += dt * z2_dot;
	z3 += dt * z3_dot;
	// z3[2] = 0;
}
// ADRC 控制器实现
quadrotor_msgs::Px4ctrlDebug
LinearControl::ADRC_Control(const Desired_State_t &des,
							const Odom_Data_t &odom,
							const Imu_Data_t &imu,
							Controller_Output_t &u)
{
	quadrotor_msgs::Px4ctrlDebug debug_msg_;

	// --- ADRC Position Controller (Outer loop) ---
	// Plant model (per axis): x_ddot = b0 * u + f, where f is total disturbance.
	// ESO estimates {z1=pos, z2=vel, z3=f}. Control law: u = (v - z3) / b0,
	// where v is the desired nominal acceleration from PD tracking.

	// 使用固定时间间隔
	// dt = 1.0 / (double)param_.ctrl_freq_max;
	// 使用实际时间间隔
	static ros::Time last_time = ros::Time::now();
	ros::Time now_time = ros::Time::now();
	dt = (now_time - last_time).toSec();
	last_time = now_time;
	if (!std::isfinite(dt) || dt <= 0.0 || dt > 0.1)
		dt = 1.0 / std::max(1.0, param_.ctrl_freq_max);

	// ESO states (persistent between calls)
	static bool eso_inited = false;
	static Eigen::Vector3d z1 = Eigen::Vector3d::Zero();	 // position estimate
	static Eigen::Vector3d z2 = Eigen::Vector3d::Zero();	 // velocity estimate
	static Eigen::Vector3d z3 = Eigen::Vector3d::Zero();	 // disturbance estimate
	static Eigen::Vector3d u_last = Eigen::Vector3d::Zero(); // last control input (without gravity)

	if (!eso_inited)
	{
		z1 = odom.p;
		z2 = odom.v;
		z3.setZero();
		u_last.setZero();
		eso_inited = true;
	}

	// Observer bandwidth and input gain (optional params)
	Eigen::Vector3d w0(param_.adrc.w0_xy, param_.adrc.w0_xy, param_.adrc.w0_z);
	Eigen::Vector3d b0(param_.adrc.b0_xy, param_.adrc.b0_xy, param_.adrc.b0_z);

	// --- Special handling for takeoff motor speed-up phase ---
	// During the motor speed-up phase, the vehicle is constrained on the ground.
	// If we keep running the ESO here, it will treat the ground reaction force as a "disturbance"
	// and z3 can wind up to a very large value. When the takeoff phase starts, (v - z3) becomes
	// strongly negative and the vehicle may never lift off.

	// Update ESO using measured position and last command (skip during speed-up)
	if (adrc_eso_enable)
	{
		updateESO(z1, z2, z3, odom.p, u_last, dt, w0, b0);
	}
	else
	{
		// Keep internal states aligned to measurement; do NOT estimate disturbance.
		z1 = odom.p;
		z2 = odom.v;
		z3.setZero();
		u_last.setZero();
	}

	// Nominal acceleration from PD tracking (same gains as the linear controller)
	Eigen::Vector3d Kp, Kv;
	Kp << param_.gain.Kp0, param_.gain.Kp1, param_.gain.Kp2;
	Kv << param_.gain.Kv0, param_.gain.Kv1, param_.gain.Kv2;

	// v: desired acceleration for disturbance-free system (without gravity)
	Eigen::Vector3d v = des.a + Kv.asDiagonal() * (des.v - z2) + Kp.asDiagonal() * (des.p - z1);

	// 对eso估计进行低通滤波后注入系统
	static Eigen::Vector3d z3_lpf = Eigen::Vector3d::Zero();
	double fc = 1.0; // Hz，建议 1~5Hz 起步（看你的抖动频率）
	double alpha = exp(-2.0 * M_PI * fc * dt);
	z3_lpf = alpha * z3_lpf + (1.0 - alpha) * z3;

	// ADRC compensation: cancel estimated disturbance
	Eigen::Vector3d u_acc = (v - z3).cwiseQuotient(b0);

	// Save for next ESO update
	u_last = u_acc;

	// Add gravity compensation for thrust mapping / attitude generation
	Eigen::Vector3d des_acc = u_acc + Eigen::Vector3d(0, 0, param_.gra);

	// Thrust command
	u.thrust = computeDesiredCollectiveThrustSignal(des_acc);

	// Attitude command (same way as DLQR)
	double yaw_odom = fromQuaternion2yaw(odom.q);
	double sin_yaw = std::sin(yaw_odom);
	double cos_yaw = std::cos(yaw_odom);

	double roll = (des_acc(0) * sin_yaw - des_acc(1) * cos_yaw) / param_.gra;
	double pitch = (des_acc(0) * cos_yaw + des_acc(1) * sin_yaw) / param_.gra;

	Eigen::Quaterniond q = Eigen::AngleAxisd(des.yaw, Eigen::Vector3d::UnitZ()) *
						   Eigen::AngleAxisd(pitch, Eigen::Vector3d::UnitY()) *
						   Eigen::AngleAxisd(roll, Eigen::Vector3d::UnitX());

	u.q = imu.q * odom.q.inverse() * q;

	// Debug info
	debug_msg_.des_v_x = des.v(0);
	debug_msg_.des_v_y = des.v(1);
	debug_msg_.des_v_z = des.v(2);

	debug_msg_.des_a_x = des.a(0);
	debug_msg_.des_a_y = des.a(1);
	debug_msg_.des_a_z = des.a(2);

	debug_msg_.des_q_x = u.q.x();
	debug_msg_.des_q_y = u.q.y();
	debug_msg_.des_q_z = u.q.z();
	debug_msg_.des_q_w = u.q.w();

	debug_msg_.des_thr = u.thrust;

	// Used for thrust-accel mapping estimation
	timed_thrust_.push(std::pair<ros::Time, double>(ros::Time::now(), u.thrust));
	while (timed_thrust_.size() > 100)
	{
		timed_thrust_.pop();
	}

	return debug_msg_;
}

quadrotor_msgs::Px4ctrlDebug
LinearControl::DLQR_Control(const Desired_State_t &des,
							const Odom_Data_t &odom,
							const Imu_Data_t &imu,
							Controller_Output_t &u)
{

	Eigen::Vector3d des_acc(0.0, 0.0, 0.0);
	dt = 1.0 / (double)param_.ctrl_freq_max;
	// [[1, 0, dt, 0],
	//  [0, 1, 0, dt],
	//  [0, 0, 1, 0],
	//  [0, 0, 0, 1]]
	A = Eigen::MatrixXd::Identity(4, 4);
	A(0, 2) = dt;
	A(1, 3) = dt;
	B = Eigen::MatrixXd::Zero(4, 2);
	B(2, 0) = dt;
	B(3, 1) = dt;
	// [[0, 0],
	// [0, 0],
	// [dt, 0],
	// [0, dt]]
	// Q = [[3,0,0,0],
	// [0,5,0,0],
	// [0,0,3,0],
	// [0,0,0,5]];
	Q = 2 * Eigen::MatrixXd::Identity(4, 4);
	// Q(1,1)=4;
	// Q(3,3)=4;
	R = 0.5 * Eigen::MatrixXd::Identity(2, 2);
	// R(1,1) = 0.1;
	N = Eigen::MatrixXd::Zero(4, 2);

	static bool dare_flag = true;
	if (dare_flag)
	{
		DARE(A, B, Q, R, N, &K, 1e-15);
		dare_flag = false;
	}

	// std::cout << K << std::endl;

	const Eigen::Vector4d state_des = Eigen::Vector4d(des.p(0), des.p(1), des.v(0), des.v(1));
	const Eigen::Vector4d state_now = Eigen::Vector4d(odom.p(0), odom.p(1), odom.v(0), odom.v(1));
	const Eigen::Vector2d des_a = Eigen::Vector2d(des.a(0), des.a(1));
	const Eigen::Vector4d des_err = state_now - state_des;
	// ROS_ERROR("X_traj_ERR  : %f ,      Y_traj_ERR : %f   des_a_X : %f       des_a_y  : %f",des_err(0),des_err(1),des_a(0),des_a(1));
	Eigen::Vector2d out_acc = -K * (des_err) + des_a;

	des_acc(0) = out_acc(0);
	des_acc(1) = out_acc(1);
	des_acc(2) = param_.gain.Kv2 * (des.v(2) - odom.v(2)) + param_.gain.Kp2 * (des.p(2) - odom.p(2)) + des.a(2);
	des_acc += Eigen::Vector3d(0, 0, param_.gra);

	u.thrust = computeDesiredCollectiveThrustSignal(des_acc);
	double roll, pitch, yaw, yaw_imu;
	double yaw_odom = fromQuaternion2yaw(odom.q);
	double sin = std::sin(yaw_odom);
	double cos = std::cos(yaw_odom);
	roll = (des_acc(0) * sin - des_acc(1) * cos) / param_.gra;
	pitch = (des_acc(0) * cos + des_acc(1) * sin) / param_.gra;

	yaw_imu = fromQuaternion2yaw(imu.q); // 根据四元数计算出欧拉角，ros的odom消息机制为ZYX，无人机的是ZXY
	// Eigen::Quaterniond q = Eigen::AngleAxisd(yaw,Eigen::Vector3d::UnitZ())
	//   * Eigen::AngleAxisd(roll,Eigen::Vector3d::UnitX())
	//   * Eigen::AngleAxisd(pitch,Eigen::Vector3d::UnitY());
	Eigen::Quaterniond q = Eigen::AngleAxisd(des.yaw, Eigen::Vector3d::UnitZ()) * Eigen::AngleAxisd(pitch, Eigen::Vector3d::UnitY()) * Eigen::AngleAxisd(roll, Eigen::Vector3d::UnitX());
	u.q = imu.q * odom.q.inverse() * q; // Align with FCU frame

	debug_msg_.des_v_x = des.v(0);
	debug_msg_.des_v_y = des.v(1);
	debug_msg_.des_v_z = des.v(2);

	debug_msg_.des_a_x = des_acc(0);
	debug_msg_.des_a_y = des_acc(1);
	debug_msg_.des_a_z = des_acc(2);

	debug_msg_.des_q_x = u.q.x();
	debug_msg_.des_q_y = u.q.y();
	debug_msg_.des_q_z = u.q.z();
	debug_msg_.des_q_w = u.q.w();

	debug_msg_.des_thr = u.thrust;

	// Used for thrust-accel mapping estimation
	timed_thrust_.push(std::pair<ros::Time, double>(ros::Time::now(), u.thrust));
	while (timed_thrust_.size() > 100)
	{

		timed_thrust_.pop();
	}
	return debug_msg_;
}

/*
  Fast_250 low_level_controller
  compute u.thrust and u.q, controller gains and other parameters are in param_
*/

quadrotor_msgs::Px4ctrlDebug
LinearControl::calculateControl(const Desired_State_t &des,
								const Odom_Data_t &odom,
								const Imu_Data_t &imu,
								Controller_Output_t &u)
{

	// compute disired acceleration
	Eigen::Vector3d des_acc(0.0, 0.0, 0.0);
	Eigen::Vector3d Kp, Kv;
	Kp << param_.gain.Kp0, param_.gain.Kp1, param_.gain.Kp2;
	Kv << param_.gain.Kv0, param_.gain.Kv1, param_.gain.Kv2;
	des_acc = des.a + Kv.asDiagonal() * (des.v - odom.v) + Kp.asDiagonal() * (des.p - odom.p);
	des_acc += Eigen::Vector3d(0, 0, param_.gra);

	u.thrust = computeDesiredCollectiveThrustSignal(des_acc);

	// 计算角度输出给姿态控制器
	double roll, pitch, yaw, yaw_imu;
	double yaw_odom = fromQuaternion2yaw(odom.q);
	double sin = std::sin(yaw_odom);
	double cos = std::cos(yaw_odom);
	roll = (des_acc(0) * sin - des_acc(1) * cos) / param_.gra;
	pitch = (des_acc(0) * cos + des_acc(1) * sin) / param_.gra;
	// yaw = fromQuaternion2yaw(des.q);
	yaw_imu = fromQuaternion2yaw(imu.q); // 根据四元数计算出欧拉角，ros的odom消息机制为ZYX，无人机的是ZXY
	// Eigen::Quaterniond q = Eigen::AngleAxisd(yaw,Eigen::Vector3d::UnitZ())
	//   * Eigen::AngleAxisd(roll,Eigen::Vector3d::UnitX())
	//   * Eigen::AngleAxisd(pitch,Eigen::Vector3d::UnitY());
	Eigen::Quaterniond q = Eigen::AngleAxisd(des.yaw, Eigen::Vector3d::UnitZ()) * Eigen::AngleAxisd(pitch, Eigen::Vector3d::UnitY()) * Eigen::AngleAxisd(roll, Eigen::Vector3d::UnitX());
	u.q = imu.q * odom.q.inverse() * q;

	u.pose = des.p;

	/* WRITE YOUR CODE HERE */

	// used for debug
	//  debug_msg_.des_p_x = des.p(0);
	//  debug_msg_.des_p_y = des.p(1);
	//  debug_msg_.des_p_z = des.p(2);

	debug_msg_.des_v_x = des.v(0);
	debug_msg_.des_v_y = des.v(1);
	debug_msg_.des_v_z = des.v(2);

	debug_msg_.des_a_x = des.p(0);
	debug_msg_.des_a_y = des.p(1);
	debug_msg_.des_a_z = des.p(2);

	debug_msg_.des_q_x = u.q.x();
	debug_msg_.des_q_y = u.q.y();
	debug_msg_.des_q_z = u.q.z();
	debug_msg_.des_q_w = u.q.w();

	debug_msg_.des_thr = u.thrust;

	// Used for thrust-accel mapping estimation
	timed_thrust_.push(std::pair<ros::Time, double>(ros::Time::now(), u.thrust));
	while (timed_thrust_.size() > 100)
	{

		timed_thrust_.pop();
	}
	return debug_msg_;
}

/*
  compute throttle percentage
*/
double LinearControl::computeDesiredCollectiveThrustSignal(
	const Eigen::Vector3d &des_acc)
{
	double throttle_percentage(0.0);

	/* compute throttle, thr2acc has been estimated before */
	throttle_percentage = des_acc(2) / thr2acc_;
	// ROS_ERROR("thr2acc_,%f",thr2acc_);

	return throttle_percentage;
}

bool LinearControl::estimateThrustModel(
	const Eigen::Vector3d &est_a,
	const Parameter_t &param)
{
	ros::Time t_now = ros::Time::now();
	while (timed_thrust_.size() >= 1)
	{
		// Choose data before 35~45ms ago
		std::pair<ros::Time, double> t_t = timed_thrust_.front();
		double time_passed = (t_now - t_t.first).toSec();
		if (time_passed > 0.045) // 45ms
		{
			// printf("continue, time_passed=%f\n", time_passed);
			timed_thrust_.pop();
			continue;
		}
		if (time_passed < 0.035) // 35ms
		{
			// printf("skip, time_passed=%f\n", time_passed);
			return false;
		}

		/***********************************************************/
		/* Recursive least squares algorithm with vanishing memory */
		/***********************************************************/
		double thr = t_t.second;
		timed_thrust_.pop();

		/***********************************/
		/* Model: est_a(2) = thr1acc_ * thr */
		/***********************************/
		double gamma = 1 / (rho2_ + thr * P_ * thr);
		double K = gamma * P_ * thr;
		thr2acc_ = thr2acc_ + K * (est_a(2) - thr * thr2acc_);
		P_ = (1 - K * thr) * P_ / rho2_;
		// printf("%6.3f,%6.3f,%6.3f,%6.3f\n", thr2acc_, gamma, K, P_);
		// fflush(stdout);

		// debug_msg_.thr2acc = thr2acc_;
		return true;
	}
	return false;
}

void LinearControl::resetThrustMapping(void)
{
	thr2acc_ = param_.gra / param_.thr_map.hover_percentage;
	P_ = 1e6;
}
