# Backup before dirty-root escape prefix relaxation

Created: 2026-07-10 15:27:13 Asia/Shanghai

Purpose: allow DIRTY_ROOT_ESCAPE to handle strict final-check failures localized to the path prefix, even if the final root box query has become free.

Files:
- src/exploration/gbplanner_ros/gbplanner/src/rrg.cpp
- src/exploration/gbplanner_ros/gbplanner/include/gbplanner/rrg.h
