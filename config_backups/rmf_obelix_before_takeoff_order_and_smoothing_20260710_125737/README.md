# Backup Before Takeoff Order And Smoothing 20260710 125737

This backup was created before changing the simulation takeoff order and path smoothing parameters.

Backed up files:
- `src/px4ctrl/config/ctrl_param_fpv.yaml`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_sim_config.yaml`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml`

Intent of the following edit:
- Let `px4ctrl` perform auto takeoff to a cleaner planning height before GBPlanner/PCI sends command trajectories.
- Disable PCI init motion so it does not publish `/position_cmd` before `px4ctrl` enters `AUTO_TAKEOFF`.
- Increase centerline and smoothing bias to reduce wall hugging and winding RRG paths.
