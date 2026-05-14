#!/usr/bin/env bash
set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/gb3_env.bash" ]]; then
  # Keep command output focused on the graph checks.
  source "$SCRIPT_DIR/gb3_env.bash" >/dev/null 2>&1 || true
fi

ROS_TIMEOUT="${ROS_TIMEOUT:-5}"
ROS_SAMPLE_TIMEOUT="${ROS_SAMPLE_TIMEOUT:-2}"
ROS_MAP_SAMPLE_TIMEOUT="${ROS_MAP_SAMPLE_TIMEOUT:-4}"
PROFILE="${GB3_RUNTIME_PROFILE:-auto}"
WARN_COUNT=0
FATAL_COUNT=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile)
      PROFILE="${2:-}"
      shift 2
      ;;
    --profile=*)
      PROFILE="${1#*=}"
      shift
      ;;
    -h|--help)
      echo "usage: $0 [--profile auto|rmf_sim|xtdrone]" >&2
      exit 0
      ;;
    *)
      echo "unknown argument: $1" >&2
      echo "usage: $0 [--profile auto|rmf_sim|xtdrone]" >&2
      exit 2
      ;;
  esac
done

emit() {
  local level="$1"
  local msg="$2"
  printf '%-5s %s\n' "$level" "$msg"
}

ok() {
  emit "OK" "$1"
}

warn() {
  WARN_COUNT=$((WARN_COUNT + 1))
  emit "WARN" "$1"
}

fatal() {
  FATAL_COUNT=$((FATAL_COUNT + 1))
  emit "FATAL" "$1"
}

run_timeout() {
  local seconds="$1"
  shift
  if command -v timeout >/dev/null 2>&1; then
    timeout "$seconds" "$@"
  else
    "$@"
  fi
}

need_cmd() {
  local cmd="$1"
  if command -v "$cmd" >/dev/null 2>&1; then
    ok "command found: $cmd"
  else
    fatal "command missing: $cmd"
  fi
}

topic_info() {
  local topic="$1"
  run_timeout "$ROS_TIMEOUT" rostopic info "$topic" 2>&1
}

topic_counts() {
  awk '
    /^Publishers:/ { section = "pub"; next }
    /^Subscribers:/ { section = "sub"; next }
    /^\* / {
      if (section == "pub") pub++;
      if (section == "sub") subs++;
      next;
    }
    /^[^[:space:]]/ { section = "" }
    END { printf "%d %d\n", pub + 0, subs + 0 }
  '
}

topic_present() {
  local topic="$1"
  printf '%s\n' "$TOPICS" | grep -Fxq "$topic"
}

resolve_topic() {
  local topic
  for topic in "$@"; do
    if topic_present "$topic"; then
      printf '%s\n' "$topic"
      return 0
    fi
  done
  return 1
}

node_present() {
  local node_tail="$1"
  printf '%s\n' "$NODES" | grep -Eq "(^|/)$node_tail$"
}

check_node() {
  local severity="$1"
  local node_tail="$2"
  local desc="$3"
  if node_present "$node_tail"; then
    ok "$desc node present: *$node_tail"
  elif [[ "$severity" == "fatal" ]]; then
    fatal "$desc node missing: *$node_tail"
  else
    warn "$desc node missing: *$node_tail"
  fi
}

get_topic_counts() {
  local topic="$1"
  local info
  if ! info="$(topic_info "$topic")"; then
    printf '0 0'
    return 1
  fi
  printf '%s\n' "$info" | topic_counts
}

check_topic_min() {
  local severity="$1"
  local topic="$2"
  local min_pub="$3"
  local min_sub="$4"
  local desc="$5"
  local counts
  local pub
  local sub
  if ! counts="$(get_topic_counts "$topic")"; then
    if [[ "$severity" == "fatal" ]]; then
      fatal "$desc topic not available: $topic"
    else
      warn "$desc topic not available: $topic"
    fi
    return
  fi
  read -r pub sub <<<"$counts"
  if [[ "$pub" -ge "$min_pub" ]]; then
    ok "$desc publishers($topic): $pub"
  elif [[ "$severity" == "fatal" ]]; then
    fatal "$desc publishers($topic): $pub, expected >= $min_pub"
  else
    warn "$desc publishers($topic): $pub, expected >= $min_pub"
  fi
  if [[ "$sub" -ge "$min_sub" ]]; then
    ok "$desc subscribers($topic): $sub"
  elif [[ "$severity" == "fatal" ]]; then
    fatal "$desc subscribers($topic): $sub, expected >= $min_sub"
  else
    warn "$desc subscribers($topic): $sub, expected >= $min_sub"
  fi
}

check_position_cmd() {
  local topic="/position_cmd"
  local counts
  local pub
  local sub
  if ! counts="$(get_topic_counts "$topic")"; then
    fatal "$topic not available; controller has no position command topic"
    return
  fi
  read -r pub sub <<<"$counts"
  if [[ "$pub" -eq 1 ]]; then
    ok "$topic publisher count is exactly 1"
  elif [[ "$pub" -eq 0 ]]; then
    fatal "$topic has no publisher"
  else
    fatal "$topic has $pub publishers; command arbitration is unsafe"
  fi
  if [[ "$sub" -ge 1 ]]; then
    ok "$topic has controller subscriber(s): $sub"
  else
    warn "$topic has no subscriber; px4ctrl may not be running or remapped"
  fi
}

sample_topic() {
  local topic="$1"
  local desc="$2"
  local timeout_sec="${3:-$ROS_SAMPLE_TIMEOUT}"
  if run_timeout "$timeout_sec" rostopic echo -n 1 "$topic" >/dev/null 2>&1; then
    ok "$desc produced at least one sample within ${timeout_sec}s"
  else
    warn "$desc produced no sample within ${timeout_sec}s"
  fi
}

check_service() {
  local severity="$1"
  local service="$2"
  local desc="$3"
  if printf '%s\n' "$SERVICES" | grep -Fxq "$service"; then
    ok "$desc service present: $service"
  elif [[ "$severity" == "fatal" ]]; then
    fatal "$desc service missing: $service"
  else
    warn "$desc service missing: $service"
  fi
}

check_tf() {
  local severity="$1"
  local from_frame="$2"
  local to_frame="$3"
  local desc="$4"
  local out
  out="$(run_timeout "$ROS_SAMPLE_TIMEOUT" rosrun tf tf_echo "$from_frame" "$to_frame" 2>&1 || true)"
  if printf '%s\n' "$out" | grep -Eq "Translation:|At time"; then
    ok "$desc TF available: $from_frame -> $to_frame"
  elif [[ "$severity" == "fatal" ]]; then
    fatal "$desc TF unavailable: $from_frame -> $to_frame"
    printf '%s\n' "$out" | sed 's/^/      /'
  else
    warn "$desc TF unavailable: $from_frame -> $to_frame"
    printf '%s\n' "$out" | sed 's/^/      /'
  fi
}

check_tf_any() {
  local severity="$1"
  local from_frame="$2"
  local desc="$3"
  shift 3
  local to_frame
  local out
  local last_out=""
  for to_frame in "$@"; do
    out="$(run_timeout "$ROS_SAMPLE_TIMEOUT" rosrun tf tf_echo "$from_frame" "$to_frame" 2>&1 || true)"
    last_out="$out"
    if printf '%s\n' "$out" | grep -Eq "Translation:|At time"; then
      ok "$desc TF available: $from_frame -> $to_frame"
      return 0
    fi
  done
  if [[ "$severity" == "fatal" ]]; then
    fatal "$desc TF unavailable for candidates: $*"
  else
    warn "$desc TF unavailable for candidates: $*"
  fi
  printf '%s\n' "$last_out" | sed 's/^/      /'
}

printf 'GB3 runtime ROS graph check\n'
need_cmd rostopic
need_cmd rosnode
need_cmd rosservice
need_cmd rosrun
if [[ "$FATAL_COUNT" -gt 0 ]]; then
  printf 'summary: %d WARN, %d FATAL\n' "$WARN_COUNT" "$FATAL_COUNT"
  exit 2
fi

if ! NODES="$(run_timeout "$ROS_TIMEOUT" rosnode list 2>&1)"; then
  fatal "rosnode list failed; ROS master is not reachable or ROS env is not sourced"
  printf '%s\n' "$NODES" | sed 's/^/      /'
  printf 'summary: %d WARN, %d FATAL\n' "$WARN_COUNT" "$FATAL_COUNT"
  exit 2
fi
ok "rosnode list succeeded"

if ! TOPICS="$(run_timeout "$ROS_TIMEOUT" rostopic list 2>&1)"; then
  fatal "rostopic list failed; ROS master is not reachable or ROS env is not sourced"
  printf '%s\n' "$TOPICS" | sed 's/^/      /'
  printf 'summary: %d WARN, %d FATAL\n' "$WARN_COUNT" "$FATAL_COUNT"
  exit 2
fi
ok "rostopic list succeeded"

if ! SERVICES="$(run_timeout "$ROS_TIMEOUT" rosservice list 2>&1)"; then
  fatal "rosservice list failed; ROS master is not reachable or ROS env is not sourced"
  printf '%s\n' "$SERVICES" | sed 's/^/      /'
  printf 'summary: %d WARN, %d FATAL\n' "$WARN_COUNT" "$FATAL_COUNT"
  exit 2
fi
ok "rosservice list succeeded"

if [[ "$PROFILE" == "auto" ]]; then
  if topic_present "/iris_0/mavros/state" || topic_present "/iris_0/mavros/odometry/in"; then
    PROFILE="xtdrone"
  else
    PROFILE="rmf_sim"
  fi
fi

case "$PROFILE" in
  rmf_sim|xtdrone) ;;
  *)
    fatal "unsupported profile: $PROFILE"
    printf 'summary: %d WARN, %d FATAL\n' "$WARN_COUNT" "$FATAL_COUNT"
    exit 2
    ;;
esac
ok "runtime profile: $PROFILE"

check_node fatal "gbplanner_node" "gbplanner"
check_node fatal "pci_general_ros_node" "PCI"
check_node warn "traj_server_node" "trajectory-to-position bridge"
check_node warn "pointcloud_frame_fixer_node" "Livox frame fixer"
check_node warn "px4ctrl" "PX4 controller"

check_position_cmd
check_topic_min fatal "/vins_fusion/imu_propagate" 1 1 "VINS/odometry"

if [[ "$PROFILE" == "rmf_sim" ]]; then
  check_topic_min fatal "/livox/lidar" 1 0 "raw Livox lidar"
  check_topic_min fatal "/livox/lidar_fixed" 1 1 "fixed Livox lidar"
  check_topic_min fatal "/rmf_obelix/command/trajectory" 1 1 "planner trajectory command"
else
  check_topic_min warn "/iris_0/mavros/state" 1 0 "XTDrone MAVROS state"
  check_topic_min warn "/iris_0/mavros/odometry/in" 1 0 "XTDrone MAVROS odometry"
  trajectory_topic="${GB3_TRAJECTORY_TOPIC:-}"
  if [[ -z "$trajectory_topic" ]]; then
    trajectory_topic="$(resolve_topic "/iris_0/command/trajectory" "/command/trajectory" "/rmf_obelix/command/trajectory" || true)"
  fi
  if [[ -n "$trajectory_topic" ]]; then
    check_topic_min fatal "$trajectory_topic" 1 1 "planner trajectory command"
  else
    fatal "planner trajectory command topic not found; set GB3_TRAJECTORY_TOPIC if XTDrone uses a custom name"
  fi

  pointcloud_topic="${GB3_POINTCLOUD_TOPIC:-}"
  if [[ -z "$pointcloud_topic" ]]; then
    pointcloud_topic="$(resolve_topic "/iris_0/realsense/depth_camera/points" "/camera/depth/color/points" "/camera/depth/points" "/input_pointcloud" "/livox/lidar_fixed" "/livox/lidar" "/rmf_obelix/velodyne_points" || true)"
  fi
  if [[ -n "$pointcloud_topic" ]]; then
    check_topic_min warn "$pointcloud_topic" 1 0 "primary pointcloud"
  else
    fatal "primary pointcloud topic not found; set GB3_POINTCLOUD_TOPIC for the XTDrone sensor topic"
  fi
fi

check_topic_min fatal "/gbplanner_status" 1 0 "planner status"
check_topic_min warn "/gbplanner_node/surface_pointcloud" 1 0 "voxblox surface cloud"
check_topic_min warn "/gbplanner_node/tsdf_pointcloud" 1 0 "voxblox TSDF cloud"
check_topic_min warn "/gbplanner_node/occupied_nodes" 1 0 "voxblox occupied markers"

sample_topic "/gbplanner_status" "planner status /gbplanner_status"
sample_topic "/clock" "simulation clock /clock" "$ROS_SAMPLE_TIMEOUT"
if [[ "$PROFILE" == "rmf_sim" ]]; then
  sample_topic "/livox/lidar_fixed" "fixed Livox cloud /livox/lidar_fixed" "$ROS_SAMPLE_TIMEOUT"
else
  sample_topic "$pointcloud_topic" "primary pointcloud $pointcloud_topic" "$ROS_SAMPLE_TIMEOUT"
fi
sample_topic "/gbplanner_node/surface_pointcloud" "surface map /gbplanner_node/surface_pointcloud" "$ROS_MAP_SAMPLE_TIMEOUT"

check_service fatal "/gbplanner_ros" "planner BT"
check_service warn "/gbplanner/homing" "planner homing"
check_service warn "/gbplanner_node/publish_pointclouds" "manual voxblox pointcloud publish"
check_service warn "/gbplanner_node/generate_mesh" "manual voxblox mesh generation"

if [[ "$PROFILE" == "rmf_sim" ]]; then
  check_tf fatal "world" "rmf_obelix/base_link" "odometry"
  check_tf warn "world" "rmf_obelix/rmf_obelix/velodyne" "lidar"
else
  check_tf_any fatal "world" "odometry" \
    "${GB3_BASE_FRAME:-iris_0/base_link}" "base_link" "rmf_obelix/base_link"
  check_tf_any warn "world" "lidar" \
    "${GB3_LIDAR_FRAME:-iris_0/velodyne}" "camera_depth_frame" "camera_link" "rmf_obelix/rmf_obelix/velodyne"
fi

printf 'summary: %d WARN, %d FATAL\n' "$WARN_COUNT" "$FATAL_COUNT"
if [[ "$FATAL_COUNT" -gt 0 ]]; then
  exit 2
elif [[ "$WARN_COUNT" -gt 0 ]]; then
  exit 1
fi
