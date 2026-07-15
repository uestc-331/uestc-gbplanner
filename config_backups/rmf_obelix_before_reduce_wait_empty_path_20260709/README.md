# rmf_obelix reduce wait and empty-path backup

Backup time: 2026-07-09

Reason:
- Preserve the current rmf_obelix configuration before tuning to reduce long
  hover waits, repeated empty planner paths, and slow recovery after STUCK.
- This experiment keeps the algorithm unchanged and only adjusts planner
  parameters.

Original files:
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/voxblox_sim_config.yaml
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_sim_config.yaml
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_real_config.yaml

Planned tuning:
- Reduce planning collision extension slightly.
- Reduce edge overshoot and minimum path length.
- Reduce RRG graph/loop limits moderately.
- Keep safety enhancement enabled and keep current gain penalties unchanged.
