# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include".split(';') if "${prefix}/include" != "" else []
PROJECT_CATKIN_DEPENDS = "message_generation;sensor_msgs;std_msgs;cv_bridge;tf;geometry_msgs;visualization_msgs;nav_msgs;kdtree;voxblox_ros;planner_msgs;planner_semantic_msgs;roscpp_serialization;pcl_conversions;pcl_ros;tf2_ros".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-lplanner_common".split(';') if "-lplanner_common" != "" else []
PROJECT_NAME = "planner_common"
PROJECT_SPACE_DIR = "/home/super/uestc-gbplanner/install"
PROJECT_VERSION = "1.0.0"
