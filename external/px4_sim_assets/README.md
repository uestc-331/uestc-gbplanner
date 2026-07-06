# PX4 Simulation Assets

This directory vendors the small custom PX4/Gazebo files needed by the GBPlanner simulation.

It contains:

- `launch/`: custom PX4 launch files such as `floor5.launch`, `pipe.launch`, and `pipeline_xyq.launch`.
- `worlds/`: custom Gazebo worlds used by those launch files.
- `models/`: custom Gazebo models referenced by the worlds and the `iris_csj` vehicle SDF.

On a new machine, first install/build PX4 normally, then sync these files into the PX4 tree:

```bash
cd ~/uestc-gbplanner
PX4_FIRMWARE_ROOT=~/PX4_Firmware bash scripts/sync_px4_sim_assets.bash
```

If `PX4_FIRMWARE_ROOT` is not set, the script defaults to `/home/uestc/PX4_Firmware`.
