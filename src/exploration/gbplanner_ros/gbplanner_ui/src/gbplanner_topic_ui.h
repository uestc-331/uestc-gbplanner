#ifndef GBPLANNER_TOPIC_UI_H
#define GBPLANNER_TOPIC_UI_H

#include <ros/ros.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Int32.h>

#ifndef Q_MOC_RUN
#include <QHBoxLayout>
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QVBoxLayout>
#include <rviz/panel.h>
#endif

class QLineEdit;
class QPushButton;

namespace gbplanner_ui {

class gbplanner_topic_panel : public rviz::Panel {
  Q_OBJECT
 public:
  gbplanner_topic_panel(QWidget* parent = 0);
  virtual void load(const rviz::Config& config);
  virtual void save(rviz::Config config) const;

 public Q_SLOTS:
  void onStartPlannerClick();
  void onStartPlannerSingleClick();
  void onStopPlannerClick();
  void onHomingClick();
  void onInitMotionClick();
  void onPlanToWaypointClick();
  void onGlobalPlannerClick();
  void onChangeOperationModeClick();

 protected:
  QPushButton* button_start_planner_;
  QPushButton* button_start_planner_single_;
  QPushButton* button_stop_planner_;
  QPushButton* button_homing_;
  QPushButton* button_init_motion_;
  QPushButton* button_plan_to_waypoint_;
  QPushButton* button_global_planner_;
  QPushButton* button_change_operation_mode_;
  QLineEdit* global_id_line_edit_;

  ros::NodeHandle nh_;
  ros::Publisher start_planner_pub_;
  ros::Publisher start_planner_single_pub_;
  ros::Publisher stop_planner_pub_;
  ros::Publisher homing_pub_;
  ros::Publisher init_motion_pub_;
  ros::Publisher plan_to_waypoint_pub_;
  ros::Publisher global_planner_pub_;
  ros::Publisher operation_mode_pub_;

  bool waypoint_nav_mode_ = false;
};

}  // namespace gbplanner_ui

#endif  // GBPLANNER_TOPIC_UI_H
