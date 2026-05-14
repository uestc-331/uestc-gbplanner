#include <iostream>
#include <string>

#include <ros/ros.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Int32.h>

namespace {

bool waitForSubscribers(const ros::Publisher& pub,
                        const std::string& topic_name) {
  ros::Rate rate(20.0);
  const ros::Time deadline = ros::Time::now() + ros::Duration(2.0);
  while (ros::ok() && pub.getNumSubscribers() == 0 &&
         ros::Time::now() < deadline) {
    ros::spinOnce();
    rate.sleep();
  }

  if (pub.getNumSubscribers() == 0) {
    ROS_WARN("[GBPLANNER-CLI] no subscriber connected on %s", topic_name.c_str());
    return false;
  }
  return true;
}

template <typename MessageT>
void publishCommand(const ros::Publisher& pub, const MessageT& msg,
                    const std::string& topic_name) {
  if (!waitForSubscribers(pub, topic_name)) {
    return;
  }
  pub.publish(msg);
  ros::spinOnce();
  ros::Duration(0.1).sleep();
}

}  // namespace

int main(int argc, char** argv) {
  ros::init(argc, argv, "gbplanner_cli");
  ros::NodeHandle nh;

  ros::Publisher start_planner_pub =
      nh.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/start_planner", 1);
  ros::Publisher stop_planner_pub =
      nh.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/stop_planner", 1);
  ros::Publisher homing_pub =
      nh.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/homing", 1);
  ros::Publisher init_motion_pub =
      nh.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/init_motion", 1);
  ros::Publisher plan_to_waypoint_pub =
      nh.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/plan_to_waypoint", 1);
  ros::Publisher global_planner_pub =
      nh.advertise<std_msgs::Int32>("/gbplanner_ui/cmd/global_frontier_id", 1);
  ros::Publisher operation_mode_pub =
      nh.advertise<std_msgs::Bool>("/gbplanner_ui/cmd/operation_mode", 1);

  std::string line;
  bool waypoint_mode = false;
  while (ros::ok()) {
    std::cout << "\nGbPlanner CLI\n";
    std::cout << "1) Start Planner\n";
    std::cout << "2) Stop Planner\n";
    std::cout << "3) Homing\n";
    std::cout << "4) Initialization\n";
    std::cout << "5) Go To Waypoint\n";
    std::cout << "6) Global Planner\n";
    std::cout << "7) Toggle Operation Mode\n";
    std::cout << "0) Exit\n";
    std::cout << "Select> " << std::flush;
    if (!std::getline(std::cin, line)) {
      break;
    }

    if (line == "0") {
      break;
    } else if (line == "1") {
      publishCommand(start_planner_pub, std_msgs::Empty(),
                     "/gbplanner_ui/cmd/start_planner");
      std::cout << "Start Planner topic sent.\n";
    } else if (line == "2") {
      publishCommand(stop_planner_pub, std_msgs::Empty(),
                     "/gbplanner_ui/cmd/stop_planner");
      std::cout << "Stop Planner topic sent.\n";
    } else if (line == "3") {
      publishCommand(homing_pub, std_msgs::Empty(), "/gbplanner_ui/cmd/homing");
      std::cout << "Homing topic sent.\n";
    } else if (line == "4") {
      publishCommand(init_motion_pub, std_msgs::Empty(),
                     "/gbplanner_ui/cmd/init_motion");
      std::cout << "Initialization topic sent.\n";
    } else if (line == "5") {
      publishCommand(plan_to_waypoint_pub, std_msgs::Empty(),
                     "/gbplanner_ui/cmd/plan_to_waypoint");
      std::cout << "Go To Waypoint topic sent.\n";
    } else if (line == "6") {
      std_msgs::Int32 msg;
      msg.data = 0;
      publishCommand(global_planner_pub, msg,
                     "/gbplanner_ui/cmd/global_frontier_id");
      std::cout << "Global Planner topic sent (frontier_id=0).\n";
    } else if (line == "7") {
      waypoint_mode = !waypoint_mode;
      std_msgs::Bool msg;
      msg.data = waypoint_mode;
      publishCommand(operation_mode_pub, msg,
                     "/gbplanner_ui/cmd/operation_mode");
      std::cout << "Operation Mode topic sent (waypoint_mode="
                << waypoint_mode << ").\n";
    } else {
      std::cout << "Unknown command. Use 0-7.\n";
    }

    ros::spinOnce();
  }

  std::cout << "Exiting.\n";
  return 0;
}
