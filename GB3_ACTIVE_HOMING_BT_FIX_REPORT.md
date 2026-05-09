# GB3 Active Homing BT Fix Report

Date: 2026-05-08 15:54 CST

Bag analyzed: `/home/uestc/csj/uestc-gb3/2026-05-08-15-31-01.bag`

## Problem Seen In The Bag

The planner had already reached a terminal exploration condition, but the system did not enter homing execution.

Key runtime pattern:

- RRG printed `global_frontiers=0`, `local_exhausted=1`, and `--> Calling HOMING instead.`
- `/gbplanner_is_homing` stayed false.
- The planner service still returned normal forward/local status, then PCI executed `path_type=LOCAL`.
- After that the vehicle kept receiving local corridor paths, including reverse-direction paths in the same corridor, producing the visible back-and-forth behavior.
- One later stuck event was also on a local path: `[PCI][EXEC][STUCK] ... path_type=0`.

Conclusion: this was not mainly a PX4/controller scheduling problem. The planning/BT response state was wrong.

## Root Cause

### 1. Homing path was calculated but its status was not propagated

`Rrg::calculateGlobalPath()` could internally decide that exploration was complete and call `getHomingPath()`, but its caller only received a vector of poses. The caller could not distinguish:

- normal global-reposition path
- terminal homing path

So `Gbplanner::calculateGlobalPath()` did not set `out_srv_res_.status = kHoming`.

### 2. Behavior Tree continued into LocalNavigation

In `config/bt_xml/lge_active.xml`, `CalculateGlobalPath` is followed by `LocalNavigation`. Before this fix, a successful homing calculation still returned BT success, so the same tick immediately entered `LocalNavigation`, which overwrote the homing response with a normal local path.

This explains the bag symptom: logs showed "Calling HOMING", but service response stayed `status=0` and `/gbplanner_is_homing` never became true.

### 3. Homing path had no final safety gate

`Rrg::getHomingPath()` modified and interpolated the return path, but did not do the same final `isPathCollisionFree()` rejection that local best-path code already had. In a narrow pipe, keeping an unsafe or unmodifiable homing path is too risky.

## Code Changes

Changed files:

- `src/exploration/gbplanner_ros/gbplanner/include/gbplanner/rrg.h`
- `src/exploration/gbplanner_ros/gbplanner/src/rrg.cpp`
- `src/exploration/gbplanner_ros/gbplanner/src/gbplanner.cpp`
- `src/exploration/gbplanner_ros/gbplanner/src/gbplanner_bt_nodes.cpp`

Changes made:

- `Rrg::calculateGlobalPath(bool& homing_engaged)` now returns a homing flag together with the path.
- `Gbplanner::calculateGlobalPath()` now sets `out_srv_res_.status = kHoming` and `out_srv_res_.path = active_global_path_` when the global planner actually produced a homing path.
- `CalculateGlobalPath::tick()` now detects `kHoming` and stops the BT branch before `LocalNavigation` can overwrite the response.
- `Rrg::getHomingPath()` now rejects a post-processed homing path if it fails collision checking.

## Expected Logs After Fix

When exploration completes, the correct chain should look like:

```text
[RRG][COMPLETE] ... --> Calling HOMING instead.
[GBPLANNER][GLOBAL] homing path ready size=N
[BT][CalculateGlobalPath] Homing path ready; skip LocalNavigation branch
GBPlanner service response status=2 path_size=N
[PCI][STATE] planner response=HOMING
```

Important negative check:

```text
[BT][LocalNavigation] Triggered
```

should not appear immediately after the same homing decision.

If homing is requested but the path is unsafe, expected log:

```text
[RRG][HOMING] Post-processed homing path failed collision check...
[GBPLANNER][GLOBAL] homing requested but no safe path was found
GBPlanner service response status=2 path_size=0
```

That means the planner is intentionally refusing to drive into an unsafe return path.

## Build Verification

Command:

```bash
catkin build gbplanner planner_control_interface pci_general --summarize
```

Result:

- All 27 required packages succeeded.
- No package failed or was abandoned.
- `gbplanner` still has existing warnings from dependency/header code, but no build-blocking errors.

## Next Runtime Check

Relaunch after rebuilding:

```bash
source devel/setup.bash
roslaunch gbplanner rmf_sim.launch rviz_en:=true
```

During the next run, verify:

```bash
rostopic echo /gbplanner_status
rostopic echo /gbplanner_is_homing
rostopic echo /rmf_obelix/command/trajectory
```

The decisive check is: once `[RRG][COMPLETE] ... Calling HOMING` appears, `/gbplanner_is_homing` should become true and the next executed path should be `HOMING`, not `LOCAL`.

## Remaining Risk

If it still hits a wall before reaching the completion condition, the next target should be map/clearance mismatch: voxel map status, robot bounding size, odometry frame alignment, and path tracking overshoot. But the specific bug from this bag, "homing decision被LocalNavigation覆盖", has been fixed.
