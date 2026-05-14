#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <nav_msgs/Odometry.h>
#include <tf/transform_listener.h>
int main(int argc, char** argv) {
  ros::init(argc, argv, "robot_odometry");
  ros::NodeHandle nh;
  ros::Publisher odom_pub;
  tf::TransformBroadcaster tf_broadcaster;

  odom_pub = nh.advertise<nav_msgs::Odometry>("sim_odom", 10);
tf::TransformListener listener;
  ros::Rate loop_rate(10);  // 10Hz publishing rate


  while (ros::ok()) {
    tf::StampedTransform transform;
    try {
      listener.lookupTransform("world", "base_link", ros::Time(0), transform);
    } catch (tf::TransformException& ex) {
      ROS_ERROR("%s", ex.what());
      ros::Duration(1.0).sleep();
      continue;
    }

    double x = transform.getOrigin().x();
    double y = transform.getOrigin().y();
    double z = transform.getOrigin().z();
    
    

    ROS_INFO("Robot position: x=%f, y=%f, z=%f", x, y, z);


    // Publish the odometry message
    nav_msgs::Odometry odom;
    odom.header.stamp = ros::Time::now();
    odom.header.frame_id = "odom";
    odom.child_frame_id = "base_link";
    odom.pose.pose.position.x = transform.getOrigin().x();
    odom.pose.pose.position.y = transform.getOrigin().y();
    odom.pose.pose.position.z = transform.getOrigin().z();
    odom.pose.pose.orientation.x = transform.getRotation().x();
    odom.pose.pose.orientation.y = transform.getRotation().y();
    odom.pose.pose.orientation.z = transform.getRotation().z();
    odom.pose.pose.orientation.w = transform.getRotation().w();
    
    
    odom_pub.publish(odom);

    ros::spinOnce();
    loop_rate.sleep();
  }

  return 0;
}
