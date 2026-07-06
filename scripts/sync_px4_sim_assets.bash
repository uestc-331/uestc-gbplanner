#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
PX4_ROOT="${PX4_FIRMWARE_ROOT:-/home/uestc/PX4_Firmware}"
ASSET_ROOT="${ROOT}/external/px4_sim_assets"

if [ ! -d "${ASSET_ROOT}" ]; then
  echo "PX4 sim asset directory not found: ${ASSET_ROOT}" >&2
  exit 1
fi

mkdir -p "${PX4_ROOT}/launch"
mkdir -p "${PX4_ROOT}/Tools/sitl_gazebo/worlds"
mkdir -p "${PX4_ROOT}/Tools/sitl_gazebo/models"

cp -a "${ASSET_ROOT}/launch/." "${PX4_ROOT}/launch/"
cp -a "${ASSET_ROOT}/worlds/." "${PX4_ROOT}/Tools/sitl_gazebo/worlds/"
cp -a "${ASSET_ROOT}/models/." "${PX4_ROOT}/Tools/sitl_gazebo/models/"

echo "PX4 simulation assets synced to ${PX4_ROOT}"
