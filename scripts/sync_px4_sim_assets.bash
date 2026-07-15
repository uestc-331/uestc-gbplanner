#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
if [ -z "${PX4_FIRMWARE_ROOT:-}" ]; then
  if [ -d /home/uestc/PX4-Autopilot ]; then
    PX4_ROOT=/home/uestc/PX4-Autopilot
  else
    PX4_ROOT=/home/uestc/PX4_Firmware
  fi
else
  PX4_ROOT="${PX4_FIRMWARE_ROOT}"
fi
ASSET_ROOT="${ROOT}/external/px4_sim_assets"

if [ ! -d "${ASSET_ROOT}" ]; then
  echo "PX4 sim asset directory not found: ${ASSET_ROOT}" >&2
  exit 1
fi

mkdir -p "${PX4_ROOT}/launch"

cp -a "${ASSET_ROOT}/launch/." "${PX4_ROOT}/launch/"

if [ -d "${PX4_ROOT}/Tools/simulation/gazebo-classic/sitl_gazebo-classic" ]; then
  GAZEBO_ROOT="${PX4_ROOT}/Tools/simulation/gazebo-classic/sitl_gazebo-classic"
else
  GAZEBO_ROOT="${PX4_ROOT}/Tools/sitl_gazebo"
fi

mkdir -p "${GAZEBO_ROOT}/worlds"
mkdir -p "${GAZEBO_ROOT}/models"

cp -a "${ASSET_ROOT}/worlds/." "${GAZEBO_ROOT}/worlds/"
cp -a "${ASSET_ROOT}/models/." "${GAZEBO_ROOT}/models/"

echo "PX4 simulation assets synced to ${PX4_ROOT}"
echo "Gazebo assets synced to ${GAZEBO_ROOT}"
