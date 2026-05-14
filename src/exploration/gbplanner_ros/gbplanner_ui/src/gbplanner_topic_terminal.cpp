#include <ros/ros.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Int32.h>

#include <sys/select.h>
#include <termios.h>
#include <unistd.h>

#include <iostream>
#include <string>

namespace {

class TerminalRawMode {
 public:
  TerminalRawMode() {
    tcgetattr(STDIN_FILENO, &old_);
    termios raw = old_;
    raw.c_lflag &= static_cast<unsigned>(~(ICANON | ECHO));
    raw.c_cc[VMIN] = 0;
    raw.c_cc[VTIME] = 0;
    tcsetattr(STDIN_FILENO, TCSANOW, &raw);
  }

  ~TerminalRawMode() { tcsetattr(STDIN_FILENO, TCSANOW, &old_); }

 private:
  termios old_{};
};

bool keyAvailable() {
  timeval tv{};
  fd_set fds;
  FD_ZERO(&fds);
  FD_SET(STDIN_FILENO, &fds);
  return select(STDIN_FILENO + 1, &fds, nullptr, nullptr, &tv) > 0;
}

char readKey() {
  char c = 0;
  if (read(STDIN_FILENO, &c, 1) == 1) return c;
  return 0;
}

}  // namespace

int main(int argc, char** argv) {
  ros::init(argc, argv, "gbplanner_topic_terminal");
  ros::NodeHandle nh;
  ros::NodeHandle pnh("~");

  int global_frontier_id = 0;
  pnh.param("global_frontier_id", global_frontier_id, 0);

  auto pub_empty = [&](const std::string& topic) {
    return nh.advertise<std_msgs::Empty>(topic, 1);
  };
  auto pub_int = [&](const std::string& topic) {
    return nh.advertise<std_msgs::Int32>(topic, 1);
  };
  auto pub_bool = [&](const std::string& topic) {
    return nh.advertise<std_msgs::Bool>(topic, 1);
  };

  ros::Publisher start_planner_pub = pub_empty("/gbplanner_ui/cmd/start_planner");
  ros::Publisher start_single_pub =
      pub_empty("/gbplanner_ui/cmd/start_planner_single");
  ros::Publisher stop_pub = pub_empty("/gbplanner_ui/cmd/stop_planner");
  ros::Publisher homing_pub = pub_empty("/gbplanner_ui/cmd/homing");
  ros::Publisher init_pub = pub_empty("/gbplanner_ui/cmd/init_motion");
  ros::Publisher waypoint_pub =
      pub_empty("/gbplanner_ui/cmd/plan_to_waypoint");
  ros::Publisher global_pub =
      pub_int("/gbplanner_ui/cmd/global_frontier_id");
  ros::Publisher operation_mode_pub =
      pub_bool("/gbplanner_ui/cmd/operation_mode");

  TerminalRawMode raw_mode;

  std::cout
      << "GBPlanner keyboard control ready\n"
      << "Keys:\n"
      << "  1: Start Auto Planning\n"
      << "  2: Start Single Planning\n"
      << "  3: Stop Planning\n"
      << "  4: Go Home\n"
      << "  5: Initialization Motion\n"
      << "  6: Plan To Waypoint\n"
      << "  7: Run Global Planner\n"
      << "  8: Toggle Operation Mode\n"
      << "  q: Quit\n";

  bool waypoint_mode = false;
  ros::Rate rate(20);
  while (ros::ok()) {
    if (keyAvailable()) {
      const char key = readKey();
      std_msgs::Empty empty_msg;
      std_msgs::Int32 id_msg;
      std_msgs::Bool bool_msg;

      switch (key) {
        case '1':
          start_planner_pub.publish(empty_msg);
          ROS_INFO("[GBPLANNER-KEYBOARD] Start Auto Planning");
          break;
        case '2':
          start_single_pub.publish(empty_msg);
          ROS_INFO("[GBPLANNER-KEYBOARD] Start Single Planning");
          break;
        case '3':
          stop_pub.publish(empty_msg);
          ROS_INFO("[GBPLANNER-KEYBOARD] Stop Planning");
          break;
        case '4':
          homing_pub.publish(empty_msg);
          ROS_INFO("[GBPLANNER-KEYBOARD] Go Home");
          break;
        case '5':
          init_pub.publish(empty_msg);
          ROS_INFO("[GBPLANNER-KEYBOARD] Initialization Motion");
          break;
        case '6':
          waypoint_pub.publish(empty_msg);
          ROS_INFO("[GBPLANNER-KEYBOARD] Plan To Waypoint");
          break;
        case '7':
          id_msg.data = global_frontier_id;
          global_pub.publish(id_msg);
          ROS_INFO("[GBPLANNER-KEYBOARD] Run Global Planner frontier_id=%d",
                   global_frontier_id);
          break;
        case '8':
          waypoint_mode = !waypoint_mode;
          bool_msg.data = waypoint_mode;
          operation_mode_pub.publish(bool_msg);
          ROS_INFO("[GBPLANNER-KEYBOARD] Toggle Operation Mode waypoint_mode=%d",
                   waypoint_mode);
          break;
        case 'q':
          ROS_INFO("[GBPLANNER-KEYBOARD] Quit");
          return 0;
        default:
          break;
      }
    }
    ros::spinOnce();
    rate.sleep();
  }
  return 0;
}
