# rmf_obelix clear sphere 1.5 backup

Backup time: 2026-07-09

Reason:
- Preserve the current rmf_obelix configuration before increasing
  `clear_sphere_radius` from 1.2 to 1.5.
- This experiment targets repeated "Starting position is not clear" and empty
  planner paths caused by occupied voxels around the current robot pose.

Original files:
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/voxblox_sim_config.yaml
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_sim_config.yaml
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_real_config.yaml
