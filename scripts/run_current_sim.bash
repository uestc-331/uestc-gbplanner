#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
ENV_FILE="${ROOT}/scripts/gb3_env.bash"
if [ -z "${PX4_FIRMWARE_ROOT:-}" ]; then
  if [ -d /home/uestc/PX4-Autopilot ]; then
    PX4_ROOT=/home/uestc/PX4-Autopilot
  else
    PX4_ROOT=/home/uestc/PX4_Firmware
  fi
else
  PX4_ROOT="${PX4_FIRMWARE_ROOT}"
fi

ENV_NAME="floor5"
RVIZ_EN="false"
UI_EN="false"
PRINT_ONLY="false"
CLEANUP_ONLY="false"

usage() {
  cat <<EOF
Usage: bash scripts/run_current_sim.bash [options]

Options:
  --env NAME       Simulation world: floor5, pipe, pipeline_xyq. Default: floor5
  --rviz          Start gbplanner with RViz enabled.
  --ui            Start gbplanner_simple_topic_ui in an extra terminal.
  --print         Print the commands instead of launching terminals.
  --cleanup       Kill common residual ROS/Gazebo/RViz processes and exit.
  -h, --help      Show this help.

Environment:
  PX4_FIRMWARE_ROOT  PX4 firmware root. Auto-detects /home/uestc/PX4-Autopilot, then /home/uestc/PX4_Firmware.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --env)
      ENV_NAME="${2:-}"
      shift 2
      ;;
    --rviz)
      RVIZ_EN="true"
      shift
      ;;
    --ui)
      UI_EN="true"
      shift
      ;;
    --print)
      PRINT_ONLY="true"
      shift
      ;;
    --cleanup)
      CLEANUP_ONLY="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

case "${ENV_NAME}" in
  floor5|pipe|pipeline_xyq) ;;
  *)
    echo "Unsupported --env '${ENV_NAME}'. Use: floor5, pipe, or pipeline_xyq." >&2
    exit 2
    ;;
esac

cleanup_stack() {
  bash "${ROOT}/scripts/kill_current_sim.bash" --force >/dev/null 2>&1 || true
}

if [ "${CLEANUP_ONLY}" = "true" ]; then
  cleanup_stack
  echo "Residual simulation processes cleaned."
  exit 0
fi

if [ ! -f "${ENV_FILE}" ]; then
  echo "Environment file not found: ${ENV_FILE}" >&2
  exit 1
fi

cmd_prefix="cd '${ROOT}'; export ROS_MASTER_URI=http://localhost:11311; unset ROS_IP; export ROS_HOSTNAME=localhost; source scripts/gb3_env.bash"
cmd_px4="${cmd_prefix}; roslaunch px4 ${ENV_NAME}.launch"
cmd_pose="${cmd_prefix}; roslaunch sim_tools get_real_pose.launch"
cmd_remote="${cmd_prefix}; roslaunch sim_tools sim_remote.launch"
cmd_ctrl="${cmd_prefix}; roslaunch px4ctrl run_ctrl.launch"
cmd_uav="${cmd_prefix}; roslaunch uav_control setup.launch"
cmd_planner="${cmd_prefix}; roslaunch gbplanner rmf_sim.launch rviz_en:=${RVIZ_EN} traj_server_en:=true"
cmd_ui="${cmd_prefix}; rosrun gbplanner_ui gbplanner_simple_topic_ui"

titles=(px4 pose remote px4ctrl uav_control gbplanner)
commands=("${cmd_px4}" "${cmd_pose}" "${cmd_remote}" "${cmd_ctrl}" "${cmd_uav}" "${cmd_planner}")

if [ "${UI_EN}" = "true" ]; then
  titles+=(gbplanner_ui)
  commands+=("${cmd_ui}")
fi

if [ "${PRINT_ONLY}" = "true" ]; then
  for i in "${!commands[@]}"; do
    printf '\n# %s\n%s\n' "${titles[$i]}" "${commands[$i]}"
  done
  exit 0
fi

if [ ! -f "${ROOT}/devel/setup.bash" ]; then
  echo "Workspace is not built yet: ${ROOT}/devel/setup.bash not found." >&2
  echo "Run: cd ${ROOT} && source scripts/gb3_env.bash && catkin build" >&2
  exit 1
fi

if [ ! -d "${PX4_ROOT}" ]; then
  echo "PX4 firmware root not found: ${PX4_ROOT}" >&2
  echo "Set PX4_FIRMWARE_ROOT or install/build PX4 at the default path first." >&2
  exit 1
fi

LAUNCH_FILE="${PX4_ROOT}/launch/${ENV_NAME}.launch"
if [ ! -f "${LAUNCH_FILE}" ] || [ ! -f "${PX4_ROOT}/launch/single_vehicle_spawn_xtd.launch" ]; then
  echo "PX4 simulation launch files are missing; syncing assets to ${PX4_ROOT}."
  PX4_FIRMWARE_ROOT="${PX4_ROOT}" bash "${ROOT}/scripts/sync_px4_sim_assets.bash"
fi

set +u
source "${ENV_FILE}"
set -u

missing_ros_packages=()
for pkg in octomap_msgs octomap_ros joy mavros gazebo_ros gbplanner gbplanner_ui sim_tools px4ctrl uav_control; do
  if ! rospack find "${pkg}" >/dev/null 2>&1; then
    missing_ros_packages+=("${pkg}")
  fi
done

if [ "${#missing_ros_packages[@]}" -gt 0 ]; then
  echo "Missing ROS packages: ${missing_ros_packages[*]}" >&2
  echo "For system dependencies, try:" >&2
  echo "  sudo apt-get install ros-noetic-octomap-msgs ros-noetic-octomap-ros ros-noetic-joy ros-noetic-mavros ros-noetic-mavros-extras geographiclib-tools libgoogle-glog-dev libgflags-dev" >&2
  echo "  sudo geographiclib-get-geoids egm96-5" >&2
  echo "Then rebuild: cd ${ROOT} && source scripts/gb3_env.bash && catkin build" >&2
  exit 1
fi

if ! rospack find px4 >/dev/null 2>&1; then
  echo "ROS package 'px4' is still not visible after sourcing ${ENV_FILE}." >&2
  echo "Check PX4_FIRMWARE_ROOT=${PX4_ROOT} and whether PX4 contains package.xml." >&2
  exit 1
fi

if [ ! -x "${PX4_BUILD_DIR}/bin/px4" ] || [ ! -f "${PX4_BUILD_DIR}/etc/init.d-posix/rcS" ]; then
  echo "PX4 SITL build is missing under: ${PX4_BUILD_DIR}" >&2
  echo "Build PX4 first:" >&2
  echo "  cd ${PX4_ROOT} && make px4_sitl_default gazebo-classic" >&2
  exit 1
fi

if env | grep -E 'csj|uestc-gb3' >/dev/null; then
  echo "Warning: old workspace paths containing 'csj' or 'uestc-gb3' are still in the environment:" >&2
  env | grep -E 'csj|uestc-gb3' >&2 || true
fi

cleanup_stack

if command -v tmux >/dev/null 2>&1; then
  session="gbplanner_${ENV_NAME}"
  tmux new-session -d -s "${session}" -n "${titles[0]}" "bash -lc \"${commands[0]}; exec bash\""
  for i in $(seq 1 $((${#commands[@]} - 1))); do
    tmux new-window -t "${session}" -n "${titles[$i]}" "bash -lc \"${commands[$i]}; exec bash\""
    sleep 1
  done
  echo "Started tmux session '${session}'. Attach with: tmux attach -t ${session}"
elif command -v gnome-terminal >/dev/null 2>&1 && [ -n "${DISPLAY:-}" ]; then
  for i in "${!commands[@]}"; do
    gnome-terminal --title="${titles[$i]}" -- bash -lc "${commands[$i]}; exec bash"
    sleep 1
  done
  echo "Started simulation terminal windows for '${ENV_NAME}'."
else
  echo "No tmux session or graphical terminal is available. Re-run with --print and paste the commands manually." >&2
  exit 1
fi
