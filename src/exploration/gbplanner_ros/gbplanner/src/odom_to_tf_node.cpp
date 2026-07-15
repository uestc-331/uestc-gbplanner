#include <nav_msgs/Odometry.h>
#include <ros/ros.h>
#include <tf/transform_broadcaster.h>

class OdomToTfNode {
 public:
  OdomToTfNode() {
    ros::NodeHandle nh;
    ros::NodeHandle pnh("~");

    pnh.param<std::string>("odom_topic", odom_topic_, "/vins_fusion/imu_propagate");
    pnh.param<std::string>("parent_frame", parent_frame_, "world");
    pnh.param<std::string>("child_frame", child_frame_, "rmf_obelix/base_link");
    pnh.param("use_odom_frame", use_odom_frame_, false);
    pnh.param("publish_rate", publish_rate_, 100.0);

    odom_sub_ = nh.subscribe(odom_topic_, 10, &OdomToTfNode::odomCallback, this);
    tf_timer_ = nh.createTimer(ros::Duration(1.0 / publish_rate_),
                               &OdomToTfNode::timerCallback, this);

    ROS_INFO("[odom_to_tf] subscribing: %s", odom_topic_.c_str());
    ROS_INFO("[odom_to_tf] publishing TF %s -> %s at %.1f Hz",
             parent_frame_.c_str(), child_frame_.c_str(), publish_rate_);
  }

 private:
  void odomCallback(const nav_msgs::Odometry::ConstPtr& msg) {
    latest_odom_ = *msg;
    latest_stamp_ = msg->header.stamp;
    latest_parent_frame_ = use_odom_frame_ ? msg->header.frame_id : parent_frame_;
    if (latest_parent_frame_.empty()) {
      latest_parent_frame_ = "world";
    }
    has_odom_ = true;

    publishTf(latest_stamp_);
  }

  void timerCallback(const ros::TimerEvent&) {
    if (!has_odom_) {
      ROS_WARN_THROTTLE(5.0, "[odom_to_tf] waiting for odometry on %s",
                        odom_topic_.c_str());
      return;
    }

    publishTf(ros::Time::now());
  }

  void publishTf(const ros::Time& stamp) {
    const ros::Time publish_stamp = stamp.isZero() ? ros::Time::now() : stamp;
    if (!last_publish_stamp_.isZero() && publish_stamp <= last_publish_stamp_) {
      ROS_WARN_THROTTLE(
          5.0,
          "[odom_to_tf] skip non-increasing TF stamp %.6f <= %.6f for %s -> %s",
          publish_stamp.toSec(), last_publish_stamp_.toSec(),
          latest_parent_frame_.c_str(), child_frame_.c_str());
      return;
    }

    geometry_msgs::TransformStamped tf_msg;
    tf_msg.header.stamp = publish_stamp;
    tf_msg.header.frame_id = latest_parent_frame_;
    tf_msg.child_frame_id = child_frame_;
    tf_msg.transform.translation.x = latest_odom_.pose.pose.position.x;
    tf_msg.transform.translation.y = latest_odom_.pose.pose.position.y;
    tf_msg.transform.translation.z = latest_odom_.pose.pose.position.z;
    tf_msg.transform.rotation = latest_odom_.pose.pose.orientation;

    broadcaster_.sendTransform(tf_msg);
    last_publish_stamp_ = publish_stamp;
  }

  ros::Subscriber odom_sub_;
  ros::Timer tf_timer_;
  tf::TransformBroadcaster broadcaster_;

  std::string odom_topic_;
  std::string parent_frame_;
  std::string latest_parent_frame_;
  std::string child_frame_;
  double publish_rate_;
  bool use_odom_frame_;
  bool has_odom_ = false;

  nav_msgs::Odometry latest_odom_;
  ros::Time latest_stamp_;
  ros::Time last_publish_stamp_;
};

int main(int argc, char** argv) {
  ros::init(argc, argv, "odom_to_tf_node");
  OdomToTfNode node;
  ros::spin();
  return 0;
}
