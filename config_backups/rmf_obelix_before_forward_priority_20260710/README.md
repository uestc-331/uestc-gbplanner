# rmf_obelix_before_forward_priority_20260710

Backup before implementing forward-priority exploration and delayed branch/global planning.

Files backed up:

- `params.h`
- `params.cpp`
- `rrg.h`
- `rrg.cpp`
- `gbplanner_config.yaml`

Intent:

- Keep previous wall-clearance safety behavior.
- Add history-direction based forward exploration preference.
- Delay global branch exploration until forward local candidates are exhausted.
