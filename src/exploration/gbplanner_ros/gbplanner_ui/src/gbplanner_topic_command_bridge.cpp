#include <ros/ros.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Int32.h>
#include <std_srvs/SetBool.h>
#include <std_srvs/Trigger.h>

#include "planner_msgs/pci_global.h"
#include "planner_msgs/pci_initialization.h"

namespace {

class TopicCommandBridge {
 public:
  TopicCommandBridge() {
    automatic_planning_client_ = nh_.serviceClient<std_srvs::Trigger>(
        "/planner_control_interface/std_srvs/automatic_planning");
    single_planning_client_ = nh_.serviceClient<std_srvs::Trigger>(
        "/planner_control_interface/std_srvs/single_planning");
    stop_planner_client_ = nh_.serviceClient<std_srvs::Trigger>(
        "/planner_control_interface/std_srvs/stop");
    homing_client_ = nh_.serviceClient<std_srvs::Trigger>(
        "/planner_control_interface/std_srvs/homing_trigger");
    init_motion_client_ =
        nh_.serviceClient<planner_msgs::pci_initialization>(
            "pci_initialization_trigger");
    go_to_waypoint_client_ = nh_.serviceClient<std_srvs::Trigger>(
        "/planner_control_interface/std_srvs/go_to_waypoint");
    global_planner_client_ =
        nh_.serviceClient<planner_msgs::pci_global>("pci_global");
    operation_mode_client_ =
        nh_.serviceClient<std_srvs::SetBool>("gbplanner/switch_operation_mode");

    start_planner_sub_ = nh_.subscribe(
        "/gbplanner_ui/cmd/start_planner", 1,
        &TopicCommandBridge::startPlannerCallback, this);
    start_planner_single_sub_ = nh_.subscribe(
        "/gbplanner_ui/cmd/start_planner_single", 1,
        &TopicCommandBridge::startPlannerSingleCallback, this);
    stop_planner_sub_ = nh_.subscribe(
        "/gbplanner_ui/cmd/stop_planner", 1,
        &TopicCommandBridge::stopPlannerCallback, this);
    homing_sub_ = nh_.subscribe(
        "/gbplanner_ui/cmd/homing", 1,
        &TopicCommandBridge::homingCallback, this);
    init_motion_sub_ = nh_.subscribe(
        "/gbplanner_ui/cmd/init_motion", 1,
        &TopicCommandBridge::initMotionCallback, this);
    plan_to_waypoint_sub_ = nh_.subscribe(
        "/gbplanner_ui/cmd/plan_to_waypoint", 1,
        &TopicCommandBridge::planToWaypointCallback, this);
    global_planner_sub_ = nh_.subscribe(
        "/gbplanner_ui/cmd/global_frontier_id", 1,
        &TopicCommandBridge::globalPlannerCallback, this);
    operation_mode_sub_ = nh_.subscribe(
        "/gbplanner_ui/cmd/operation_mode", 1,
        &TopicCommandBridge::operationModeCallback, this);
  }

 private:
  void callTrigger(ros::ServiceClient& client, const std::string& label) {
    std_srvs::Trigger srv;
    if (!client.call(srv)) {
      ROS_ERROR("[GBPLANNER-TOPIC-BRIDGE] service call failed: %s",
                client.getService().c_str());
      return;
    }
    ROS_INFO("[GBPLANNER-TOPIC-BRIDGE] %s success=%d message='%s'",
             label.c_str(), srv.response.success, srv.response.message.c_str());
  }

  void startPlannerCallback(const std_msgs::Empty::ConstPtr&) {
    callTrigger(automatic_planning_client_, "start planner");
  }

  void startPlannerSingleCallback(const std_msgs::Empty::ConstPtr&) {
    callTrigger(single_planning_client_, "start single planner");
  }

  void stopPlannerCallback(const std_msgs::Empty::ConstPtr&) {
    callTrigger(stop_planner_client_, "stop planner");
  }

  void homingCallback(const std_msgs::Empty::ConstPtr&) {
    callTrigger(homing_client_, "homing");
  }

  void initMotionCallback(const std_msgs::Empty::ConstPtr&) {
    planner_msgs::pci_initialization srv;
    if (!init_motion_client_.call(srv)) {
      ROS_ERROR("[GBPLANNER-TOPIC-BRIDGE] service call failed: %s",
                init_motion_client_.getService().c_str());
      return;
    }
    ROS_INFO("[GBPLANNER-TOPIC-BRIDGE] init motion success=%d",
             srv.response.success);
  }

  void planToWaypointCallback(const std_msgs::Empty::ConstPtr&) {
    callTrigger(go_to_waypoint_client_, "plan to waypoint");
  }

  void globalPlannerCallback(const std_msgs::Int32::ConstPtr& msg) {
    planner_msgs::pci_global srv;
    srv.request.not_exe_path = false;
    srv.request.set_auto = false;
    srv.request.bound_mode = 0;
    srv.request.vel_max = 0.0;
    srv.request.id = msg->data;
    srv.request.not_check_frontier = false;
    srv.request.ignore_time = false;
    if (!global_planner_client_.call(srv)) {
      ROS_ERROR("[GBPLANNER-TOPIC-BRIDGE] service call failed: %s",
                global_planner_client_.getService().c_str());
      return;
    }
    ROS_INFO("[GBPLANNER-TOPIC-BRIDGE] global frontier id=%d success=%d",
             msg->data, srv.response.success);
  }

  void operationModeCallback(const std_msgs::Bool::ConstPtr& msg) {
    std_srvs::SetBool srv;
    srv.request.data = msg->data;
    if (!operation_mode_client_.call(srv)) {
      ROS_ERROR("[GBPLANNER-TOPIC-BRIDGE] service call failed: %s",
                operation_mode_client_.getService().c_str());
      return;
    }
    ROS_INFO("[GBPLANNER-TOPIC-BRIDGE] operation mode=%d success=%d",
             msg->data, srv.response.success);
  }

  ros::NodeHandle nh_;

  ros::ServiceClient automatic_planning_client_;
  ros::ServiceClient single_planning_client_;
  ros::ServiceClient stop_planner_client_;
  ros::ServiceClient homing_client_;
  ros::ServiceClient init_motion_client_;
  ros::ServiceClient go_to_waypoint_client_;
  ros::ServiceClient global_planner_client_;
  ros::ServiceClient operation_mode_client_;

  ros::Subscriber start_planner_sub_;
  ros::Subscriber start_planner_single_sub_;
  ros::Subscriber stop_planner_sub_;
  ros::Subscriber homing_sub_;
  ros::Subscriber init_motion_sub_;
  ros::Subscriber plan_to_waypoint_sub_;
  ros::Subscriber global_planner_sub_;
  ros::Subscriber operation_mode_sub_;
};

}  // namespace

int main(int argc, char** argv) {
  ros::init(argc, argv, "gbplanner_topic_command_bridge");
  TopicCommandBridge bridge;
  ROS_INFO("[GBPLANNER-TOPIC-BRIDGE] ready");
  ros::spin();
  return 0;
}
