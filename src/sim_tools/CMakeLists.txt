cmake_minimum_required(VERSION 3.0.2)
project(sim_tools)
set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -Wall -g") 
## Compile as C++17, supported in modern ROS versions
add_compile_options(-std=c++17)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  nav_msgs
  quadrotor_msgs
  roscpp
  rospy
  sensor_msgs
  std_msgs
  trajectory_msgs
  roslib
  tf
)

find_package(Eigen3 REQUIRED)

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES uav_control
   CATKIN_DEPENDS geometry_msgs nav_msgs quadrotor_msgs roscpp rospy sensor_msgs std_msgs trajectory_msgs
#  DEPENDS system_lib
)

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
  ${catkin_INCLUDE_DIRS}
  ${EIGEN3_INCLUDE_DIR}
  include
) 
add_executable(sim_odom_node src/sim_odom_node.cpp)
target_link_libraries(sim_odom_node ${catkin_LIBRARIES})

add_executable(cmdctl_sim_node src/uav_ctlcmd_node.cpp)
target_link_libraries(cmdctl_sim_node ${catkin_LIBRARIES})

add_executable(traj_server_node src/traj_server_node.cpp)
target_link_libraries(traj_server_node ${catkin_LIBRARIES})

catkin_install_python(PROGRAMS
  scripts/arm.py
  scripts/get_local_pose.py
  scripts/get_iris_odom.py
  scripts/sim_remote.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
