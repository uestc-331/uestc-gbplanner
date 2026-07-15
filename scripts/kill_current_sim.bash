#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

DRY_RUN=false
FORCE=false

usage() {
  cat <<EOF
Usage: bash scripts/kill_current_sim.bash [--dry-run] [--force]

Stops the current GBPlanner/PX4/Gazebo simulation stack for this workspace.

Options:
  --dry-run   Print matched processes without killing them.
  --force     Send SIGKILL immediately instead of SIGTERM first.
  -h, --help  Show this help.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --force)
      FORCE=true
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

patterns=(
  "/opt/ros/noetic/bin/roslaunch px4 .*\\.launch"
  "/opt/ros/noetic/bin/roslaunch sim_tools get_real_pose\\.launch"
  "/opt/ros/noetic/bin/roslaunch sim_tools sim_remote\\.launch"
  "/opt/ros/noetic/bin/roslaunch px4ctrl run_ctrl\\.launch"
  "/opt/ros/noetic/bin/roslaunch uav_control setup\\.launch"
  "/opt/ros/noetic/bin/roslaunch gbplanner rmf_sim\\.launch"
  "/opt/ros/noetic/bin/rosmaster --core -p 11311"
  "/opt/ros/noetic/lib/gazebo_ros/gzserver"
  "/opt/ros/noetic/lib/gazebo_ros/gzclient"
  "gzserver --verbose.*floor5_5_8\\.world"
  "gzserver --verbose.*pipe.*\\.world"
  "gzserver --verbose.*pipeline.*\\.world"
  "gzclient --verbose"
  "/opt/ros/noetic/lib/mavros/mavros_node"
  "/home/uestc/PX4-Autopilot/build/px4_sitl_default/bin/px4"
  "/home/uestc/PX4_Firmware/build/px4_sitl_default/bin/px4"
  "${ROOT}/devel/.private/px4ctrl/lib/px4ctrl/px4ctrl_node"
  "${ROOT}/devel/.private/uav_control/lib/uav_control/uav_control_node"
  "${ROOT}/devel/.private/gbplanner/lib/gbplanner/gbplanner_node"
  "${ROOT}/devel/.private/gbplanner/lib/gbplanner/odom_to_tf_node"
  "${ROOT}/devel/.private/gbplanner/lib/gbplanner/pointcloud_frame_fixer_node"
  "${ROOT}/devel/.private/pci_general/lib/pci_general/pci_general_ros_node"
  "${ROOT}/devel/.private/sim_tools/lib/sim_tools/traj_server_node"
  "${ROOT}/devel/.private/sim_tools/lib/sim_tools/get_local_pose.py"
  "${ROOT}/devel/.private/sim_tools/lib/sim_tools/sim_remote.py"
  "/opt/ros/noetic/lib/rviz/rviz.*gbplanner_ui"
)

tmp_file="$(mktemp)"
trap 'rm -f "${tmp_file}"' EXIT

for pattern in "${patterns[@]}"; do
  pgrep -af "${pattern}" >> "${tmp_file}" || true
done

awk -v self="$$" -v parent="${PPID}" '
  $1 != self && $1 != parent && !seen[$1]++ { print }
' "${tmp_file}" > "${tmp_file}.unique"
mv "${tmp_file}.unique" "${tmp_file}"

if [ ! -s "${tmp_file}" ]; then
  echo "No GBPlanner/PX4 simulation processes matched."
  exit 0
fi

echo "Matched processes:"
cat "${tmp_file}"

if [ "${DRY_RUN}" = true ]; then
  echo "Dry run only; no processes were killed."
  exit 0
fi

pids="$(awk '{print $1}' "${tmp_file}")"

if [ "${FORCE}" = true ]; then
  echo "Sending SIGKILL..."
  kill -KILL ${pids} 2>/dev/null || true
  exit 0
fi

echo "Sending SIGTERM..."
kill -TERM ${pids} 2>/dev/null || true
sleep 3

alive=()
for pid in ${pids}; do
  if kill -0 "${pid}" 2>/dev/null; then
    alive+=("${pid}")
  fi
done

if [ "${#alive[@]}" -gt 0 ]; then
  echo "Still alive after SIGTERM, sending SIGKILL: ${alive[*]}"
  kill -KILL "${alive[@]}" 2>/dev/null || true
else
  echo "All matched processes stopped."
fi
