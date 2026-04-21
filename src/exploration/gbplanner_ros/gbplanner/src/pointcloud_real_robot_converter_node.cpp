#include <ros/ros.h>
#include <sensor_msgs/PointCloud2.h>
#include <tf2_ros/transform_listener.h>
#include <tf2_ros/buffer.h>
#include <tf2_sensor_msgs/tf2_sensor_msgs.h>
#include <geometry_msgs/TransformStamped.h>

/**
 * @brief 实机点云转换节点
 *
 * 功能：
 * 1. 订阅实机点云话题 /cloud_registered (frame_id: camera_init)
 * 2. 支持两种转换模式：
 *    - simple_mode=true: 仅修改 frame_id（假设点云数据已在目标坐标系）
 *    - simple_mode=false: 使用 TF 进行实际的坐标变换
 * 3. 发布转换后的点云供 gbplanner 使用
 */
class PointCloudRealRobotConverter {
public:
    PointCloudRealRobotConverter() : tf_listener_(tf_buffer_) {
        ros::NodeHandle nh;
        ros::NodeHandle pnh("~");

        // 获取参数
        std::string input_topic = "/cloud_registered";
        std::string output_topic = "/cloud_registered_fixed";
        std::string target_frame = "rmf_obelix/rmf_obelix/velodyne";
        bool simple_mode = false;
        double transform_timeout = 0.1;

        pnh.param("input_topic", input_topic, input_topic);
        pnh.param("output_topic", output_topic, output_topic);
        pnh.param("target_frame", target_frame_, target_frame);
        pnh.param("simple_mode", simple_mode_, simple_mode);
        pnh.param("transform_timeout", transform_timeout_, transform_timeout);

        // 订阅和发布
        pc_sub_ = nh.subscribe(input_topic, 10,
                              &PointCloudRealRobotConverter::pointcloudCallback, this);
        pc_pub_ = nh.advertise<sensor_msgs::PointCloud2>(output_topic, 10);

        ROS_INFO("=================================================");
        ROS_INFO("PointCloudRealRobotConverter Initialized:");
        ROS_INFO("  Input topic:        %s", input_topic.c_str());
        ROS_INFO("  Output topic:       %s", output_topic.c_str());
        ROS_INFO("  Target frame:       %s", target_frame_.c_str());
        ROS_INFO("  Simple mode:        %s", simple_mode_ ? "true (frame_id only)" : "false (TF transform)");
        ROS_INFO("  Transform timeout:  %.3f seconds", transform_timeout_);
        ROS_INFO("=================================================");
    }

    void pointcloudCallback(const sensor_msgs::PointCloud2::ConstPtr& msg) {
        try {
            sensor_msgs::PointCloud2 output_cloud;

            if (simple_mode_) {
                // 简单模式：仅修改 frame_id
                output_cloud = *msg;
                output_cloud.header.frame_id = target_frame_;

                if (debug_counter_++ % 50 == 0) {  // 每50帧打印一次
                    ROS_DEBUG("Simple mode: Changed frame_id from '%s' to '%s'",
                             msg->header.frame_id.c_str(), target_frame_.c_str());
                }
            } else {
                // TF 变换模式：实际转换点云坐标
                geometry_msgs::TransformStamped transform;

                try {
                    // 等待并获取 TF 变换
                    transform = tf_buffer_.lookupTransform(
                        target_frame_,
                        msg->header.frame_id,
                        msg->header.stamp,
                        ros::Duration(transform_timeout_)
                    );

                    // 使用 TF2 转换点云
                    tf2::doTransform(*msg, output_cloud, transform);

                    if (debug_counter_++ % 50 == 0) {  // 每50帧打印一次
                        ROS_DEBUG("TF transform: %s -> %s (translation: [%.2f, %.2f, %.2f])",
                                 msg->header.frame_id.c_str(),
                                 target_frame_.c_str(),
                                 transform.transform.translation.x,
                                 transform.transform.translation.y,
                                 transform.transform.translation.z);
                    }

                    transform_success_count_++;
                } catch (tf2::TransformException& ex) {
                    ROS_WARN_THROTTLE(5.0, "TF transform failed: %s. "
                                     "Falling back to simple frame_id change.", ex.what());

                    // TF 变换失败，回退到简单模式
                    output_cloud = *msg;
                    output_cloud.header.frame_id = target_frame_;

                    transform_failure_count_++;
                }
            }

            // 发布转换后的点云
            pc_pub_.publish(output_cloud);
            total_published_count_++;

            // 定期打印统计信息
            if (total_published_count_ % 100 == 0) {
                ROS_INFO("Statistics: Published %lu clouds, TF success: %lu, TF failures: %lu",
                         total_published_count_, transform_success_count_, transform_failure_count_);
            }

        } catch (const std::exception& e) {
            ROS_ERROR("Exception in pointcloud callback: %s", e.what());
        }
    }

private:
    ros::Subscriber pc_sub_;
    ros::Publisher pc_pub_;

    // TF2 相关
    tf2_ros::Buffer tf_buffer_;
    tf2_ros::TransformListener tf_listener_;

    // 参数
    std::string target_frame_;
    bool simple_mode_;
    double transform_timeout_;

    // 统计信息
    size_t debug_counter_ = 0;
    size_t total_published_count_ = 0;
    size_t transform_success_count_ = 0;
    size_t transform_failure_count_ = 0;
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "pointcloud_real_robot_converter_node");

    ROS_INFO("Starting PointCloud Real Robot Converter Node...");

    try {
        PointCloudRealRobotConverter converter;
        ros::spin();
    } catch (const std::exception& e) {
        ROS_ERROR("Fatal error in pointcloud converter node: %s", e.what());
        return 1;
    }

    return 0;
}


// #include <ros/ros.h>
// #include <sensor_msgs/PointCloud2.h>
// #include <tf2_ros/transform_listener.h>
// #include <tf2_ros/buffer.h>
// #include <tf2_sensor_msgs/tf2_sensor_msgs.h>
// #include <geometry_msgs/TransformStamped.h>
// #include <cmath>

// /**
//  * @brief 实机点云转换节点
//  *
//  * 功能：
//  * 1. 订阅实机点云话题 /cloud_registered (frame_id: camera_init)
//  * 2. 支持两种转换模式：
//  *    - simple_mode=true: 仅修改 frame_id（假设点云数据已在目标坐标系）
//  *    - simple_mode=false: 使用 TF 进行实际的坐标变换
//  * 3. 发布转换后的点云供 gbplanner 使用
//  *
//  * 说明：
//  *  - 默认在 TF 失败时丢帧，不再回退到“仅改 frame_id”。
//  *  - 可通过参数 fallback_to_frame_id_change=true 恢复旧行为（不推荐）。
//  */
// class PointCloudRealRobotConverter {
// public:
//     PointCloudRealRobotConverter() : tf_listener_(tf_buffer_) {
//         ros::NodeHandle nh;
//         ros::NodeHandle pnh("~");

//         // 获取参数
//         std::string input_topic = "/cloud_registered";
//         std::string output_topic = "/cloud_registered_fixed";
//         std::string target_frame = "rmf_obelix/rmf_obelix/velodyne";
//         bool simple_mode = false;
//         double transform_timeout = 0.1;
//         bool fallback_to_frame_id_change = false;
//         bool use_latest_transform_fallback = true;
//         double latest_transform_max_age_sec = 0.05;

//         pnh.param("input_topic", input_topic, input_topic);
//         pnh.param("output_topic", output_topic, output_topic);
//         pnh.param("target_frame", target_frame_, target_frame);
//         pnh.param("simple_mode", simple_mode_, simple_mode);
//         pnh.param("transform_timeout", transform_timeout_, transform_timeout);
//         pnh.param("fallback_to_frame_id_change", fallback_to_frame_id_change_,
//                   fallback_to_frame_id_change);
//         pnh.param("use_latest_transform_fallback", use_latest_transform_fallback_,
//                   use_latest_transform_fallback);
//         pnh.param("latest_transform_max_age_sec", latest_transform_max_age_sec_,
//                   latest_transform_max_age_sec);

//         // 订阅和发布
//         pc_sub_ = nh.subscribe(input_topic, 10,
//                               &PointCloudRealRobotConverter::pointcloudCallback, this);
//         pc_pub_ = nh.advertise<sensor_msgs::PointCloud2>(output_topic, 10);

//         ROS_INFO("=================================================");
//         ROS_INFO("PointCloudRealRobotConverter Initialized:");
//         ROS_INFO("  Input topic:        %s", input_topic.c_str());
//         ROS_INFO("  Output topic:       %s", output_topic.c_str());
//         ROS_INFO("  Target frame:       %s", target_frame_.c_str());
//         ROS_INFO("  Simple mode:        %s", simple_mode_ ? "true (frame_id only)" : "false (TF transform)");
//         ROS_INFO("  Transform timeout:  %.3f seconds", transform_timeout_);
//         ROS_INFO("  TF failure policy:  %s",
//                  fallback_to_frame_id_change_
//                      ? "fallback to frame_id change (legacy, risky)"
//                      : "drop frame (recommended)");
//         ROS_INFO("  Latest TF fallback: %s (max age %.3f s)",
//                  use_latest_transform_fallback_ ? "enabled" : "disabled",
//                  latest_transform_max_age_sec_);
//         ROS_INFO("=================================================");
//     }

//     void pointcloudCallback(const sensor_msgs::PointCloud2::ConstPtr& msg) {
//         try {
//             sensor_msgs::PointCloud2 output_cloud;

//             if (simple_mode_) {
//                 // 简单模式：仅修改 frame_id
//                 output_cloud = *msg;
//                 output_cloud.header.frame_id = target_frame_;

//                 if (debug_counter_++ % 500 == 0) {  // 每50帧打印一次
//                     ROS_DEBUG("Simple mode: Changed frame_id from '%s' to '%s'",
//                              msg->header.frame_id.c_str(), target_frame_.c_str());
//                 }
//             } else {
//                 // TF 变换模式：实际转换点云坐标
//                 geometry_msgs::TransformStamped transform;
//                 bool transformed = false;

//                 try {
//                     // 等待并获取 TF 变换
//                     transform = tf_buffer_.lookupTransform(
//                         target_frame_,
//                         msg->header.frame_id,
//                         msg->header.stamp,
//                         ros::Duration(transform_timeout_)
//                     );

//                     // 使用 TF2 转换点云
//                     tf2::doTransform(*msg, output_cloud, transform);
//                     transformed = true;

//                     if (debug_counter_++ % 500 == 0) {  // 每50帧打印一次
//                         ROS_DEBUG("TF transform: %s -> %s (translation: [%.2f, %.2f, %.2f])",
//                                  msg->header.frame_id.c_str(),
//                                  target_frame_.c_str(),
//                                  transform.transform.translation.x,
//                                  transform.transform.translation.y,
//                                  transform.transform.translation.z);
//                     }

//                     transform_success_count_++;
//                 } catch (tf2::TransformException& ex) {
//                     transform_failure_count_++;
//                     ROS_WARN_THROTTLE(5.0, "TF transform failed at msg stamp: %s", ex.what());

//                     // 可选：回退到“最新 TF”进行转换（仅允许很小时间偏差）
//                     if (use_latest_transform_fallback_) {
//                         try {
//                             geometry_msgs::TransformStamped latest_transform =
//                                 tf_buffer_.lookupTransform(target_frame_, msg->header.frame_id,
//                                                            ros::Time(0), ros::Duration(transform_timeout_));
//                             const double age_sec = std::fabs((latest_transform.header.stamp -
//                                                               msg->header.stamp).toSec());
//                             if (age_sec <= latest_transform_max_age_sec_) {
//                                 tf2::doTransform(*msg, output_cloud, latest_transform);
//                                 transformed = true;
//                                 latest_transform_fallback_success_count_++;
//                                 ROS_WARN_THROTTLE(
//                                     5.0,
//                                     "Using latest TF fallback for cloud transform (age=%.6f s).",
//                                     age_sec);
//                             } else {
//                                 ROS_WARN_THROTTLE(
//                                     5.0,
//                                     "Latest TF fallback too old (age=%.6f s > %.6f s). Dropping cloud.",
//                                     age_sec, latest_transform_max_age_sec_);
//                             }
//                         } catch (tf2::TransformException& ex_latest) {
//                             ROS_WARN_THROTTLE(5.0, "Latest TF fallback failed: %s", ex_latest.what());
//                         }
//                     }

//                     if (!transformed) {
//                         if (fallback_to_frame_id_change_) {
//                             // 兼容旧行为（不推荐）
//                             output_cloud = *msg;
//                             output_cloud.header.frame_id = target_frame_;
//                             fallback_frame_id_change_count_++;
//                             ROS_WARN_THROTTLE(
//                                 5.0,
//                                 "Falling back to frame_id rewrite without coordinate transform (legacy behavior).");
//                         } else {
//                             dropped_cloud_count_++;
//                             return;
//                         }
//                     }
//                 }
//             }

//             // 发布转换后的点云
//             pc_pub_.publish(output_cloud);
//             total_published_count_++;

//             // 定期打印统计信息
//             if (total_published_count_ % 1000 == 0) {
//                 ROS_INFO("Statistics: Published=%lu, TF success=%lu, TF failures=%lu, "
//                          "Latest TF fallback=%lu, FrameId fallback=%lu, Dropped=%lu",
//                          total_published_count_, transform_success_count_, transform_failure_count_,
//                          latest_transform_fallback_success_count_, fallback_frame_id_change_count_,
//                          dropped_cloud_count_);
//             }

//         } catch (const std::exception& e) {
//             ROS_ERROR("Exception in pointcloud callback: %s", e.what());
//         }
//     }

// private:
//     ros::Subscriber pc_sub_;
//     ros::Publisher pc_pub_;

//     // TF2 相关
//     tf2_ros::Buffer tf_buffer_;
//     tf2_ros::TransformListener tf_listener_;

//     // 参数
//     std::string target_frame_;
//     bool simple_mode_;
//     double transform_timeout_;
//     bool fallback_to_frame_id_change_;
//     bool use_latest_transform_fallback_;
//     double latest_transform_max_age_sec_;

//     // 统计信息
//     size_t debug_counter_ = 0;
//     size_t total_published_count_ = 0;
//     size_t transform_success_count_ = 0;
//     size_t transform_failure_count_ = 0;
//     size_t latest_transform_fallback_success_count_ = 0;
//     size_t fallback_frame_id_change_count_ = 0;
//     size_t dropped_cloud_count_ = 0;
// };

// int main(int argc, char** argv) {
//     ros::init(argc, argv, "pointcloud_real_robot_converter_node");

//     ROS_INFO("Starting PointCloud Real Robot Converter Node...");

//     try {
//         PointCloudRealRobotConverter converter;
//         ros::spin();
//     } catch (const std::exception& e) {
//         ROS_ERROR("Fatal error in pointcloud converter node: %s", e.what());
//         return 1;
//     }

//     return 0;
// }
