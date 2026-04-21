#ifndef GBPLANNER_UI_H
#define GBPLANNER_UI_H

#include <stdio.h>

#include <ros/ros.h>
#include <std_msgs/ColorRGBA.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Int32.h>

#ifndef Q_MOC_RUN
#include <QHBoxLayout>
#include <QLabel>
#include <QLineEdit>
#include <QPainter>
#include <QPushButton>
#include <QTimer>
#include <QVBoxLayout>
#include <rviz/panel.h>
#endif

class QLineEdit;
class QPushButton;

namespace gbplanner_ui {
class gbplanner_panel : public rviz::Panel {
  Q_OBJECT
 public:
  gbplanner_panel(QWidget* parent = 0);
  virtual void load(const rviz::Config& config);
  virtual void save(rviz::Config config) const;

 public Q_SLOTS:
  void on_start_planner_click();
  void on_stop_planner_click();
  void on_homing_click();
  void on_init_motion_click();
  void on_plan_to_waypoint_click();
  void on_global_planner_click();
 protected Q_SLOTS:

 protected:
 QPushButton* button_start_planner;
  ros::Publisher start_planner_pub;

  QPushButton* button_stop_planner;
  ros::Publisher stop_planner_pub;

  QPushButton* button_homing;
  ros::Publisher homing_pub;

  QPushButton* button_init_motion;
  ros::Publisher init_motion_pub;

  QPushButton* button_plan_to_waypoint;
  ros::Publisher plan_to_waypoint_pub;

  QPushButton* button_global_planner;
  QLineEdit* global_id_line_edit;
  ros::Publisher global_planner_pub;

  ros::NodeHandle nh;
};

}  // namespace gbplanner_ui

#endif  // GBPLANNER_UI_H
