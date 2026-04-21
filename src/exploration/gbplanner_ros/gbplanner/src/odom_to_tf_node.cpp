#include <ros/ros.h>
#include <nav_msgs/Odometry.h>
#include <tf/transform_broadcaster.h>

class OdomToTf {
public:
    OdomToTf() {
        ros::NodeHandle nh;
        ros::NodeHandle pnh("~");
        
        // 获取参数
        std::string odom_topic = "/sim_odom";
        // std::string parent_frame = "world";
        std::string parent_frame = "camera_init";
        std::string child_frame = "rmf_obelix/base_link";
        double publish_rate = 100.0;  // 默认100Hz，确保TF发布频率足够高
        
        pnh.param("odom_topic", odom_topic, odom_topic);
        pnh.param("parent_frame", parent_frame, parent_frame);
        pnh.param("child_frame", child_frame_, child_frame);
        pnh.param("publish_rate", publish_rate, publish_rate);
        
        // 订阅里程计话题
        odom_sub_ = nh.subscribe(odom_topic, 10, &OdomToTf::odomCallback, this);
        
        // 创建定时器，定期发布TF（即使没有新的里程计消息）
        tf_timer_ = nh.createTimer(ros::Duration(1.0 / publish_rate), 
                                    &OdomToTf::tfTimerCallback, this);
        
        ROS_INFO("OdomToTf: Subscribing to %s", odom_topic.c_str());
        ROS_INFO("OdomToTf: Publishing TF %s -> %s at %.1f Hz", 
                 parent_frame.c_str(), child_frame_.c_str(), publish_rate);
    }
    
    void odomCallback(const nav_msgs::Odometry::ConstPtr& msg) {
        // 更新最新的里程计数据
        latest_odom_ = *msg;
        latest_odom_stamp_ = msg->header.stamp;
        has_odom_ = true;
        
        // 不在这里发布TF，避免与定时器冲突
        // TF由定时器统一发布，确保时间戳唯一
    }
    
    void publishTf(const ros::Time& stamp) {
        if (!has_odom_) {
            return;
        }
        
        // 创建TF变换
        geometry_msgs::TransformStamped transformStamped;
        
        // 使用传入的时间戳（通常是消息的时间戳）
        transformStamped.header.stamp = stamp;
        transformStamped.header.frame_id = latest_odom_.header.frame_id;  // "world"
        transformStamped.child_frame_id = child_frame_;  // "rmf_obelix/base_link"
        
        // 设置位置和姿态（从最新的里程计消息）
        transformStamped.transform.translation.x = latest_odom_.pose.pose.position.x;
        transformStamped.transform.translation.y = latest_odom_.pose.pose.position.y;
        transformStamped.transform.translation.z = latest_odom_.pose.pose.position.z;
        
        transformStamped.transform.rotation.x = latest_odom_.pose.pose.orientation.x;
        transformStamped.transform.rotation.y = latest_odom_.pose.pose.orientation.y;
        transformStamped.transform.rotation.z = latest_odom_.pose.pose.orientation.z;
        transformStamped.transform.rotation.w = latest_odom_.pose.pose.orientation.w;
        
        // 发布TF
        br_.sendTransform(transformStamped);
    }
    
    void tfTimerCallback(const ros::TimerEvent& event) {
        if (!has_odom_) {
            return;  // 还没有收到里程计消息
        }
        
        // 使用当前时间发布TF，确保时间戳唯一且持续更新
        // 这样可以避免与odomCallback中的发布产生时间戳冲突
        // 同时也能覆盖gazebo发布的TF（通过更高的发布频率）
        publishTf(ros::Time::now());
    }
    
private:
    ros::Subscriber odom_sub_;
    ros::Timer tf_timer_;
    tf::TransformBroadcaster br_;
    std::string child_frame_ = "rmf_obelix/base_link";
    nav_msgs::Odometry latest_odom_;
    ros::Time latest_odom_stamp_;
    bool has_odom_ = false;
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "odom_to_tf_node");
    
    OdomToTf odom_to_tf;
    
    ros::spin();
    
    return 0;
}

// #include <ros/ros.h>
// #include <nav_msgs/Odometry.h>
// #include <tf/transform_broadcaster.h>

// class OdomToTf {
// public:
//     OdomToTf() {
//         ros::NodeHandle nh;
//         ros::NodeHandle pnh("~");

//         // 获取参数
//         std::string odom_topic = "/sim_odom";
//         std::string parent_frame = "camera_init";
//         std::string child_frame = "rmf_obelix/base_link";
//         double publish_rate = 100.0;  // 默认100Hz，确保TF发布频率足够高

//         pnh.param("odom_topic", odom_topic, odom_topic);
//         pnh.param("parent_frame", parent_frame_, parent_frame);
//         pnh.param("child_frame", child_frame_, child_frame);
//         pnh.param("publish_rate", publish_rate, publish_rate);

//         // 订阅里程计话题
//         odom_sub_ = nh.subscribe(odom_topic, 10, &OdomToTf::odomCallback, this);

//         // 创建定时器，定期重发最近一次TF（使用最近里程计时间戳）
//         tf_timer_ = nh.createTimer(ros::Duration(1.0 / publish_rate),
//                                    &OdomToTf::tfTimerCallback, this);

//         ROS_INFO("OdomToTf: Subscribing to %s", odom_topic.c_str());
//         ROS_INFO("OdomToTf: Publishing TF %s -> %s at %.1f Hz",
//                  parent_frame_.c_str(), child_frame_.c_str(), publish_rate);
//     }

//     void odomCallback(const nav_msgs::Odometry::ConstPtr& msg) {
//         // 更新最新的里程计数据
//         latest_odom_ = *msg;
//         latest_odom_stamp_ = msg->header.stamp;
//         has_odom_ = true;

//         // 收到里程计时立即按消息时间戳发布，避免点云按消息时间查TF时外推失败
//         publishTf(msg->header.stamp);
//     }

//     void publishTf(const ros::Time& stamp) {
//         if (!has_odom_) {
//             return;
//         }

//         // 创建TF变换
//         geometry_msgs::TransformStamped transformStamped;

//         // 使用传入的时间戳（优先里程计消息时间）
//         transformStamped.header.stamp = stamp;
//         transformStamped.header.frame_id = parent_frame_;
//         transformStamped.child_frame_id = child_frame_;

//         // 设置位置和姿态（从最新的里程计消息）
//         transformStamped.transform.translation.x = latest_odom_.pose.pose.position.x;
//         transformStamped.transform.translation.y = latest_odom_.pose.pose.position.y;
//         transformStamped.transform.translation.z = latest_odom_.pose.pose.position.z;

//         transformStamped.transform.rotation.x = latest_odom_.pose.pose.orientation.x;
//         transformStamped.transform.rotation.y = latest_odom_.pose.pose.orientation.y;
//         transformStamped.transform.rotation.z = latest_odom_.pose.pose.orientation.z;
//         transformStamped.transform.rotation.w = latest_odom_.pose.pose.orientation.w;

//         // 发布TF
//         br_.sendTransform(transformStamped);
//     }

//     void tfTimerCallback(const ros::TimerEvent& event) {
//         if (!has_odom_) {
//             return;  // 还没有收到里程计消息
//         }

//         // 使用最近里程计时间戳重发，避免发布“当前时间但旧位姿”的不一致TF
//         publishTf(latest_odom_stamp_);
//     }

// private:
//     ros::Subscriber odom_sub_;
//     ros::Timer tf_timer_;
//     tf::TransformBroadcaster br_;
//     std::string parent_frame_ = "camera_init";
//     std::string child_frame_ = "rmf_obelix/base_link";
//     nav_msgs::Odometry latest_odom_;
//     ros::Time latest_odom_stamp_;
//     bool has_odom_ = false;
// };

// int main(int argc, char** argv) {
//     ros::init(argc, argv, "odom_to_tf_node");

//     OdomToTf odom_to_tf;

//     ros::spin();

//     return 0;
// }
