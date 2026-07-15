# Backup: before strict no-wall-collision parameter pass

Created: 2026-07-10

Purpose:
- Make planning and execution more conservative after observed wall collision.
- Keep algorithm unchanged; tune clearance, shortcut, interpolation, waypoint progression, speed, and acceleration.

Files backed up:
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_sim_config.yaml
