# Backup before rollback to pre-short-path tuning

Date: 2026-07-10

Reason:
- User requested rollback to the state before short-path tuning.

Current state backed up here before rollback.
Rollback source:
- config_backups/rmf_obelix_before_reduce_empty_path_retry_params_20260710_174118/gbplanner_config.yaml

Expected restored values:
- min_path_length: 1.0
- edge_overshoot: 0.55
- safety_extension: [2.6, 2.6, 1.8]
