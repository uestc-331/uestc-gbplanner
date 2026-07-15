# Backup before stable start-check and recovery gate

Created: 2026-07-10

Reason: prevent planning from getting stuck when start is checked with oversized retry bounds and when start recovery runs even though the min start box is free.

Files:
- src/exploration/gbplanner_ros/gbplanner/src/rrg.cpp
- src/exploration/gbplanner_ros/gbplanner/include/gbplanner/rrg.h
- src/exploration/gbplanner_ros/gbplanner/src/gbplanner.cpp
