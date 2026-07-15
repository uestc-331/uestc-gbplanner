# Backup before restoring bound mode after gate search

Created: 2026-07-10

Reason: searchPathToPassGate temporarily changes robot bound mode / robot_box_size_ and may leave start checks using the wrong larger box.

Files:
- src/exploration/gbplanner_ros/gbplanner/src/rrg.cpp
