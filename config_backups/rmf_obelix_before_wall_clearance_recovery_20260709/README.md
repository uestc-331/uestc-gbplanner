# rmf_obelix wall-clearance recovery backup

Backup time: 2026-07-09

Reason:
- Preserve the current rmf_obelix configuration before tuning wall clearance and
  recovery from collision-check failures.
- This backup is intended for the parameter experiment that reduces
  "Starting position is not clear", empty planner paths, and long hover stops.

Original files:
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_sim_config.yaml
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_real_config.yaml
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/voxblox_sim_config.yaml

Planned tuning:
- Use a more recovery-friendly planning bound mode.
- Increase the clear sphere radius used for planning.
- Keep path-shape and gain parameters unchanged in this first round.
