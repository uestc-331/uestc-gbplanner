#include <array>
#include <cmath>
#include <cstring>
#include <vector>

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
    pnh.param("self_filter_enable", self_filter_enable_, true);
    pnh.param("publish_self_filter_debug", publish_self_filter_debug_, true);
    pnh.param("self_filter/body_half_x", body_half_x_, 0.255);
    pnh.param("self_filter/body_half_y", body_half_y_, 0.255);
    pnh.param("self_filter/body_min_z", body_min_z_, -0.140);
    pnh.param("self_filter/body_max_z", body_max_z_, 0.010);
    pnh.param("self_filter/rotor_radius", rotor_radius_, 0.148);
    pnh.param("self_filter/rotor_center_z", rotor_center_z_, -0.042);
    pnh.param("self_filter/rotor_half_height", rotor_half_height_, 0.035);

    sub_ = nh.subscribe(input_topic_, 10,
                        &PointCloudFrameFixerNode::cloudCallback, this);
    pub_ = nh.advertise<sensor_msgs::PointCloud2>(output_topic_, 10);
    if (publish_self_filter_debug_) {
      self_points_pub_ =
          nh.advertise<sensor_msgs::PointCloud2>("/livox/lidar_self_points", 1);
    }

    ROS_INFO("[pc_frame_fixer] subscribing: %s", input_topic_.c_str());
    ROS_INFO("[pc_frame_fixer] publishing: %s with frame_id=%s",
             output_topic_.c_str(), target_frame_.c_str());
    ROS_INFO("[pc_frame_fixer] update_stamp_to_now=%s",
             update_stamp_to_now_ ? "true" : "false");
    ROS_INFO("[pc_frame_fixer] transform_cloud=%s fallback_to_frame_id_change=%s",
             transform_cloud_ ? "true" : "false",
             fallback_to_frame_id_change_ ? "true" : "false");
    ROS_INFO("[pc_frame_fixer] self_filter=%s body=[+/-%.3f,+/-%.3f,%.3f..%.3f] rotor_radius=%.3f",
             self_filter_enable_ ? "true" : "false", body_half_x_,
             body_half_y_, body_min_z_, body_max_z_, rotor_radius_);
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

    const size_t points_before =
        static_cast<size_t>(out.width) * static_cast<size_t>(out.height);
    sensor_msgs::PointCloud2 removed_points;
    const bool make_debug_cloud =
        publish_self_filter_debug_ && self_points_pub_.getNumSubscribers() > 0;
    const size_t removed =
        self_filter_enable_
            ? filterSelfPoints(out, make_debug_cloud ? &removed_points : nullptr)
            : 0;
    self_points_removed_count_ += removed;
    if (make_debug_cloud) {
      self_points_pub_.publish(removed_points);
    }

    const ros::Time now = ros::Time::now();
    const double input_age =
        msg->header.stamp.isZero() ? 0.0 : (now - msg->header.stamp).toSec();
    ROS_INFO_THROTTLE(
        log_period_sec_,
        "[pc_frame_fixer] cloud points=%zu -> %u self_removed=%zu total_removed=%lu frame %s -> %s stamp %.3f -> %.3f input_age %.3fs tf_ok=%lu tf_fail=%lu fallback=%lu",
        points_before, out.width, removed, self_points_removed_count_,
        msg->header.frame_id.c_str(),
        out.header.frame_id.c_str(), msg->header.stamp.toSec(),
        out.header.stamp.toSec(), input_age, tf_ok_count_, tf_fail_count_,
        fallback_count_);
    pub_.publish(out);
  }

  int fieldOffset(const sensor_msgs::PointCloud2& cloud,
                  const std::string& name) const {
    for (const sensor_msgs::PointField& field : cloud.fields) {
      if (field.name == name &&
          field.datatype == sensor_msgs::PointField::FLOAT32) {
        return static_cast<int>(field.offset);
      }
    }
    return -1;
  }

  bool isSelfPoint(float x, float y, float z) const {
    if (std::abs(x) <= body_half_x_ && std::abs(y) <= body_half_y_ &&
        z >= body_min_z_ && z <= body_max_z_) {
      return true;
    }

    if (std::abs(z - rotor_center_z_) > rotor_half_height_) {
      return false;
    }
    const double radius_squared = rotor_radius_ * rotor_radius_;
    for (const auto& center : rotor_centers_) {
      const double dx = static_cast<double>(x) - center[0];
      const double dy = static_cast<double>(y) - center[1];
      if (dx * dx + dy * dy <= radius_squared) {
        return true;
      }
    }
    return false;
  }

  size_t filterSelfPoints(sensor_msgs::PointCloud2& cloud,
                          sensor_msgs::PointCloud2* removed_cloud) {
    if (cloud.is_bigendian || cloud.point_step == 0) {
      ROS_WARN_THROTTLE(log_period_sec_,
                        "[pc_frame_fixer] self-filter skipped: unsupported point cloud layout");
      return 0;
    }

    const int x_offset = fieldOffset(cloud, "x");
    const int y_offset = fieldOffset(cloud, "y");
    const int z_offset = fieldOffset(cloud, "z");
    if (x_offset < 0 || y_offset < 0 || z_offset < 0) {
      ROS_WARN_THROTTLE(log_period_sec_,
                        "[pc_frame_fixer] self-filter skipped: FLOAT32 x/y/z fields missing");
      return 0;
    }

    const size_t total_points =
        static_cast<size_t>(cloud.width) * static_cast<size_t>(cloud.height);
    std::vector<uint8_t> kept_data;
    kept_data.reserve(total_points * cloud.point_step);
    std::vector<uint8_t> removed_data;
    if (removed_cloud != nullptr) {
      removed_data.reserve(total_points * cloud.point_step / 4);
    }

    for (uint32_t row = 0; row < cloud.height; ++row) {
      for (uint32_t col = 0; col < cloud.width; ++col) {
        const size_t point_offset =
            static_cast<size_t>(row) * cloud.row_step +
            static_cast<size_t>(col) * cloud.point_step;
        if (point_offset + cloud.point_step > cloud.data.size()) {
          continue;
        }
        const uint8_t* point = cloud.data.data() + point_offset;
        float x = 0.0f;
        float y = 0.0f;
        float z = 0.0f;
        std::memcpy(&x, point + x_offset, sizeof(float));
        std::memcpy(&y, point + y_offset, sizeof(float));
        std::memcpy(&z, point + z_offset, sizeof(float));

        std::vector<uint8_t>& destination =
            isSelfPoint(x, y, z) ? removed_data : kept_data;
        destination.insert(destination.end(), point, point + cloud.point_step);
      }
    }

    const size_t removed_count = removed_data.size() / cloud.point_step;
    cloud.data.swap(kept_data);
    cloud.height = 1;
    cloud.width = static_cast<uint32_t>(cloud.data.size() / cloud.point_step);
    cloud.row_step = cloud.width * cloud.point_step;

    if (removed_cloud != nullptr) {
      *removed_cloud = cloud;
      removed_cloud->data.swap(removed_data);
      removed_cloud->width = static_cast<uint32_t>(removed_count);
      removed_cloud->row_step = removed_cloud->width * removed_cloud->point_step;
    }
    return removed_count;
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
  ros::Publisher self_points_pub_;
  tf2_ros::Buffer tf_buffer_;
  tf2_ros::TransformListener tf_listener_;
  std::string input_topic_;
  std::string output_topic_;
  std::string target_frame_;
  bool update_stamp_to_now_ = false;
  bool transform_cloud_ = true;
  bool fallback_to_frame_id_change_ = true;
  bool use_latest_transform_fallback_ = true;
  bool self_filter_enable_ = true;
  bool publish_self_filter_debug_ = true;
  double transform_timeout_ = 0.05;
  double log_period_sec_ = 5.0;
  double body_half_x_ = 0.255;
  double body_half_y_ = 0.255;
  double body_min_z_ = -0.140;
  double body_max_z_ = 0.010;
  double rotor_radius_ = 0.148;
  double rotor_center_z_ = -0.042;
  double rotor_half_height_ = 0.035;
  const std::array<std::array<double, 2>, 4> rotor_centers_{{
      {{0.13, -0.22}}, {{-0.13, 0.20}},
      {{0.13, 0.22}}, {{-0.13, -0.20}}}};
  unsigned long tf_ok_count_ = 0;
  unsigned long tf_fail_count_ = 0;
  unsigned long fallback_count_ = 0;
  unsigned long self_points_removed_count_ = 0;
};

int main(int argc, char** argv) {
  ros::init(argc, argv, "pointcloud_frame_fixer_node");
  PointCloudFrameFixerNode node;
  ros::spin();
  return 0;
}
