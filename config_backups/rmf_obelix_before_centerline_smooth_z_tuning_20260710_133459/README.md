# Backup before centerline/smooth/z tuning

Created: 2026-07-10 13:34:59 CST

Files:
- gbplanner_config.yaml
- voxblox_sim_config.yaml

Purpose:
- Increase ESDF distance range so centerline bias can distinguish true pipe center.
- Reduce upward sampling tendency that left endpoints near dirty/occupied top-side voxels.
- Make final shortcut/smoothness a bit stronger while keeping wall clearance enabled.
