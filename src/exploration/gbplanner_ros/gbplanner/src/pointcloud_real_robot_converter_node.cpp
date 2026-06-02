#include <geometry_msgs/TransformStamped.h>
#include <ros/ros.h>
#include <sensor_msgs/PointField.h>
#include <sensor_msgs/PointCloud2.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <tf2_ros/buffer.h>
#include <tf2_ros/transform_listener.h>
#include <tf2_sensor_msgs/tf2_sensor_msgs.h>

#include <algorithm>
#include <array>
#include <cmath>
#include <cstdint>
#include <cstring>
#include <string>
#include <vector>

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
    pnh.param("virtual_z_walls_enable", virtual_z_walls_enable_, false);
    pnh.param("virtual_z_walls_bounds_param_ns", virtual_z_walls_bounds_param_ns_,
              std::string("/gbplanner_node/BoundedSpaceParams/Global"));
    pnh.param("virtual_z_walls_frame", virtual_z_walls_frame_, std::string("world"));
    pnh.param("virtual_z_walls_resolution", virtual_z_walls_resolution_, 0.2);
    pnh.param("virtual_z_walls_forward_length", virtual_z_walls_forward_length_, 8.0);
    pnh.param("virtual_z_walls_backward_length", virtual_z_walls_backward_length_, 2.0);
    pnh.param("virtual_z_walls_use_global_xy", virtual_z_walls_use_global_xy_, false);
    pnh.param("virtual_z_walls_add_min_z", virtual_z_walls_add_min_z_, true);
    pnh.param("virtual_z_walls_add_max_z", virtual_z_walls_add_max_z_, true);

    pc_sub_ = nh.subscribe(input_topic, 10,
                           &PointCloudRealRobotConverter::pointcloudCallback, this);
    pc_pub_ = nh.advertise<sensor_msgs::PointCloud2>(output_topic, 10);

    ROS_INFO("[pc_real_converter] input: %s", input_topic.c_str());
    ROS_INFO("[pc_real_converter] output: %s", output_topic.c_str());
    ROS_INFO("[pc_real_converter] target_frame: %s", target_frame_.c_str());
    ROS_INFO("[pc_real_converter] simple_mode: %s", simple_mode_ ? "true" : "false");
    ROS_INFO("[pc_real_converter] virtual_z_walls: %s", virtual_z_walls_enable_ ? "true" : "false");
  }

 private:
  void pointcloudCallback(const sensor_msgs::PointCloud2::ConstPtr& msg) {
    sensor_msgs::PointCloud2 output_cloud;

    if (simple_mode_) {
      output_cloud = *msg;
      output_cloud.header.frame_id = target_frame_;
    } else {
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
    }

    if (virtual_z_walls_enable_) {
      appendVirtualZWalls(output_cloud, msg->header.stamp);
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

  struct Bounds {
    double min_x = 0.0;
    double min_y = 0.0;
    double min_z = 0.0;
    double max_x = 0.0;
    double max_y = 0.0;
    double max_z = 0.0;
  };

  bool loadVirtualZWallBounds() {
    const ros::Time now = ros::Time::now();
    if (virtual_z_wall_bounds_loaded_ &&
        (now - last_bounds_load_time_).toSec() < 1.0) {
      return true;
    }
    last_bounds_load_time_ = now;

    std::vector<double> min_val;
    std::vector<double> max_val;
    if (!ros::param::get(virtual_z_walls_bounds_param_ns_ + "/min_val", min_val) ||
        !ros::param::get(virtual_z_walls_bounds_param_ns_ + "/max_val", max_val) ||
        min_val.size() != 3 || max_val.size() != 3) {
      ROS_WARN_THROTTLE(
          5.0,
          "[pc_real_converter] virtual z walls waiting for bounds at %s/{min_val,max_val}",
          virtual_z_walls_bounds_param_ns_.c_str());
      return virtual_z_wall_bounds_loaded_;
    }

    Bounds bounds;
    bounds.min_x = min_val[0];
    bounds.min_y = min_val[1];
    bounds.min_z = min_val[2];
    bounds.max_x = max_val[0];
    bounds.max_y = max_val[1];
    bounds.max_z = max_val[2];
    if (bounds.min_x > bounds.max_x || bounds.min_y > bounds.max_y ||
        bounds.min_z > bounds.max_z) {
      ROS_WARN_THROTTLE(5.0,
                        "[pc_real_converter] virtual z walls invalid bounds: "
                        "min=[%.2f %.2f %.2f] max=[%.2f %.2f %.2f]",
                        bounds.min_x, bounds.min_y, bounds.min_z, bounds.max_x,
                        bounds.max_y, bounds.max_z);
      return virtual_z_wall_bounds_loaded_;
    }

    virtual_z_wall_bounds_ = bounds;
    virtual_z_wall_bounds_loaded_ = true;
    ROS_INFO_THROTTLE(10.0,
                      "[pc_real_converter] virtual z walls bounds: "
                      "min=[%.2f %.2f %.2f] max=[%.2f %.2f %.2f]",
                      bounds.min_x, bounds.min_y, bounds.min_z, bounds.max_x,
                      bounds.max_y, bounds.max_z);
    return true;
  }

  bool lookupTransformWithFallback(const std::string& target_frame,
                                   const std::string& source_frame,
                                   const ros::Time& stamp,
                                   geometry_msgs::TransformStamped& transform) {
    try {
      transform = tf_buffer_.lookupTransform(target_frame, source_frame, stamp,
                                             ros::Duration(transform_timeout_));
      return true;
    } catch (const tf2::TransformException& ex) {
      if (!use_latest_transform_fallback_) {
        ROS_WARN_THROTTLE(5.0, "[pc_real_converter] virtual z walls TF failed: %s",
                          ex.what());
        return false;
      }
    }

    try {
      transform = tf_buffer_.lookupTransform(target_frame, source_frame, ros::Time(0),
                                             ros::Duration(transform_timeout_));
      return true;
    } catch (const tf2::TransformException& ex) {
      ROS_WARN_THROTTLE(5.0,
                        "[pc_real_converter] virtual z walls latest TF failed: %s",
                        ex.what());
      return false;
    }
  }

  std::vector<std::array<float, 3>> buildVirtualZWallPoints(const ros::Time& stamp) {
    std::vector<std::array<float, 3>> points;
    if (!loadVirtualZWallBounds()) return points;
    if (virtual_z_walls_resolution_ <= 0.0) {
      ROS_WARN_THROTTLE(5.0,
                        "[pc_real_converter] virtual z walls resolution must be > 0.");
      return points;
    }
    if (!virtual_z_walls_add_min_z_ && !virtual_z_walls_add_max_z_) return points;

    geometry_msgs::TransformStamped wall_from_target_msg;
    geometry_msgs::TransformStamped target_from_wall_msg;
    if (!lookupTransformWithFallback(virtual_z_walls_frame_, target_frame_, stamp,
                                     wall_from_target_msg) ||
        !lookupTransformWithFallback(target_frame_, virtual_z_walls_frame_, stamp,
                                     target_from_wall_msg)) {
      return points;
    }

    tf2::Transform target_from_wall;
    tf2::fromMsg(target_from_wall_msg.transform, target_from_wall);

    const double robot_x = wall_from_target_msg.transform.translation.x;
    double x_min = virtual_z_wall_bounds_.min_x;
    double x_max = virtual_z_wall_bounds_.max_x;
    double y_min = virtual_z_wall_bounds_.min_y;
    double y_max = virtual_z_wall_bounds_.max_y;
    if (!virtual_z_walls_use_global_xy_) {
      x_min = std::max(x_min, robot_x - virtual_z_walls_backward_length_);
      x_max = std::min(x_max, robot_x + virtual_z_walls_forward_length_);
    }
    if (x_min > x_max || y_min > y_max) return points;

    const int x_count =
        std::max(1, static_cast<int>(std::floor((x_max - x_min) /
                                               virtual_z_walls_resolution_)) + 1);
    const int y_count =
        std::max(1, static_cast<int>(std::floor((y_max - y_min) /
                                               virtual_z_walls_resolution_)) + 1);

    auto add_plane = [&](double z) {
      for (int ix = 0; ix < x_count; ++ix) {
        const double x =
            (x_count == 1) ? x_min : std::min(x_min + ix * virtual_z_walls_resolution_, x_max);
        for (int iy = 0; iy < y_count; ++iy) {
          const double y =
              (y_count == 1) ? y_min : std::min(y_min + iy * virtual_z_walls_resolution_, y_max);
          const tf2::Vector3 point_target =
              target_from_wall * tf2::Vector3(x, y, z);
          points.push_back({static_cast<float>(point_target.x()),
                            static_cast<float>(point_target.y()),
                            static_cast<float>(point_target.z())});
        }
      }
    };

    if (virtual_z_walls_add_min_z_) add_plane(virtual_z_wall_bounds_.min_z);
    if (virtual_z_walls_add_max_z_) add_plane(virtual_z_wall_bounds_.max_z);
    return points;
  }

  bool appendVirtualZWalls(sensor_msgs::PointCloud2& cloud, const ros::Time& stamp) {
    const std::vector<std::array<float, 3>> wall_points =
        buildVirtualZWallPoints(stamp);
    if (wall_points.empty()) return false;

    if (cloud.is_bigendian) {
      ROS_WARN_THROTTLE(
          5.0,
          "[pc_real_converter] virtual z walls skipped for big-endian PointCloud2.");
      return false;
    }

    int x_offset = -1;
    int y_offset = -1;
    int z_offset = -1;
    for (const sensor_msgs::PointField& field : cloud.fields) {
      if (field.datatype != sensor_msgs::PointField::FLOAT32 || field.count < 1) {
        continue;
      }
      if (field.name == "x") x_offset = static_cast<int>(field.offset);
      if (field.name == "y") y_offset = static_cast<int>(field.offset);
      if (field.name == "z") z_offset = static_cast<int>(field.offset);
    }
    if (x_offset < 0 || y_offset < 0 || z_offset < 0 || cloud.point_step == 0) {
      ROS_WARN_THROTTLE(
          5.0,
          "[pc_real_converter] virtual z walls skipped: PointCloud2 has no float32 x/y/z.");
      return false;
    }

    const uint32_t original_width = cloud.width;
    const uint32_t original_height = cloud.height;
    const size_t original_points =
        static_cast<size_t>(original_width) * static_cast<size_t>(original_height);
    const size_t total_points = original_points + wall_points.size();

    std::vector<uint8_t> data(total_points * cloud.point_step, 0);
    for (uint32_t row = 0; row < original_height; ++row) {
      for (uint32_t col = 0; col < original_width; ++col) {
        const size_t src_offset =
            static_cast<size_t>(row) * cloud.row_step +
            static_cast<size_t>(col) * cloud.point_step;
        const size_t dst_index =
            static_cast<size_t>(row) * original_width + static_cast<size_t>(col);
        const size_t dst_offset = dst_index * cloud.point_step;
        if (src_offset + cloud.point_step <= cloud.data.size()) {
          std::memcpy(data.data() + dst_offset, cloud.data.data() + src_offset,
                      cloud.point_step);
        }
      }
    }

    for (size_t i = 0; i < wall_points.size(); ++i) {
      const size_t point_offset = (original_points + i) * cloud.point_step;
      const float x = wall_points[i][0];
      const float y = wall_points[i][1];
      const float z = wall_points[i][2];
      std::memcpy(data.data() + point_offset + x_offset, &x, sizeof(float));
      std::memcpy(data.data() + point_offset + y_offset, &y, sizeof(float));
      std::memcpy(data.data() + point_offset + z_offset, &z, sizeof(float));
    }

    cloud.height = 1;
    cloud.width = static_cast<uint32_t>(total_points);
    cloud.row_step = cloud.point_step * cloud.width;
    cloud.data.swap(data);
    cloud.is_dense = false;

    ROS_INFO_THROTTLE(5.0,
                      "[pc_real_converter] appended virtual z wall points=%zu total=%zu",
                      wall_points.size(), total_points);
    return true;
  }

  ros::Subscriber pc_sub_;
  ros::Publisher pc_pub_;
  tf2_ros::Buffer tf_buffer_;
  tf2_ros::TransformListener tf_listener_;
  std::string target_frame_;
  bool simple_mode_ = false;
  bool fallback_to_frame_id_change_ = false;
  bool use_latest_transform_fallback_ = true;
  bool virtual_z_walls_enable_ = false;
  bool virtual_z_walls_use_global_xy_ = false;
  bool virtual_z_walls_add_min_z_ = true;
  bool virtual_z_walls_add_max_z_ = true;
  std::string virtual_z_walls_bounds_param_ns_;
  std::string virtual_z_walls_frame_;
  double transform_timeout_ = 0.1;
  double latest_transform_max_age_sec_ = 0.05;
  double virtual_z_walls_resolution_ = 0.2;
  double virtual_z_walls_forward_length_ = 8.0;
  double virtual_z_walls_backward_length_ = 2.0;
  Bounds virtual_z_wall_bounds_;
  bool virtual_z_wall_bounds_loaded_ = false;
  ros::Time last_bounds_load_time_;
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
