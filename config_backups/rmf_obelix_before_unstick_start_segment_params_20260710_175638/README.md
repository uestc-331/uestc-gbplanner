# Backup before unstick start-segment parameter tuning

Date: 2026-07-10

Reason:
- Latest logs show repeated empty paths because the first/final path segment near the robot is judged occupied.
- min_path_length=0.45 is already effective, so the next target is dirty start/near-root occupied voxels.

Backed up files:
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/voxblox_sim_config.yaml

Planned changes:
- clear_sphere_radius: 1.2 -> 1.8
- dirty_start_edge_tolerance_dist: 1.0 -> 1.5
- dirty_root_escape_dist: 1.0 -> 1.5
- start_recovery_ignore_start_dist: 1.0 -> 1.3
- min_path_length: 0.45 -> 0.35

Keep unchanged:
- wall_clearance_enable: true
- wall_clearance_min: 0.55
- wall_clearance_reject_final_path: true
