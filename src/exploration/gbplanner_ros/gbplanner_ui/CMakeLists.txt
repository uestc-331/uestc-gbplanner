cmake_minimum_required(VERSION 2.8.3)
project(gbplanner_ui)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -std=c++11")

find_package(catkin REQUIRED COMPONENTS
  rviz
  planner_msgs
  roscpp
  std_msgs
  std_srvs)

catkin_package()
include_directories(${catkin_INCLUDE_DIRS})
link_directories(${catkin_LIBRARY_DIRS})

set(CMAKE_AUTOMOC ON)

if(rviz_QT_VERSION VERSION_LESS "5")
  message(STATUS "Using Qt4 based on the rviz_QT_VERSION: ${rviz_QT_VERSION}")
  find_package(Qt4 ${rviz_QT_VERSION} EXACT REQUIRED QtCore QtGui)
  ## pull in all required include dirs, define QT_LIBRARIES, etc.
  include(${QT_USE_FILE})
else()
  message(STATUS "Using Qt5 based on the rviz_QT_VERSION: ${rviz_QT_VERSION}")
  find_package(Qt5 ${rviz_QT_VERSION}  REQUIRED Core Widgets) # removed EXACT version requirement...
  ## make target_link_libraries(${QT_LIBRARIES}) pull in all required dependencies
  set(QT_LIBRARIES Qt5::Widgets)
endif()

add_definitions(-DQT_NO_KEYWORDS)

## Here we specify the list of source files.
## The generated MOC files are included automatically as headers.
set(SRC_FILES
  src/gbplanner_ui.cpp
  src/gbplanner_topic_ui.cpp
)

add_library(${PROJECT_NAME} ${SRC_FILES})

add_executable(gbplanner_topic_command_bridge
  src/gbplanner_topic_command_bridge.cpp)
add_executable(gbplanner_topic_terminal
  src/gbplanner_topic_terminal.cpp)
add_executable(gbplanner_cli
  src/gbplanner_cli.cpp)
add_executable(gbplanner_simple_topic_ui
  src/gbplanner_simple_topic_ui.cpp)

target_link_libraries(${PROJECT_NAME} ${QT_LIBRARIES} ${catkin_LIBRARIES})
target_link_libraries(gbplanner_topic_command_bridge ${catkin_LIBRARIES})
target_link_libraries(gbplanner_topic_terminal ${catkin_LIBRARIES})
target_link_libraries(gbplanner_cli ${catkin_LIBRARIES})
target_link_libraries(gbplanner_simple_topic_ui ${catkin_LIBRARIES})

## Install rules

install(TARGETS
  ${PROJECT_NAME}
  gbplanner_topic_command_bridge
  gbplanner_topic_terminal
  gbplanner_cli
  gbplanner_simple_topic_ui
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(FILES
  plugin_description.xml
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})

install(DIRECTORY icons/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/icons)
