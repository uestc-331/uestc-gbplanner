#!/usr/bin/env bash
set -e

cd /home/uestc/gb3/uestc-gbplanner

source scripts/gb3_env.bash

roslaunch gbplanner rmf_real.launch & sleep 2

rosrun gbplanner_ui gbplanner_cli
wait;
