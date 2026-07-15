#include <geometry_msgs/TransformStamped.h>
#include <ros/ros.h>
#include <sensor_msgs/PointCloud2.h>
#include <tf2_ros/buffer.h>
#include <tf2_ros/transform_listener.h>
#include <tf2_sensor_msgs/tf2_sensor_msgs.h>

class PointCloudFrameFixerNode {
 public:
  PointCloudFrameFixerNode() : tf_listener_(tf_buffer_) {
    ros::NodeHandle nh;
    ros::NodeHandle pnh("~");

    pnh.param<std::string>("input_topic", input_topic_, "/livox/lidar");
    pnh.param<std::string>("output_topic", output_topic_, "/livox/lidar_fixed");
    pnh.param<std::string>("target_frame", target_frame_, "rmf_obelix/rmf_obelix/velodyne");
    pnh.param("update_stamp_to_now", update_stamp_to_now_, false);
    pnh.param("transform_cloud", transform_cloud_, true);
    pnh.param("transform_timeout", transform_timeout_, 0.05);
    pnh.param("fallback_to_frame_id_change", fallback_to_frame_id_change_, true);
    pnh.param("use_latest_transform_fallback", use_latest_transform_fallback_, true);
    pnh.param("log_period_sec", log_period_sec_, 5.0);

    sub_ = nh.subscribe(input_topic_, 10,
                        &PointCloudFrameFixerNode::cloudCallback, this);
    pub_ = nh.advertise<sensor_msgs::PointCloud2>(output_topic_, 10);

    ROS_INFO("[pc_frame_fixer] subscribing: %s", input_topic_.c_str());
    ROS_INFO("[pc_frame_fixer] publishing: %s with frame_id=%s",
             output_topic_.c_str(), target_frame_.c_str());
    ROS_INFO("[pc_frame_fixer] update_stamp_to_now=%s",
             update_stamp_to_now_ ? "true" : "false");
    ROS_INFO("[pc_frame_fixer] transform_cloud=%s fallback_to_frame_id_change=%s",
             transform_cloud_ ? "true" : "false",
             fallback_to_frame_id_change_ ? "true" : "false");
  }

 private:
  void cloudCallback(const sensor_msgs::PointCloud2::ConstPtr& msg) {
    sensor_msgs::PointCloud2 out;
    bool transformed = false;

    if (transform_cloud_ && msg->header.frame_id != target_frame_) {
      transformed = transformCloud(*msg, out);
    } else {
      out = *msg;
      out.header.frame_id = target_frame_;
      transformed = msg->header.frame_id == target_frame_;
    }

    if (!transformed && fallback_to_frame_id_change_) {
      out = *msg;
      out.header.frame_id = target_frame_;
    } else if (!transformed) {
      ROS_WARN_THROTTLE(
          log_period_sec_,
          "[pc_frame_fixer] dropping cloud: cannot transform %s -> %s",
          msg->header.frame_id.c_str(), target_frame_.c_str());
      ++tf_fail_count_;
      return;
    }

    if (update_stamp_to_now_) {
      out.header.stamp = ros::Time::now();
    }
    const ros::Time now = ros::Time::now();
    const double input_age =
        msg->header.stamp.isZero() ? 0.0 : (now - msg->header.stamp).toSec();
    ROS_INFO_THROTTLE(
        log_period_sec_,
        "[pc_frame_fixer] cloud width=%u height=%u frame %s -> %s stamp %.3f -> %.3f input_age %.3fs tf_ok=%lu tf_fail=%lu fallback=%lu",
        msg->width, msg->height, msg->header.frame_id.c_str(),
        out.header.frame_id.c_str(), msg->header.stamp.toSec(),
        out.header.stamp.toSec(), input_age, tf_ok_count_, tf_fail_count_,
        fallback_count_);
    pub_.publish(out);
  }

  bool transformCloud(const sensor_msgs::PointCloud2& msg,
                      sensor_msgs::PointCloud2& out) {
    try {
      const geometry_msgs::TransformStamped transform =
          tf_buffer_.lookupTransform(target_frame_, msg.header.frame_id,
                                     msg.header.stamp,
                                     ros::Duration(transform_timeout_));
      tf2::doTransform(msg, out, transform);
      ++tf_ok_count_;
      return true;
    } catch (const tf2::TransformException& ex) {
      if (use_latest_transform_fallback_) {
        try {
          const geometry_msgs::TransformStamped transform =
              tf_buffer_.lookupTransform(target_frame_, msg.header.frame_id,
                                         ros::Time(0),
                                         ros::Duration(transform_timeout_));
          tf2::doTransform(msg, out, transform);
          out.header.stamp = msg.header.stamp;
          ++tf_ok_count_;
          return true;
        } catch (const tf2::TransformException& latest_ex) {
          ROS_WARN_THROTTLE(
              log_period_sec_,
              "[pc_frame_fixer] latest TF failed %s -> %s: %s",
              msg.header.frame_id.c_str(), target_frame_.c_str(),
              latest_ex.what());
        }
      } else {
        ROS_WARN_THROTTLE(log_period_sec_,
                          "[pc_frame_fixer] TF failed %s -> %s: %s",
                          msg.header.frame_id.c_str(), target_frame_.c_str(),
                          ex.what());
      }
    }

    ++tf_fail_count_;
    if (fallback_to_frame_id_change_) {
      ++fallback_count_;
      ROS_WARN_THROTTLE(
          log_period_sec_,
          "[pc_frame_fixer] falling back to frame_id change for %s -> %s",
          msg.header.frame_id.c_str(), target_frame_.c_str());
    }
    return false;
  }

  ros::Subscriber sub_;
  ros::Publisher pub_;
  tf2_ros::Buffer tf_buffer_;
  tf2_ros::TransformListener tf_listener_;
  std::string input_topic_;
  std::string output_topic_;
  std::string target_frame_;
  bool update_stamp_to_now_ = false;
  bool transform_cloud_ = true;
  bool fallback_to_frame_id_change_ = true;
  bool use_latest_transform_fallback_ = true;
  double transform_timeout_ = 0.05;
  double log_period_sec_ = 5.0;
  unsigned long tf_ok_count_ = 0;
  unsigned long tf_fail_count_ = 0;
  unsigned long fallback_count_ = 0;
};

int main(int argc, char** argv) {
  ros::init(argc, argv, "pointcloud_frame_fixer_node");
  PointCloudFrameFixerNode node;
  ros::spin();
  return 0;
}
