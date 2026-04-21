# Install script for directory: /home/super/uestc-gbplanner/src/exploration/gbplanner_ros/gbplanner

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/super/uestc-gbplanner/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/super/uestc-gbplanner/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/super/uestc-gbplanner/install" TYPE PROGRAM FILES "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/_setup_util.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/super/uestc-gbplanner/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/super/uestc-gbplanner/install" TYPE PROGRAM FILES "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/env.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/super/uestc-gbplanner/install/setup.bash;/home/super/uestc-gbplanner/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/super/uestc-gbplanner/install" TYPE FILE FILES
    "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/setup.bash"
    "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/local_setup.bash"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/super/uestc-gbplanner/install/setup.sh;/home/super/uestc-gbplanner/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/super/uestc-gbplanner/install" TYPE FILE FILES
    "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/setup.sh"
    "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/local_setup.sh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/super/uestc-gbplanner/install/setup.zsh;/home/super/uestc-gbplanner/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/super/uestc-gbplanner/install" TYPE FILE FILES
    "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/setup.zsh"
    "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/super/uestc-gbplanner/install/setup.fish;/home/super/uestc-gbplanner/install/local_setup.fish")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/super/uestc-gbplanner/install" TYPE FILE FILES
    "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/setup.fish"
    "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/local_setup.fish"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/super/uestc-gbplanner/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/super/uestc-gbplanner/install" TYPE FILE FILES "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/.rosinstall")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgbplanner.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgbplanner.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgbplanner.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/super/uestc-gbplanner/devel/.private/gbplanner/lib/libgbplanner.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgbplanner.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgbplanner.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgbplanner.so"
         OLD_RPATH "/home/super/uestc-gbplanner/devel/.private/adaptive_obb/lib:/home/super/uestc-gbplanner/devel/.private/planner_common/lib:/home/super/uestc-gbplanner/devel/.private/kdtree/lib:/home/super/uestc-gbplanner/devel/.private/voxblox_ros/lib:/opt/ros/noetic/lib:/home/super/uestc-gbplanner/devel/.private/voxblox_rviz_plugin/lib:/home/super/uestc-gbplanner/devel/.private/voxblox/lib:/home/super/uestc-gbplanner/devel/.private/eigen_checks/lib:/home/super/uestc-gbplanner/devel/.private/glog_catkin/lib:/home/super/uestc-gbplanner/devel/.private/gflags_catkin/lib:/home/super/uestc-gbplanner/devel/.private/quadrotor_msgs/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libgbplanner.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/gbplanner_node" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/gbplanner_node")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/gbplanner_node"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/gbplanner" TYPE EXECUTABLE FILES "/home/super/uestc-gbplanner/devel/.private/gbplanner/lib/gbplanner/gbplanner_node")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/gbplanner_node" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/gbplanner_node")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/gbplanner_node"
         OLD_RPATH "/home/super/uestc-gbplanner/devel/.private/adaptive_obb/lib:/home/super/uestc-gbplanner/devel/.private/planner_common/lib:/home/super/uestc-gbplanner/devel/.private/kdtree/lib:/home/super/uestc-gbplanner/devel/.private/voxblox_ros/lib:/opt/ros/noetic/lib:/home/super/uestc-gbplanner/devel/.private/voxblox_rviz_plugin/lib:/home/super/uestc-gbplanner/devel/.private/voxblox/lib:/home/super/uestc-gbplanner/devel/.private/eigen_checks/lib:/home/super/uestc-gbplanner/devel/.private/glog_catkin/lib:/home/super/uestc-gbplanner/devel/.private/gflags_catkin/lib:/home/super/uestc-gbplanner/devel/.private/quadrotor_msgs/lib:/home/super/uestc-gbplanner/devel/.private/gbplanner/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/gbplanner_node")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/odom_to_tf_node" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/odom_to_tf_node")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/odom_to_tf_node"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/gbplanner" TYPE EXECUTABLE FILES "/home/super/uestc-gbplanner/devel/.private/gbplanner/lib/gbplanner/odom_to_tf_node")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/odom_to_tf_node" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/odom_to_tf_node")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/odom_to_tf_node"
         OLD_RPATH "/home/super/uestc-gbplanner/devel/.private/adaptive_obb/lib:/home/super/uestc-gbplanner/devel/.private/planner_common/lib:/home/super/uestc-gbplanner/devel/.private/kdtree/lib:/home/super/uestc-gbplanner/devel/.private/voxblox_ros/lib:/opt/ros/noetic/lib:/home/super/uestc-gbplanner/devel/.private/voxblox_rviz_plugin/lib:/home/super/uestc-gbplanner/devel/.private/voxblox/lib:/home/super/uestc-gbplanner/devel/.private/eigen_checks/lib:/home/super/uestc-gbplanner/devel/.private/glog_catkin/lib:/home/super/uestc-gbplanner/devel/.private/gflags_catkin/lib:/home/super/uestc-gbplanner/devel/.private/quadrotor_msgs/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/odom_to_tf_node")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_frame_fixer_node" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_frame_fixer_node")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_frame_fixer_node"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/gbplanner" TYPE EXECUTABLE FILES "/home/super/uestc-gbplanner/devel/.private/gbplanner/lib/gbplanner/pointcloud_frame_fixer_node")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_frame_fixer_node" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_frame_fixer_node")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_frame_fixer_node"
         OLD_RPATH "/home/super/uestc-gbplanner/devel/.private/adaptive_obb/lib:/home/super/uestc-gbplanner/devel/.private/planner_common/lib:/home/super/uestc-gbplanner/devel/.private/kdtree/lib:/home/super/uestc-gbplanner/devel/.private/voxblox_ros/lib:/opt/ros/noetic/lib:/home/super/uestc-gbplanner/devel/.private/voxblox_rviz_plugin/lib:/home/super/uestc-gbplanner/devel/.private/voxblox/lib:/home/super/uestc-gbplanner/devel/.private/eigen_checks/lib:/home/super/uestc-gbplanner/devel/.private/glog_catkin/lib:/home/super/uestc-gbplanner/devel/.private/gflags_catkin/lib:/home/super/uestc-gbplanner/devel/.private/quadrotor_msgs/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_frame_fixer_node")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_real_robot_converter_node" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_real_robot_converter_node")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_real_robot_converter_node"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/gbplanner" TYPE EXECUTABLE FILES "/home/super/uestc-gbplanner/devel/.private/gbplanner/lib/gbplanner/pointcloud_real_robot_converter_node")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_real_robot_converter_node" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_real_robot_converter_node")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_real_robot_converter_node"
         OLD_RPATH "/home/super/uestc-gbplanner/devel/.private/adaptive_obb/lib:/home/super/uestc-gbplanner/devel/.private/planner_common/lib:/home/super/uestc-gbplanner/devel/.private/kdtree/lib:/home/super/uestc-gbplanner/devel/.private/voxblox_ros/lib:/opt/ros/noetic/lib:/home/super/uestc-gbplanner/devel/.private/voxblox_rviz_plugin/lib:/home/super/uestc-gbplanner/devel/.private/voxblox/lib:/home/super/uestc-gbplanner/devel/.private/eigen_checks/lib:/home/super/uestc-gbplanner/devel/.private/glog_catkin/lib:/home/super/uestc-gbplanner/devel/.private/gflags_catkin/lib:/home/super/uestc-gbplanner/devel/.private/quadrotor_msgs/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/pointcloud_real_robot_converter_node")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/traj_server_node" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/traj_server_node")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/traj_server_node"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/gbplanner" TYPE EXECUTABLE FILES "/home/super/uestc-gbplanner/devel/.private/gbplanner/lib/gbplanner/traj_server_node")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/traj_server_node" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/traj_server_node")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/traj_server_node"
         OLD_RPATH "/home/super/uestc-gbplanner/devel/.private/adaptive_obb/lib:/home/super/uestc-gbplanner/devel/.private/planner_common/lib:/home/super/uestc-gbplanner/devel/.private/kdtree/lib:/home/super/uestc-gbplanner/devel/.private/voxblox_ros/lib:/opt/ros/noetic/lib:/home/super/uestc-gbplanner/devel/.private/voxblox_rviz_plugin/lib:/home/super/uestc-gbplanner/devel/.private/voxblox/lib:/home/super/uestc-gbplanner/devel/.private/eigen_checks/lib:/home/super/uestc-gbplanner/devel/.private/glog_catkin/lib:/home/super/uestc-gbplanner/devel/.private/gflags_catkin/lib:/home/super/uestc-gbplanner/devel/.private/quadrotor_msgs/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/gbplanner/traj_server_node")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/gbplanner/include/" FILES_MATCHING REGEX "/[^/]*\\.h$" REGEX "/[^/]*\\.hpp$" REGEX "/\\.svn$" EXCLUDE)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gbplanner/launch" TYPE DIRECTORY FILES "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/gbplanner/launch/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/gbplanner.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gbplanner/cmake" TYPE FILE FILES
    "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/gbplannerConfig.cmake"
    "/home/super/uestc-gbplanner/build/gbplanner/catkin_generated/installspace/gbplannerConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gbplanner" TYPE FILE FILES "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/gbplanner/package.xml")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/super/uestc-gbplanner/build/gbplanner/gtest/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/super/uestc-gbplanner/build/gbplanner/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
