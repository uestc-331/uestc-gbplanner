#include <ros/ros.h>
#include <ros/package.h>
#include <thread>
#include "sensor_process_task.hpp"
#include "search_travel_task.hpp"

int main(int argc, char **argv)
{
    ros::init(argc, argv, "uav_control_node");
    ros::NodeHandle nh("~");

    // sensorProcess drone_sensor(nh);
    // ros::Rate sensor_process_rate(180);
    // std::thread sensor_process_thread([&]()
    //                                   {
    //     while(ros::ok())
    //     {
    //         drone_sensor.processTask();
    //         sensor_process_rate.sleep();
    //     } });

    searchTravel searchTravel(nh);
    ros::Rate search_travel_rate(90);
    std::thread search_travel_thread([&]()
                                     {
        while(ros::ok())
        {
            // geometry_msgs::PoseStamped car_pos = drone_sensor.getTarget();
            // circle_travel.setTarget(drone_sensor.getTarget());
            searchTravel.searchTravelTask();
            search_travel_rate.sleep();
        } });

    ros::spin();
    return 0;
}