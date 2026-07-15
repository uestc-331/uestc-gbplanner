# Source this file in each terminal before launching the GB3/PX4 stack.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export GB3_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
if [ -z "${PX4_FIRMWARE_ROOT:-}" ]; then
  if [ -d /home/uestc/PX4-Autopilot ]; then
    export PX4_FIRMWARE_ROOT=/home/uestc/PX4-Autopilot
  else
    export PX4_FIRMWARE_ROOT=/home/uestc/PX4_Firmware
  fi
fi
if [ -z "${PX4_BUILD_DIR:-}" ] || [ ! -d "${PX4_BUILD_DIR}" ] || [ "${PX4_BUILD_DIR#${PX4_FIRMWARE_ROOT}/}" = "${PX4_BUILD_DIR}" ]; then
  export PX4_BUILD_DIR="${PX4_FIRMWARE_ROOT}/build/px4_sitl_default"
fi

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

if [ -d "${GB3_ROOT}/devel/lib" ]; then
  case ":${GAZEBO_PLUGIN_PATH:-}:" in
    *":${GB3_ROOT}/devel/lib:"*) ;;
    *) export GAZEBO_PLUGIN_PATH="${GAZEBO_PLUGIN_PATH:-}:${GB3_ROOT}/devel/lib" ;;
  esac
fi

if [ -f /usr/share/GeographicLib/geoids/geoids/egm96-5.pgm ] && [ ! -f /usr/share/GeographicLib/geoids/egm96-5.pgm ]; then
  export GEOGRAPHICLIB_GEOID_PATH=/usr/share/GeographicLib/geoids/geoids
fi

export GAZEBO_MODEL_DATABASE_URI="${GAZEBO_MODEL_DATABASE_URI:-}"

if [ -d "${PX4_FIRMWARE_ROOT}" ]; then
  case ":${ROS_PACKAGE_PATH:-}:" in
    *":${PX4_FIRMWARE_ROOT}:"*) ;;
    *) export ROS_PACKAGE_PATH="${ROS_PACKAGE_PATH:-}:${PX4_FIRMWARE_ROOT}" ;;
  esac

  if [ -d "${PX4_FIRMWARE_ROOT}/Tools/sitl_gazebo" ]; then
    case ":${ROS_PACKAGE_PATH:-}:" in
      *":${PX4_FIRMWARE_ROOT}/Tools/sitl_gazebo:"*) ;;
      *) export ROS_PACKAGE_PATH="${ROS_PACKAGE_PATH:-}:${PX4_FIRMWARE_ROOT}/Tools/sitl_gazebo" ;;
    esac
  fi

  if [ -d "${PX4_FIRMWARE_ROOT}/Tools/simulation/gazebo-classic/sitl_gazebo-classic" ]; then
    case ":${ROS_PACKAGE_PATH:-}:" in
      *":${PX4_FIRMWARE_ROOT}/Tools/simulation/gazebo-classic/sitl_gazebo-classic:"*) ;;
      *) export ROS_PACKAGE_PATH="${ROS_PACKAGE_PATH:-}:${PX4_FIRMWARE_ROOT}/Tools/simulation/gazebo-classic/sitl_gazebo-classic" ;;
    esac
  fi
fi

if [ -f "${PX4_FIRMWARE_ROOT}/Tools/setup_gazebo.bash" ] && [ -d "${PX4_BUILD_DIR}/build_gazebo" ]; then
  source "${PX4_FIRMWARE_ROOT}/Tools/setup_gazebo.bash" "${PX4_FIRMWARE_ROOT}" "${PX4_BUILD_DIR}"
elif [ -f "${PX4_FIRMWARE_ROOT}/Tools/simulation/gazebo-classic/setup_gazebo.bash" ] && [ -d "${PX4_BUILD_DIR}/build_gazebo-classic" ]; then
  source "${PX4_FIRMWARE_ROOT}/Tools/simulation/gazebo-classic/setup_gazebo.bash" "${PX4_FIRMWARE_ROOT}" "${PX4_BUILD_DIR}"
fi

PX4_GAZEBO_CLASSIC_PLUGIN_DIR="${PX4_BUILD_DIR}/build_gazebo-classic"
if [ -d "${PX4_GAZEBO_CLASSIC_PLUGIN_DIR}" ]; then
  case ":${GAZEBO_PLUGIN_PATH:-}:" in
    *":${PX4_GAZEBO_CLASSIC_PLUGIN_DIR}:"*) ;;
    *) export GAZEBO_PLUGIN_PATH="${GAZEBO_PLUGIN_PATH:-}:${PX4_GAZEBO_CLASSIC_PLUGIN_DIR}" ;;
  esac
  case ":${LD_LIBRARY_PATH:-}:" in
    *":${PX4_GAZEBO_CLASSIC_PLUGIN_DIR}:"*) ;;
    *) export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:-}:${PX4_GAZEBO_CLASSIC_PLUGIN_DIR}" ;;
  esac
fi
