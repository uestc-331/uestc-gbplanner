172.# Source this file in each terminal before launching the GB3/PX4 stack.

export GB3_ROOT="${GB3_ROOT:-/home/uestc/csj/uestc-gb3}"
export PX4_FIRMWARE_ROOT="${PX4_FIRMWARE_ROOT:-/home/uestc/PX4_Firmware}"
export PX4_BUILD_DIR="${PX4_BUILD_DIR:-${PX4_FIRMWARE_ROOT}/build/px4_sitl_default}"

source /opt/ros/noetic/setup.bash

if [ -f "${GB3_ROOT}/devel/setup.bash" ]; then
  source "${GB3_ROOT}/devel/setup.bash"
fi

if [ -d "${PX4_FIRMWARE_ROOT}" ]; then
  case ":${ROS_PACKAGE_PATH:-}:" in
    *":${PX4_FIRMWARE_ROOT}:"*) ;;
    *) export ROS_PACKAGE_PATH="${ROS_PACKAGE_PATH:-}:${PX4_FIRMWARE_ROOT}" ;;
  esac
  case ":${ROS_PACKAGE_PATH:-}:" in
    *":${PX4_FIRMWARE_ROOT}/Tools/sitl_gazebo:"*) ;;
    *) export ROS_PACKAGE_PATH="${ROS_PACKAGE_PATH:-}:${PX4_FIRMWARE_ROOT}/Tools/sitl_gazebo" ;;
  esac
fi

if [ -f "${PX4_FIRMWARE_ROOT}/Tools/setup_gazebo.bash" ] && [ -d "${PX4_BUILD_DIR}/build_gazebo" ]; then
  source "${PX4_FIRMWARE_ROOT}/Tools/setup_gazebo.bash" "${PX4_FIRMWARE_ROOT}" "${PX4_BUILD_DIR}"
fi
