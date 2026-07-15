# Backup before restoring pre-ablation features

Date: 2026-07-10

Reason:
- User reported the best behavior was after the stable min-bound start check / recovery gate fix.
- Restore the feature set that existed before the core-clearance-only ablation.

Rollback source:
- config_backups/rmf_obelix_before_ablation_core_clearance_only_20260710/gbplanner_config.yaml
- config_backups/rmf_obelix_before_ablation_core_clearance_only_20260710/planner_control_interface_sim_config.yaml

Expected feature state after restore:
- centerline_bias_enable: true
- path_smoothness_enable: true
- forward_exploration_enable: true
- wall_clearance_enable: true
- min_path_length: 1.0

Core code changes are not reverted:
- stable min-bound start check remains in rrg.cpp
- start recovery is skipped when min-bound start is free
