#include <iostream>
#include <string>

#include <ros/ros.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Int32.h>

int main(int argc, char** argv) {
  ros::init(argc, argv, "gbplanner_cli");
  ros::NodeHandle nh;

  ros::Publisher start_planner_pub = nh.advertise<std_msgs::Empty>(
      "/planner_control_interface/std_srvs/automatic_planning", 1);
  ros::Publisher stop_planner_pub = nh.advertise<std_msgs::Empty>(
      "/planner_control_interface/std_srvs/stop", 1);
  ros::Publisher homing_pub = nh.advertise<std_msgs::Empty>(
      "/planner_control_interface/std_srvs/homing_trigger", 1);
  ros::Publisher init_motion_pub =
      nh.advertise<std_msgs::Empty>("pci_initialization_trigger", 1);
  ros::Publisher plan_to_waypoint_pub = nh.advertise<std_msgs::Empty>(
      "/planner_control_interface/std_srvs/go_to_waypoint", 1);
  ros::Publisher global_planner_pub =
      nh.advertise<std_msgs::Int32>("pci_global", 1);

  std::string line;
  while (ros::ok()) {
    std::cout << "\nGbPlanner CLI\n";
    std::cout << "1) Start Planner\n";
    std::cout << "2) Stop Planner\n";
    std::cout << "3) Homing\n";
    std::cout << "4) Initialization\n";
    std::cout << "5) Go To Waypoint\n";
    std::cout << "6) Global Planner\n";
    std::cout << "0) Exit\n";
    std::cout << "Select> " << std::flush;
    if (!std::getline(std::cin, line)) {
      break;
    }

    if (line == "0") {
      break;
    } else if (line == "1") {
      start_planner_pub.publish(std_msgs::Empty());
      std::cout << "Start Planner sent.\n";
    } else if (line == "2") {
      stop_planner_pub.publish(std_msgs::Empty());
      std::cout << "Stop Planner sent.\n";
    } else if (line == "3") {
      homing_pub.publish(std_msgs::Empty());
      std::cout << "Homing sent.\n";
    } else if (line == "4") {
      init_motion_pub.publish(std_msgs::Empty());
      std::cout << "Initialization sent.\n";
    } else if (line == "5") {
      plan_to_waypoint_pub.publish(std_msgs::Empty());
      std::cout << "Go To Waypoint sent.\n";
    } else if (line == "6") {
      std_msgs::Int32 msg;
      msg.data = 0;
      global_planner_pub.publish(msg);
      std::cout << "Global Planner sent (frontier_id=0).\n";
    } else {
      std::cout << "Unknown command. Use 0-6.\n";
    }

    ros::spinOnce();
  }

  std::cout << "Exiting.\n";
  return 0;
}
