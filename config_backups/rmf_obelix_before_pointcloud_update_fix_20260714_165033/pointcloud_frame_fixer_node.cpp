#include <ros/ros.h>
#include <sensor_msgs/PointCloud2.h>

class PointCloudFrameFixerNode {
 public:
  PointCloudFrameFixerNode() {
    ros::NodeHandle nh;
    ros::NodeHandle pnh("~");

    pnh.param<std::string>("input_topic", input_topic_, "/livox/lidar");
    pnh.param<std::string>("output_topic", output_topic_, "/livox/lidar_fixed");
    pnh.param<std::string>("target_frame", target_frame_, "rmf_obelix/rmf_obelix/velodyne");
    pnh.param("update_stamp_to_now", update_stamp_to_now_, false);
    pnh.param("log_period_sec", log_period_sec_, 5.0);

    sub_ = nh.subscribe(input_topic_, 10,
                        &PointCloudFrameFixerNode::cloudCallback, this);
    pub_ = nh.advertise<sensor_msgs::PointCloud2>(output_topic_, 10);

    ROS_INFO("[pc_frame_fixer] subscribing: %s", input_topic_.c_str());
    ROS_INFO("[pc_frame_fixer] publishing: %s with frame_id=%s",
             output_topic_.c_str(), target_frame_.c_str());
    ROS_INFO("[pc_frame_fixer] update_stamp_to_now=%s",
             update_stamp_to_now_ ? "true" : "false");
  }

 private:
  void cloudCallback(const sensor_msgs::PointCloud2::ConstPtr& msg) {
    sensor_msgs::PointCloud2 out = *msg;
    out.header.frame_id = target_frame_;
    if (update_stamp_to_now_) {
      out.header.stamp = ros::Time::now();
    }
    const ros::Time now = ros::Time::now();
    const double input_age =
        msg->header.stamp.isZero() ? 0.0 : (now - msg->header.stamp).toSec();
    ROS_INFO_THROTTLE(
        log_period_sec_,
        "[pc_frame_fixer] cloud width=%u height=%u frame %s -> %s stamp %.3f -> %.3f input_age %.3fs",
        msg->width, msg->height, msg->header.frame_id.c_str(),
        out.header.frame_id.c_str(), msg->header.stamp.toSec(),
        out.header.stamp.toSec(), input_age);
    pub_.publish(out);
  }

  ros::Subscriber sub_;
  ros::Publisher pub_;
  std::string input_topic_;
  std::string output_topic_;
  std::string target_frame_;
  bool update_stamp_to_now_ = false;
  double log_period_sec_ = 5.0;
};

int main(int argc, char** argv) {
  ros::init(argc, argv, "pointcloud_frame_fixer_node");
  PointCloudFrameFixerNode node;
  ros::spin();
  return 0;
}
