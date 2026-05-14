#!/usr/bin/env bash
set -u

ROOT="${GB3_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
REF_ROOT="${GBPLANNER_REF_ROOT:-/home/uestc/csj/uestc-gbplanner}"

WARN_COUNT=0
FATAL_COUNT=0

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

relpath() {
  local path="$1"
  case "$path" in
    "$ROOT"/*) printf '%s' "${path#$ROOT/}" ;;
    "$REF_ROOT"/*) printf '%s' "${path#$REF_ROOT/}" ;;
    *) printf '%s' "$path" ;;
  esac
}

check_dir() {
  local severity="$1"
  local path="$2"
  local desc="$3"
  if [[ -d "$ROOT/$path" ]]; then
    ok "$desc exists: $path"
  elif [[ "$severity" == "fatal" ]]; then
    fatal "$desc missing: $path"
  else
    warn "$desc missing: $path"
  fi
}

check_file() {
  local severity="$1"
  local path="$2"
  local desc="$3"
  if [[ -f "$ROOT/$path" ]]; then
    ok "$desc exists: $path"
  elif [[ "$severity" == "fatal" ]]; then
    fatal "$desc missing: $path"
  else
    warn "$desc missing: $path"
  fi
}

manifest_name() {
  sed -n 's/.*<name>[[:space:]]*\([^<]*\)[[:space:]]*<\/name>.*/\1/p' "$1" \
    | head -n 1 \
    | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

package_dirs() {
  local root="$1"
  local pkg="$2"
  [[ -d "$root/src" ]] || return 0
  find "$root/src" -type f -name package.xml 2>/dev/null | while IFS= read -r manifest; do
    local name
    name="$(manifest_name "$manifest")"
    if [[ "$name" == "$pkg" ]]; then
      dirname "$manifest"
    fi
  done
}

package_names() {
  local root="$1"
  [[ -d "$root/src" ]] || return 0
  find "$root/src" -type f -name package.xml 2>/dev/null | while IFS= read -r manifest; do
    manifest_name "$manifest"
  done | sed '/^$/d' | sort -u
}

check_active_package() {
  local severity="$1"
  local pkg="$2"
  local desc="$3"
  local dirs=()
  local active=()
  local ignored=()
  mapfile -t dirs < <(package_dirs "$ROOT" "$pkg")

  if [[ "${#dirs[@]}" -eq 0 ]]; then
    if [[ "$severity" == "fatal" ]]; then
      fatal "$desc package missing: $pkg"
    else
      warn "$desc package missing: $pkg"
    fi
    return
  fi

  local dir
  for dir in "${dirs[@]}"; do
    if [[ -e "$dir/CATKIN_IGNORE" ]]; then
      ignored+=("$(relpath "$dir")")
    else
      active+=("$(relpath "$dir")")
    fi
  done

  if [[ "${#active[@]}" -gt 0 ]]; then
    ok "$desc package active: $pkg (${active[*]})"
    if [[ "${#ignored[@]}" -gt 0 ]]; then
      warn "$pkg also has ignored copy: ${ignored[*]}"
    fi
  elif [[ "$severity" == "fatal" ]]; then
    fatal "$desc package exists only under CATKIN_IGNORE: $pkg (${ignored[*]})"
  else
    warn "$desc package exists only under CATKIN_IGNORE: $pkg (${ignored[*]})"
  fi
}

scan_rg() {
  local pattern="$1"
  shift
  rg -q -S "$pattern" "$@" 2>/dev/null
}

check_pattern() {
  local severity="$1"
  local pattern="$2"
  local desc="$3"
  if scan_rg "$pattern" "${SCAN_PATHS[@]}"; then
    ok "$desc static reference found"
  elif [[ "$severity" == "fatal" ]]; then
    fatal "$desc static reference missing: $pattern"
  else
    warn "$desc static reference missing: $pattern"
  fi
}

check_cmake_target() {
  local severity="$1"
  local cmake="$2"
  local target="$3"
  local desc="$4"
  if [[ ! -f "$ROOT/$cmake" ]]; then
    [[ "$severity" == "fatal" ]] && fatal "$desc CMake file missing: $cmake" || warn "$desc CMake file missing: $cmake"
    return
  fi
  if rg -q -S "(cs_add_executable|add_executable)[[:space:]]*\\([[:space:]]*$target|cs_add_executable[[:space:]]*$target|add_executable[[:space:]]*$target" "$ROOT/$cmake"; then
    ok "$desc target present in $cmake: $target"
  elif [[ "$severity" == "fatal" ]]; then
    fatal "$desc target missing in $cmake: $target"
  else
    warn "$desc target missing in $cmake: $target"
  fi
}

printf 'GB3 static interface check\n'
printf 'root: %s\n' "$ROOT"
printf 'reference: %s\n' "$REF_ROOT"

if [[ ! -d "$ROOT/src" ]]; then
  fatal "GB3 src directory missing: $ROOT/src"
  printf 'summary: OK with %d WARN, %d FATAL\n' "$WARN_COUNT" "$FATAL_COUNT"
  exit 2
fi

if [[ -d "$REF_ROOT/src" ]]; then
  ok "reference source tree found"
else
  warn "reference source tree not found; package diff checks will be skipped"
fi

SCAN_PATHS=("$ROOT/src" "$ROOT/scripts")
[[ -f "$ROOT/README1.md" ]] && SCAN_PATHS+=("$ROOT/README1.md")
[[ -f "$ROOT/test.rviz" ]] && SCAN_PATHS+=("$ROOT/test.rviz")

check_dir fatal "src/exploration" "exploration bucket"
check_dir fatal "src/mapping" "mapping bucket"
check_dir fatal "src/misc" "misc bucket"
check_dir fatal "src/sim" "sim bucket"
check_dir fatal "src/sim_tools" "sim_tools bridge"
check_dir fatal "src/uav_control" "uav_control bridge"
check_dir fatal "src/px4ctrl" "px4ctrl controller"

check_active_package fatal "gbplanner" "planner core"
check_active_package fatal "planner_common" "planner common"
check_active_package fatal "planner_control_interface" "planner-control interface"
check_active_package fatal "planner_msgs" "planner messages"
check_active_package fatal "planner_semantic_msgs" "planner semantic messages"
check_active_package fatal "pci_general" "PCI manager"
check_active_package fatal "voxblox" "voxblox core"
check_active_package fatal "voxblox_ros" "voxblox ROS"
check_active_package fatal "voxblox_msgs" "voxblox messages"
check_active_package fatal "catkin_simple" "catkin_simple"
check_active_package fatal "gflags_catkin" "gflags_catkin"
check_active_package fatal "glog_catkin" "glog_catkin"
check_active_package fatal "mav_msgs" "mav messages"
check_active_package fatal "minkindr" "minkindr"
check_active_package fatal "minkindr_conversions" "minkindr ROS conversions"
check_active_package fatal "quadrotor_msgs" "quadrotor PositionCommand"
check_active_package fatal "px4ctrl" "PX4 controller"
check_active_package fatal "sim_tools" "sim bridge tools"
check_active_package fatal "uav_control" "UAV control"
check_active_package warn "gbplanner_ros" "reference gbplanner_ros metapackage"

check_file warn "src/exploration/gbplanner_ros/gbplanner/launch/rmf/rmf_sim.launch" "reference rmf_obelix sim launch"
check_file warn "src/exploration/gbplanner_ros/gbplanner/launch/rmf/rmf_real_robot.launch" "reference rmf_obelix real launch"
check_file warn "src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml" "reference rmf_obelix planner config"
check_file warn "src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/voxblox_sim_config.yaml" "reference rmf_obelix voxblox config"

check_cmake_target warn "src/exploration/gbplanner_ros/gbplanner/CMakeLists.txt" "pointcloud_frame_fixer_node" "gbplanner Livox frame fixer"
check_cmake_target warn "src/exploration/gbplanner_ros/gbplanner/CMakeLists.txt" "odom_to_tf_node" "gbplanner odom-to-TF bridge"
check_cmake_target fatal "src/sim_tools/CMakeLists.txt" "traj_server_node" "sim_tools trajectory-to-position bridge"

check_pattern fatal "/vins_fusion/imu_propagate" "odometry contract /vins_fusion/imu_propagate"
check_pattern fatal "/position_cmd" "controller command contract /position_cmd"
check_pattern fatal "rmf_obelix/command/trajectory" "planner trajectory contract /rmf_obelix/command/trajectory"
check_pattern fatal "gbplanner_status" "planner status contract /gbplanner_status"
check_pattern warn "Local completion check" "planner completion diagnostic"
check_pattern warn "Non-finite direction score" "planner direction-score guard"
check_pattern warn "No valid local exploration path" "planner low-gain diagnostic"
check_pattern warn "Path ACCEPTED" "planner path-accept log"
check_pattern warn "Path REJECTED" "planner path-reject log"
check_pattern warn "/livox/lidar" "raw Livox topic /livox/lidar"
check_pattern warn "/livox/lidar_fixed" "fixed Livox topic /livox/lidar_fixed"
check_pattern warn "update_stamp_to_now" "Livox stamp update parameter"

VOXBLOX_RMF="$ROOT/src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/voxblox_sim_config.yaml"
if [[ -f "$VOXBLOX_RMF" ]]; then
  if rg -q -S '^update_mesh_every_n_sec:[[:space:]]*0(\.0)?([[:space:]]|#|$)' "$VOXBLOX_RMF"; then
    warn "rmf_obelix voxblox mesh update is disabled; RViz map clouds will not refresh automatically"
  else
    ok "rmf_obelix voxblox mesh update is enabled"
  fi
fi

POS_PUB_REFS="$(rg -n -S 'advertise<[^>]*PositionCommand>.*"/position_cmd"' "${SCAN_PATHS[@]}" 2>/dev/null || true)"
if [[ -n "$POS_PUB_REFS" ]]; then
  POS_PUB_COUNT="$(printf '%s\n' "$POS_PUB_REFS" | sed '/^$/d' | wc -l | tr -d ' ')"
  if [[ "$POS_PUB_COUNT" -eq 1 ]]; then
    ok "one static /position_cmd publisher implementation found"
  else
    if rg -q -S 'publish_position_cmd"[[:space:]]+value="false"|publish_position_cmd[[:space:]]*.*false' "$ROOT/src/uav_control/launch" 2>/dev/null; then
      ok "multiple static /position_cmd implementations found, and uav_control launch disables its publisher"
    else
      warn "multiple static /position_cmd publisher implementations found ($POS_PUB_COUNT); ensure only one is launched"
      printf '%s\n' "$POS_PUB_REFS" | sed 's/^/      /'
    fi
  fi
else
  fatal "no static /position_cmd publisher implementation found"
fi

if [[ -d "$REF_ROOT/src" ]]; then
  MISSING_PKGS="$(comm -23 <(package_names "$REF_ROOT") <(package_names "$ROOT") | tr '\n' ' ' | sed 's/[[:space:]]*$//')"
  EXTRA_PKGS="$(comm -13 <(package_names "$REF_ROOT") <(package_names "$ROOT") | tr '\n' ' ' | sed 's/[[:space:]]*$//')"
  if [[ -n "$MISSING_PKGS" ]]; then
    warn "packages present in reference but absent in GB3: $MISSING_PKGS"
  else
    ok "no package names missing relative to reference"
  fi
  if [[ -n "$EXTRA_PKGS" ]]; then
    warn "packages present in GB3 but absent in reference: $EXTRA_PKGS"
  else
    ok "no extra package names relative to reference"
  fi
fi

if [[ -d "$ROOT/build" ]] && rg -q -S "$REF_ROOT" "$ROOT/build" -g 'CMakeCache.txt' 2>/dev/null; then
  warn "build CMakeCache contains reference workspace paths; clean/rebuild before trusting runtime checks"
else
  ok "no reference workspace path found in GB3 build CMakeCache files"
fi

printf 'summary: %d WARN, %d FATAL\n' "$WARN_COUNT" "$FATAL_COUNT"
if [[ "$FATAL_COUNT" -gt 0 ]]; then
  exit 2
elif [[ "$WARN_COUNT" -gt 0 ]]; then
  exit 1
fi
