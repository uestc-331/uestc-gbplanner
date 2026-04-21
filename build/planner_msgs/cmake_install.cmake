# Install script for directory: /home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs

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
file(INSTALL DESTINATION "/home/super/uestc-gbplanner/install" TYPE PROGRAM FILES "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/_setup_util.py")
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
file(INSTALL DESTINATION "/home/super/uestc-gbplanner/install" TYPE PROGRAM FILES "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/env.sh")
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
    "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/setup.bash"
    "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/local_setup.bash"
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
    "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/setup.sh"
    "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/local_setup.sh"
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
    "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/setup.zsh"
    "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/local_setup.zsh"
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
    "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/setup.fish"
    "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/local_setup.fish"
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
file(INSTALL DESTINATION "/home/super/uestc-gbplanner/install" TYPE FILE FILES "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/.rosinstall")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/planner_msgs/srv" TYPE FILE FILES
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_srv.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_global.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_search.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_homing.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_set_homing_pos.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_geofence.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_request_path.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/pci_trigger.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/pci_homing_trigger.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/pci_set_homing_pos.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/pci_initialization.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/pci_search.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/pci_global.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/pci_stop.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/pci_geofence.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/pci_to_waypoint.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_set_global_bound.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_set_vel.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_set_exp_mode.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_string_trigger.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_set_search_mode.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_go_to_waypoint.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_dynamic_global_bound.srv"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/srv/planner_set_planning_mode.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/planner_msgs/msg" TYPE FILE FILES
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/RobotStatus.msg"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/RectangleShape.msg"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/BoundMode.msg"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/PlanningMode.msg"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/ExecutionPathMode.msg"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/TriggerMode.msg"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/PlannerStatus.msg"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/PlanningBound.msg"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/Vertex.msg"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/Edge.msg"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/Graph.msg"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/CoveragePlannerLogger.msg"
    "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/msg/BehaviourPlannerLogger.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/planner_msgs/action" TYPE FILE FILES "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/action/pathFollowerAction.action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/planner_msgs/msg" TYPE FILE FILES
    "/home/super/uestc-gbplanner/devel/.private/planner_msgs/share/planner_msgs/msg/pathFollowerActionAction.msg"
    "/home/super/uestc-gbplanner/devel/.private/planner_msgs/share/planner_msgs/msg/pathFollowerActionActionGoal.msg"
    "/home/super/uestc-gbplanner/devel/.private/planner_msgs/share/planner_msgs/msg/pathFollowerActionActionResult.msg"
    "/home/super/uestc-gbplanner/devel/.private/planner_msgs/share/planner_msgs/msg/pathFollowerActionActionFeedback.msg"
    "/home/super/uestc-gbplanner/devel/.private/planner_msgs/share/planner_msgs/msg/pathFollowerActionGoal.msg"
    "/home/super/uestc-gbplanner/devel/.private/planner_msgs/share/planner_msgs/msg/pathFollowerActionResult.msg"
    "/home/super/uestc-gbplanner/devel/.private/planner_msgs/share/planner_msgs/msg/pathFollowerActionFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/planner_msgs/cmake" TYPE FILE FILES "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/planner_msgs-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/super/uestc-gbplanner/devel/.private/planner_msgs/include/planner_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/super/uestc-gbplanner/devel/.private/planner_msgs/share/roseus/ros/planner_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/super/uestc-gbplanner/devel/.private/planner_msgs/share/common-lisp/ros/planner_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/super/uestc-gbplanner/devel/.private/planner_msgs/share/gennodejs/ros/planner_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/super/uestc-gbplanner/devel/.private/planner_msgs/lib/python3/dist-packages/planner_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/super/uestc-gbplanner/devel/.private/planner_msgs/lib/python3/dist-packages/planner_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/planner_msgs.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/planner_msgs/cmake" TYPE FILE FILES "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/planner_msgs-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/planner_msgs/cmake" TYPE FILE FILES
    "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/planner_msgsConfig.cmake"
    "/home/super/uestc-gbplanner/build/planner_msgs/catkin_generated/installspace/planner_msgsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/planner_msgs" TYPE FILE FILES "/home/super/uestc-gbplanner/src/exploration/gbplanner_ros/planner_msgs/package.xml")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/super/uestc-gbplanner/build/planner_msgs/gtest/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/super/uestc-gbplanner/build/planner_msgs/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
