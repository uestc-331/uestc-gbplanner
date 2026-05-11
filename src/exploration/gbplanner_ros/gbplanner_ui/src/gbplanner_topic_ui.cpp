#include "gbplanner_topic_ui.h"

#include <std_msgs/Bool.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Int32.h>

namespace gbplanner_ui {

gbplanner_topic_panel::gbplanner_topic_panel(QWidget* parent)
    : rviz::Panel(parent) {
  start_planner_pub_ =
      nh_.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/start_planner", 1);
  start_planner_single_pub_ = nh_.advertise<std_msgs::Empty>(
      "/gbplanner_ui/cmd/start_planner_single", 1);
  stop_planner_pub_ =
      nh_.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/stop_planner", 1);
  homing_pub_ =
      nh_.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/homing", 1);
  init_motion_pub_ =
      nh_.advertise<std_msgs::Empty>("/gbplanner_ui/cmd/init_motion", 1);
  plan_to_waypoint_pub_ = nh_.advertise<std_msgs::Empty>(
      "/gbplanner_ui/cmd/plan_to_waypoint", 1);
  global_planner_pub_ =
      nh_.advertise<std_msgs::Int32>("/gbplanner_ui/cmd/global_frontier_id", 1);
  operation_mode_pub_ =
      nh_.advertise<std_msgs::Bool>("/gbplanner_ui/cmd/operation_mode", 1);

  QVBoxLayout* v_box_layout = new QVBoxLayout;

  button_start_planner_ = new QPushButton("Start Planner");
  button_start_planner_single_ = new QPushButton("Start Single Planner");
  button_stop_planner_ = new QPushButton("Stop Planner");
  button_homing_ = new QPushButton("Go Home");
  button_init_motion_ = new QPushButton("Initialization");
  button_plan_to_waypoint_ = new QPushButton("Plan to Waypoint");
  button_global_planner_ = new QPushButton("Run Global");
  button_change_operation_mode_ = new QPushButton("Operation Mode (EXP)");

  global_id_line_edit_ = new QLineEdit();

  v_box_layout->addWidget(button_start_planner_);
  v_box_layout->addWidget(button_start_planner_single_);
  v_box_layout->addWidget(button_stop_planner_);
  v_box_layout->addWidget(button_homing_);
  v_box_layout->addWidget(button_init_motion_);
  v_box_layout->addWidget(button_plan_to_waypoint_);

  QHBoxLayout* global_hbox_layout = new QHBoxLayout;
  global_hbox_layout->addWidget(new QLabel("Frontier ID:"));
  global_hbox_layout->addWidget(global_id_line_edit_);
  global_hbox_layout->addWidget(button_global_planner_);
  v_box_layout->addLayout(global_hbox_layout);
  v_box_layout->addWidget(button_change_operation_mode_);

  setLayout(v_box_layout);

  connect(button_start_planner_, SIGNAL(clicked()), this,
          SLOT(onStartPlannerClick()));
  connect(button_start_planner_single_, SIGNAL(clicked()), this,
          SLOT(onStartPlannerSingleClick()));
  connect(button_stop_planner_, SIGNAL(clicked()), this,
          SLOT(onStopPlannerClick()));
  connect(button_homing_, SIGNAL(clicked()), this, SLOT(onHomingClick()));
  connect(button_init_motion_, SIGNAL(clicked()), this,
          SLOT(onInitMotionClick()));
  connect(button_plan_to_waypoint_, SIGNAL(clicked()), this,
          SLOT(onPlanToWaypointClick()));
  connect(button_global_planner_, SIGNAL(clicked()), this,
          SLOT(onGlobalPlannerClick()));
  connect(button_change_operation_mode_, SIGNAL(clicked()), this,
          SLOT(onChangeOperationModeClick()));
}

void gbplanner_topic_panel::onStartPlannerClick() {
  std_msgs::Empty msg;
  start_planner_pub_.publish(msg);
}

void gbplanner_topic_panel::onStartPlannerSingleClick() {
  std_msgs::Empty msg;
  start_planner_single_pub_.publish(msg);
}

void gbplanner_topic_panel::onStopPlannerClick() {
  std_msgs::Empty msg;
  stop_planner_pub_.publish(msg);
}

void gbplanner_topic_panel::onHomingClick() {
  std_msgs::Empty msg;
  homing_pub_.publish(msg);
}

void gbplanner_topic_panel::onInitMotionClick() {
  std_msgs::Empty msg;
  init_motion_pub_.publish(msg);
}

void gbplanner_topic_panel::onPlanToWaypointClick() {
  std_msgs::Empty msg;
  plan_to_waypoint_pub_.publish(msg);
}

void gbplanner_topic_panel::onGlobalPlannerClick() {
  int id = 0;
  const std::string text = global_id_line_edit_->text().toStdString();
  if (!text.empty()) {
    try {
      id = std::stoi(text);
    } catch (...) {
      ROS_ERROR("[GBPLANNER-UI] invalid frontier id: %s", text.c_str());
      return;
    }
  }
  if (id < 0) {
    ROS_ERROR("[GBPLANNER-UI] frontier id must be non-negative");
    return;
  }
  std_msgs::Int32 msg;
  msg.data = id;
  global_planner_pub_.publish(msg);
}

void gbplanner_topic_panel::onChangeOperationModeClick() {
  waypoint_nav_mode_ = !waypoint_nav_mode_;
  std_msgs::Bool msg;
  msg.data = waypoint_nav_mode_;
  operation_mode_pub_.publish(msg);
  if (waypoint_nav_mode_) {
    button_change_operation_mode_->setText("Operation mode (WP)");
  } else {
    button_change_operation_mode_->setText("Operation mode (EXP)");
  }
}

void gbplanner_topic_panel::save(rviz::Config config) const {
  rviz::Panel::save(config);
}

void gbplanner_topic_panel::load(const rviz::Config& config) {
  rviz::Panel::load(config);
}

}  // namespace gbplanner_ui

#include <pluginlib/class_list_macros.h>
PLUGINLIB_EXPORT_CLASS(gbplanner_ui::gbplanner_topic_panel, rviz::Panel)
