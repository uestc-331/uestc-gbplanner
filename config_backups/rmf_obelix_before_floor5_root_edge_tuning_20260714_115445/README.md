# Backup before floor5 root-edge tuning

Created: 2026-07-14 11:54:45 Asia/Shanghai

Reason:
- In floor5/open scene, planner repeatedly stalls with START_CHECK free but graph 1 vertex / 0 edges.
- Tune parameters to reduce over-conservative root-edge collision/unknown rejection.

Backed up:
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml
- src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/voxblox_sim_config.yaml
