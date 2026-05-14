#include <geometry_msgs/TransformStamped.h>
#include <ros/ros.h>
#include <sensor_msgs/PointCloud2.h>
#include <tf2_ros/buffer.h>
#include <tf2_ros/transform_listener.h>
#include <tf2_sensor_msgs/tf2_sensor_msgs.h>

class PointCloudRealRobotConverter {
 public:
  PointCloudRealRobotConverter() : tf_listener_(tf_buffer_) {
    ros::NodeHandle nh;
    ros::NodeHandle pnh("~");

    std::string input_topic = "/cloud_registered_360";
    std::string output_topic = "/cloud_registered_fixed";
    std::string target_frame = "rmf_obelix/rmf_obelix/velodyne";

    pnh.param("input_topic", input_topic, input_topic);
    pnh.param("output_topic", output_topic, output_topic);
    pnh.param("target_frame", target_frame_, target_frame);
    pnh.param("simple_mode", simple_mode_, false);
    pnh.param("transform_timeout", transform_timeout_, 0.1);
    pnh.param("fallback_to_frame_id_change", fallback_to_frame_id_change_, false);
    pnh.param("use_latest_transform_fallback", use_latest_transform_fallback_, true);
    pnh.param("latest_transform_max_age_sec", latest_transform_max_age_sec_, 0.05);

    pc_sub_ = nh.subscribe(input_topic, 10,
                           &PointCloudRealRobotConverter::pointcloudCallback, this);
    pc_pub_ = nh.advertise<sensor_msgs::PointCloud2>(output_topic, 10);

    ROS_INFO("[pc_real_converter] input: %s", input_topic.c_str());
    ROS_INFO("[pc_real_converter] output: %s", output_topic.c_str());
    ROS_INFO("[pc_real_converter] target_frame: %s", target_frame_.c_str());
    ROS_INFO("[pc_real_converter] simple_mode: %s", simple_mode_ ? "true" : "false");
  }

 private:
  void pointcloudCallback(const sensor_msgs::PointCloud2::ConstPtr& msg) {
    sensor_msgs::PointCloud2 output_cloud;

    if (simple_mode_) {
      output_cloud = *msg;
      output_cloud.header.frame_id = target_frame_;
      pc_pub_.publish(output_cloud);
      return;
    }

    try {
      const geometry_msgs::TransformStamped transform = tf_buffer_.lookupTransform(
          target_frame_, msg->header.frame_id, msg->header.stamp,
          ros::Duration(transform_timeout_));
      tf2::doTransform(*msg, output_cloud, transform);
      transform_success_count_++;
    } catch (const tf2::TransformException& ex) {
      if (use_latest_transform_fallback_ && tryLatestTransform(*msg, output_cloud)) {
        transform_success_count_++;
      } else if (fallback_to_frame_id_change_) {
        ROS_WARN_THROTTLE(5.0,
                          "[pc_real_converter] TF failed: %s. Falling back to frame_id change.",
                          ex.what());
        output_cloud = *msg;
        output_cloud.header.frame_id = target_frame_;
        transform_failure_count_++;
      } else {
        ROS_WARN_THROTTLE(5.0, "[pc_real_converter] dropping cloud, TF failed: %s",
                          ex.what());
        transform_failure_count_++;
        return;
      }
    }

    pc_pub_.publish(output_cloud);
    total_published_count_++;
    ROS_INFO_THROTTLE(5.0,
                      "[pc_real_converter] published=%lu tf_ok=%lu tf_fail=%lu input_frame=%s target_frame=%s",
                      total_published_count_, transform_success_count_,
                      transform_failure_count_, msg->header.frame_id.c_str(),
                      target_frame_.c_str());
  }

  bool tryLatestTransform(const sensor_msgs::PointCloud2& msg,
                          sensor_msgs::PointCloud2& output_cloud) {
    try {
      const geometry_msgs::TransformStamped transform = tf_buffer_.lookupTransform(
          target_frame_, msg.header.frame_id, ros::Time(0),
          ros::Duration(transform_timeout_));
      const double age = std::abs((ros::Time::now() - transform.header.stamp).toSec());
      if (latest_transform_max_age_sec_ > 0.0 && age > latest_transform_max_age_sec_) {
        ROS_WARN_THROTTLE(5.0,
                          "[pc_real_converter] latest TF too old: %.3fs > %.3fs",
                          age, latest_transform_max_age_sec_);
        return false;
      }
      tf2::doTransform(msg, output_cloud, transform);
      output_cloud.header.stamp = msg.header.stamp;
      return true;
    } catch (const tf2::TransformException& ex) {
      ROS_WARN_THROTTLE(5.0, "[pc_real_converter] latest TF fallback failed: %s",
                        ex.what());
      return false;
    }
  }

  ros::Subscriber pc_sub_;
  ros::Publisher pc_pub_;
  tf2_ros::Buffer tf_buffer_;
  tf2_ros::TransformListener tf_listener_;
  std::string target_frame_;
  bool simple_mode_ = false;
  bool fallback_to_frame_id_change_ = false;
  bool use_latest_transform_fallback_ = true;
  double transform_timeout_ = 0.1;
  double latest_transform_max_age_sec_ = 0.05;
  size_t total_published_count_ = 0;
  size_t transform_success_count_ = 0;
  size_t transform_failure_count_ = 0;
};

int main(int argc, char** argv) {
  ros::init(argc, argv, "pointcloud_real_robot_converter_node");
  PointCloudRealRobotConverter converter;
  ros::spin();
  return 0;
}
