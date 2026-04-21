#include <ros/ros.h>
#include <sensor_msgs/PointCloud2.h>

class PointCloudFrameFixer {
public:
    PointCloudFrameFixer() {
        ros::NodeHandle nh;
        ros::NodeHandle pnh("~");
        
        // 获取参数
        std::string input_topic = "/livox/lidar";
        std::string output_topic = "/livox/lidar_fixed";
        std::string target_frame = "rmf_obelix/rmf_obelix/velodyne";  // 传感器坐标系
        
        pnh.param("input_topic", input_topic, input_topic);
        pnh.param("output_topic", output_topic, output_topic);
        pnh.param("target_frame", target_frame_, target_frame);
        
        // 订阅和发布
        pc_sub_ = nh.subscribe(input_topic, 10, &PointCloudFrameFixer::pointcloudCallback, this);
        pc_pub_ = nh.advertise<sensor_msgs::PointCloud2>(output_topic, 10);
        
        ROS_INFO("PointCloudFrameFixer: Subscribing to %s", input_topic.c_str());
        ROS_INFO("PointCloudFrameFixer: Publishing to %s with frame_id %s", 
                 output_topic.c_str(), target_frame_.c_str());
    }
    
    void pointcloudCallback(const sensor_msgs::PointCloud2::ConstPtr& msg) {
        sensor_msgs::PointCloud2 fixed_msg = *msg;
        
        // 修改 frame_id 为传感器坐标系
        fixed_msg.header.frame_id = target_frame_;
        
        // 保持时间戳不变
        fixed_msg.header.stamp = msg->header.stamp;
        
        // 发布修正后的点云
        pc_pub_.publish(fixed_msg);
    }
    
private:
    ros::Subscriber pc_sub_;
    ros::Publisher pc_pub_;
    std::string target_frame_ = "rmf_obelix/rmf_obelix/velodyne";
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "pointcloud_frame_fixer_node");
    
    PointCloudFrameFixer fixer;
    
    ros::spin();
    
    return 0;
}

