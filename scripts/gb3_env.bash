# Source this file in each terminal before launching the GB3/PX4 stack.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export GB3_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
export PX4_FIRMWARE_ROOT="${PX4_FIRMWARE_ROOT:-/home/uestc/PX4_Firmware}"
export PX4_BUILD_DIR="${PX4_BUILD_DIR:-${PX4_FIRMWARE_ROOT}/build/px4_sitl_default}"

remove_path_prefix() {
  local var_name="$1"
  local prefix="$2"
  local old_value="${!var_name:-}"
  local new_value=""
  local entry

  IFS=':' read -ra entries <<< "${old_value}"
  for entry in "${entries[@]}"; do
    case "${entry}" in
      "${prefix}"|"${prefix}"/*) ;;
      *)
        if [ -z "${new_value}" ]; then
          new_value="${entry}"
        else
          new_value="${new_value}:${entry}"
        fi
        ;;
    esac
  done

  export "${var_name}=${new_value}"
}

remove_old_gb3_paths() {
  local old_root
  for old_root in /home/uestc/csj/uestc-gb3 /home/super/uestc-gbplanner /home/super/uestcgbplanner3; do
    [ "${old_root}" = "${GB3_ROOT}" ] && continue
    remove_path_prefix CMAKE_PREFIX_PATH "${old_root}"
    remove_path_prefix ROS_PACKAGE_PATH "${old_root}"
    remove_path_prefix LD_LIBRARY_PATH "${old_root}"
    remove_path_prefix PYTHONPATH "${old_root}"
    remove_path_prefix PKG_CONFIG_PATH "${old_root}"
    remove_path_prefix ROSLISP_PACKAGE_DIRECTORIES "${old_root}"
    remove_path_prefix PATH "${old_root}"
  done
}

source /opt/ros/noetic/setup.bash

if [ -f "${GB3_ROOT}/devel/setup.bash" ]; then
  source "${GB3_ROOT}/devel/setup.bash"
fi

remove_old_gb3_paths

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
