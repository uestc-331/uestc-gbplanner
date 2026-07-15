# Backup before reducing empty-path retry parameters

Date: 2026-07-10

Reason:
- Reduce long stops caused by repeated empty path returns.
- Allow short local escape/exploration paths.
- Reduce over-aggressive path safety enhancement failures.

Backed up files:
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml

Planned changes:
- min_path_length: 1.0 -> 0.45
- safety_extension: [2.6, 2.6, 1.8] -> [2.2, 2.2, 1.5]
- edge_overshoot: 0.55 -> 0.45
