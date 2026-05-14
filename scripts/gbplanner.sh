#!/usr/bin/env bash
set -e

cd /home/super/uestcgbplanner3

source /opt/ros/noetic/setup.bash
source /home/super/uestcgbplanner3/devel/setup.bash

roslaunch gbplanner rmf_real.launch & sleep 2

rosrun gbplanner_ui gbplanner_cli
wait;
