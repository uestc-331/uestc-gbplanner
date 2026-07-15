# Backup Before Dirty Root Escape

Created: 2026-07-10 14:56:53 Asia/Shanghai

Purpose:
- Add a configurable dirty-root escape final-path check.
- Escape is allowed only near a dirty start and must move toward higher ESDF clearance.
- Keep normal wall clearance and collision checks for the rest of the path.

Files backed up:
- planner_common/include/planner_common/params.h
- planner_common/src/params.cpp
- gbplanner/include/gbplanner/rrg.h
- gbplanner/src/rrg.cpp
- gbplanner/config/rmf_obelix/gbplanner_config.yaml
