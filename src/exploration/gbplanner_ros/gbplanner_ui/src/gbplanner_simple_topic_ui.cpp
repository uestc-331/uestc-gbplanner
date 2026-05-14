#include <ros/ros.h>
#include <std_msgs/Empty.h>

#include <sys/select.h>
#include <termios.h>
#include <unistd.h>

#include <iostream>
#include <string>

namespace {

class TerminalRawMode {
 public:
  TerminalRawMode() {
    if (tcgetattr(STDIN_FILENO, &old_) != 0) {
      valid_ = false;
      return;
    }

    termios raw = old_;
    raw.c_lflag &= static_cast<unsigned>(~(ICANON | ECHO));
    raw.c_cc[VMIN] = 0;
    raw.c_cc[VTIME] = 0;
    valid_ = (tcsetattr(STDIN_FILENO, TCSANOW, &raw) == 0);
  }

  ~TerminalRawMode() {
    if (valid_) {
      tcsetattr(STDIN_FILENO, TCSANOW, &old_);
    }
  }

 private:
  termios old_{};
  bool valid_{false};
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
  if (read(STDIN_FILENO, &c, 1) == 1) {
    return c;
  }
  return 0;
}

bool waitForSubscriber(const ros::Publisher& pub,
                       const std::string& topic_name) {
  ros::WallRate rate(20.0);
  const ros::WallTime deadline =
      ros::WallTime::now() + ros::WallDuration(1.0);

  while (ros::ok() && pub.getNumSubscribers() == 0 &&
         ros::WallTime::now() < deadline) {
    ros::spinOnce();
    rate.sleep();
  }

  if (pub.getNumSubscribers() == 0) {
    ROS_WARN("[GBPLANNER-SIMPLE-UI] no subscriber on %s", topic_name.c_str());
    return false;
  }
  return true;
}

void publishEmptyCommand(const ros::Publisher& pub,
                         const std::string& topic_name,
                         const std::string& label) {
  if (!waitForSubscriber(pub, topic_name)) {
    std::cout << label << " topic has no subscriber.\n";
    return;
  }

  pub.publish(std_msgs::Empty());
  ros::spinOnce();
  ros::WallDuration(0.05).sleep();
  std::cout << label << " topic sent.\n";
  ROS_INFO("[GBPLANNER-SIMPLE-UI] %s", label.c_str());
}

void printMenu() {
  std::cout << "\nGBPlanner Simple Topic UI\n"
            << "1: Start Planner\n"
            << "2: Stop Planner\n"
            << "3: Homing\n"
            << "4: Start Single Planner\n"
            << "5: Init Motion\n"
            << "q: Quit\n"
            << "Press key> " << std::flush;
}

}  // namespace

int main(int argc, char** argv) {
  ros::init(argc, argv, "gbplanner_simple_topic_ui");
  ros::NodeHandle nh;

  ros::Publisher start_planner_pub =
      nh.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/start_planner", 1);
  ros::Publisher stop_planner_pub =
      nh.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/stop_planner", 1);
  ros::Publisher homing_pub =
      nh.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/homing", 1);
  ros::Publisher start_single_pub =
      nh.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/start_planner_single", 1);
  ros::Publisher init_motion_pub =
      nh.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/init_motion", 1);

  TerminalRawMode raw_mode;
  printMenu();

  ros::WallRate rate(20.0);
  while (ros::ok()) {
    if (keyAvailable()) {
      const char key = readKey();

      switch (key) {
        case '1':
          publishEmptyCommand(start_planner_pub,
                              "/gbplanner_ui/cmd/start_planner",
                              "Start Planner");
          printMenu();
          break;
        case '2':
          publishEmptyCommand(stop_planner_pub,
                              "/gbplanner_ui/cmd/stop_planner",
                              "Stop Planner");
          printMenu();
          break;
        case '3':
          publishEmptyCommand(homing_pub, "/gbplanner_ui/cmd/homing",
                              "Homing");
          printMenu();
          break;
        case '4':
          publishEmptyCommand(start_single_pub,
                              "/gbplanner_ui/cmd/start_planner_single",
                              "Start Single Planner");
          printMenu();
          break;
        case '5':
          publishEmptyCommand(init_motion_pub,
                              "/gbplanner_ui/cmd/init_motion", "Init Motion");
          printMenu();
          break;
        case 'q':
        case 'Q':
          std::cout << "\nExiting.\n";
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
