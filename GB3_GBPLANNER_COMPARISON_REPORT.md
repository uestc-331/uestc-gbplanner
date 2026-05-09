# GB3 与 gbplanner 探索链路对比及回接报告

生成日期：2026-05-07  
当前仓库：`/home/uestc/csj/uestc-gb3`  
参考仓库：`/home/uestc/csj/uestc-gbplanner`

## 1. 结论摘要

本次对 `uestc-gb3` 与参考 `uestc-gbplanner` 做了横向对比，并将 GB3 的 `rmf_obelix` 仿真探索链路接回到当前工程内可编译、可解析、可监测的状态。

已完成的核心结果：

- `gbplanner`、`pci_general`、`planner_control_interface`、`map_manager`、`voxblox`、`sim_tools`、`uav_control`、`px4ctrl` 相关接口已按当前 GB3 路径重新闭合。
- 新增 `rmf_sim.launch`、`rmf_obelix` 配置、Livox frame 修正节点、odom-to-TF 节点，恢复 README1 中的仿真启动链路。
- `sim_tools/traj_server_node` 作为唯一默认 `/position_cmd` 发布者，`uav_control/setup.launch` 默认关闭自身 `/position_cmd` 发布，避免控制指令抢占。
- 补齐 active `quadrotor_msgs` 与源码级 `grid_map` 依赖，使当前 workspace 不再依赖参考仓库 devel 缓存。
- 新增 `scripts/gb3_env.bash`，显式加载当前 workspace、PX4 package、`mavlink_sitl_gazebo` 和 Gazebo 插件路径。
- 对当前 PX4 探索链路不需要、且本机缺系统依赖的可选包加 `CATKIN_IGNORE`：`grid_map_costmap_2d`、`smb_gazebo`、`smb_opc`、`smb_simulator`、`rotors_simulator`。
- 修复 exploration 中若干运行时逻辑风险：planner trigger mode 调用、`kRepositioning` 路径类型、`cam_pitch` 空消息保护、RRG homing 时间代价优先级、volumetric gain 除零保护。
- 新增静态和运行时监测脚本：`scripts/gb3_static_check.sh`、`scripts/gb3_runtime_check.sh`。

## 2. 子代理分工

- exploration 子代理：定位 GB3 与参考仓库在 `gbplanner`、BT 服务、PCI 接口、RRG 逻辑中的差异。
- mapping/misc/sim 子代理：定位 active `quadrotor_msgs` 缺失、voxblox 点云 frame 合约、sim 控制链路差异。
- 启动链路子代理：梳理 `README1.md` 中的启动流程，确认 `rmf_sim.launch` 及 helper 节点缺口。
- 依赖补齐子代理：在 `src/mapping/grid_map` 加入 ROS1 Noetic 兼容的 `grid_map` 源码包，解决无 sudo 环境下 `grid_map_core/grid_map_ros/grid_map_msgs/grid_map_filters` 缺失导致的 `gbplanner` 编译失败。

## 3. 模块差异

### 3.1 exploration

共同点：

- 两边均保留 `gbplanner`、`planner_common`、`planner_control_interface`、`planner_msgs`、`planner_semantic_msgs`、`pci_general`、`kdtree`、`adaptive_obb`。
- 核心规划链路仍是 odometry/pointcloud -> `gbplanner_node` -> planner service -> `pci_general_ros_node` -> trajectory。

GB3 主要差异：

- `gbplanner` 使用 C++17，并加入 `BehaviorTree.CPP`、`gbplanner_ros.cpp`、`gbplanner_bt_nodes.cpp`。
- GB3 中主规划服务使用 `gbplanner_ros`，homing 暂保留 `gbplanner/homing`，因为 `gbplanner_ros_homing` 当前只设置 `homing_required`，未完整回填 `res.path`。
- GB3 场景 launch 更偏 GZ/GZC，topic 常见 `/rmf_obelix/velodyne_points` 或 `/input_pointcloud`；本次恢复的 `rmf_sim.launch` 使用参考链路的 `/livox/lidar -> /livox/lidar_fixed`。

已修复逻辑：

- `planner_control_interface` 在 `runPlanner` 中恢复 `planner_set_trigger_mode_client_` 调用，失败时给出 warning。
- `planner_control_interface` 将 `planner_msgs::planner_srv::Response::kRepositioning` 映射为全局路径执行类型。
- `pci_general` 与 `gbplanner/Rrg` 的 `cam_pitch` 默认初始化为 `0.0`，并对空 `sensor_msgs/JointState.position` 做节流 warning 和早返回。
- `Rrg` 中 `time_to_target + auto_homing_enable ? time_to_home : 0` 的优先级错误已全部改为 `time_to_target + (auto_homing_enable ? time_to_home : 0.0)`。
- `Rrg` volumetric gain 在 `num_ray_endpoints <= 0` 时早返回并输出节流 warning，避免除零。

### 3.2 mapping

共同点：

- 两边 mapping 主体均为 `voxblox`，包括 `voxblox`、`voxblox_ros`、`voxblox_msgs`。

GB3 主要差异：

- GB3 现在额外加入 `src/mapping/grid_map`，用于满足 `Rrg` 中 elevation map 相关 include 与 callback。
- `rmf_sim.launch` 中 `gbplanner_node` 将 `/pointcloud` remap 到 `/livox/lidar_fixed`。
- 新增 `pointcloud_frame_fixer_node` 将 `/livox/lidar` 的 `header.frame_id` 修正为 `rmf_obelix/rmf_obelix/velodyne`，保证 voxblox/TF 链路可查。

### 3.3 misc

共同点：

- 两边都使用 `catkin_simple`、`eigen_catkin`、`eigen_checks`、`gflags_catkin`、`glog_catkin`、`minkindr`、`protobuf_catkin` 等基础包。

GB3 主要差异：

- GB3 包含更多模拟和 GZ/GZC 相关依赖，例如 `behaviortree_cpp`、`kindr`、`numpy_eigen` 等。
- 参考仓库有 `yaml_cpp_catkin` 和 `gbplanner_ros` metapackage，GB3 当前不依赖它们完成 `rmf_sim.launch` 启动链路。
- 之前 `build/devel` 曾混入参考仓库路径，已执行清理重建；当前检查未发现 GB3 build cache 中残留 `/home/uestc/csj/uestc-gbplanner`。

### 3.4 sim

共同点：

- 两边都需要 `sim_tools`、`px4ctrl`、`uav_control`、`quadrotor_msgs` 参与 PX4 仿真控制链路。

GB3 主要差异：

- GB3 仿真栈更大，含 RotorS、SMB、GZ/GZC、subt cave 等多套仿真入口。
- 当前 active `quadrotor_msgs` 位于 `src/sim/quadrotor_msgs`；`src/utils/quadrotor_msgs` 仍是 `CATKIN_IGNORE` 副本。
- `traj_server_node` 在 GB3 中由 `sim_tools` 构建，不在 `gbplanner` 包中重复构建。

## 4. 回接后的启动链路

按 `README1.md` 更新后的 6 终端流程：

1. `roslaunch px4 floor5.launch` 或 `roslaunch px4 pipe.launch`
2. `roslaunch sim_tools get_real_pose.launch`
3. `roslaunch sim_tools sim_remote.launch`
4. `roslaunch px4ctrl run_ctrl.launch`
5. `roslaunch uav_control setup.launch`
6. `roslaunch gbplanner rmf_sim.launch`

关键 ROS graph 合约：

- `/vins_fusion/imu_propagate` -> `odom_to_tf_node`、`odo_throttler`
- `/livox/lidar` -> `pointcloud_frame_fixer_node` -> `/livox/lidar_fixed`
- `/livox/lidar_fixed` -> `gbplanner_node` 的 `/pointcloud`
- `gbplanner_node` service `gbplanner_ros` -> `pci_general_ros_node`
- `pci_general_ros_node` -> `/rmf_obelix/command/trajectory`
- `sim_tools/traj_server_node` -> `/position_cmd`
- `px4ctrl_node` 订阅 `/position_cmd`

## 5. 新增和修改的关键文件

- `src/exploration/gbplanner_ros/gbplanner/launch/rmf/rmf_sim.launch`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_sim_config.yaml`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/voxblox_sim_config.yaml`
- `src/exploration/gbplanner_ros/gbplanner/src/odom_to_tf_node.cpp`
- `src/exploration/gbplanner_ros/gbplanner/src/pointcloud_frame_fixer_node.cpp`
- `src/exploration/gbplanner_ros/gbplanner/CMakeLists.txt`
- `src/exploration/gbplanner_ros/gbplanner/package.xml`
- `src/exploration/gbplanner_ros/gbplanner/src/rrg.cpp`
- `src/exploration/gbplanner_ros/gbplanner/include/gbplanner/rrg.h`
- `src/exploration/gbplanner_ros/planner_control_interface/src/planner_control_interface.cpp`
- `src/exploration/pci_general/src/pci_general.cpp`
- `src/exploration/pci_general/include/pci_general/pci_general.h`
- `src/sim/quadrotor_msgs`
- `src/sim_tools/CMakeLists.txt`
- `src/sim_tools/package.xml`
- `src/uav_control/src/search_travel_task.cpp`
- `src/uav_control/src/search_travel_task.hpp`
- `src/uav_control/launch/setup.launch`
- `src/mapping/grid_map`
- `README1.md`
- `scripts/gb3_static_check.sh`
- `scripts/gb3_runtime_check.sh`
- `scripts/gb3_env.bash`

## 6. 验证记录

已通过：

- `catkin build --summarize`
  - 结果：All 78 packages succeeded；Failed: No packages failed；Abandoned: No packages were abandoned。3 个 warning 来自 `grid_map_demos`、`rotors_gazebo`、`rotors_gazebo_plugins`。
- `catkin build quadrotor_msgs sim_tools px4ctrl uav_control planner_common map_manager planner_control_interface pci_general gbplanner --summarize`
  - 结果：最初因 `grid_map_core` 缺失失败；补齐 `src/mapping/grid_map` 后目标链路可构建。
- `catkin build uav_control sim_tools gbplanner --summarize`
  - 结果：All 28 packages succeeded；`uav_control` 仅有既有 `NULL used in arithmetic` warning。
- `catkin build gbplanner --summarize`
  - 结果：All 24 packages succeeded；`gbplanner` 仅有既有 unused/reorder/format warning。
- `rospack find gbplanner`
  - 结果：`/home/uestc/csj/uestc-gb3/src/exploration/gbplanner_ros/gbplanner`
- `rospack find quadrotor_msgs`
  - 结果：`/home/uestc/csj/uestc-gb3/src/sim/quadrotor_msgs`
- `rospack find grid_map_core`
  - 结果：`/home/uestc/csj/uestc-gb3/src/mapping/grid_map/grid_map_core`
- `roslaunch gbplanner rmf_sim.launch --nodes`
  - 结果：解析出 `/gbplanner_node`、`/pci_general_ros_node`、`/traj_server_node`、`/pointcloud_frame_fixer_node`、`/odom_to_tf_node` 等节点。
- `roslaunch gbplanner rmf_sim.launch --args /gbplanner_node`
  - 结果：`odometry:=rmf_obelix/ground_truth/odometry_throttled`，`/pointcloud:=/livox/lidar_fixed`。
- `roslaunch gbplanner rmf_sim.launch --args /pci_general_ros_node`
  - 结果：`planner_server:=gbplanner_ros`，`planner_homing_server:=gbplanner/homing`，`command/trajectory:=rmf_obelix/command/trajectory`。
- `roslaunch gbplanner rmf_sim.launch --args /traj_server_node`
  - 结果：使用当前 workspace 的 `devel/.private/sim_tools/lib/sim_tools/traj_server_node`。
- `source scripts/gb3_env.bash && roslaunch px4 pipe.launch --ros-args`
  - 结果：可解析，world 指向 `/home/uestc/PX4_Firmware/Tools/sitl_gazebo/worlds/pipe_test_1.world`。
- `source scripts/gb3_env.bash && roslaunch px4 floor5.launch --ros-args`
  - 结果：可解析，world 指向 `/home/uestc/PX4_Firmware/Tools/sitl_gazebo/worlds/floor5.world`。
- `roslaunch uav_control setup.launch --dump-params`
  - 结果：`/uav_control_node/publish_position_cmd: false`。
- `scripts/gb3_static_check.sh`
  - 结果：0 FATAL，5 WARN。warning 内容为 ignored `quadrotor_msgs` 副本、可选 `gbplanner_ros/rmf_real_robot.launch/yaml_cpp_catkin` 差异、GB3 额外仿真/grid_map 包。
- `scripts/gb3_runtime_check.sh`
  - 当前未启动 ROS master，按预期输出 `ROS master is not reachable` 并退出 2。

## 7. 剩余风险

- `rmf_real_robot.launch` 未移植；本次目标是 README1 中的仿真链路。
- `uav_control` 中仍有既有 warning：`visual_odom_.pose.pose.position.x != NULL`，建议后续改为显式 odom 接收标志。
- `gbplanner` 中存在大量既有 unused/reorder/format warning，当前未纳入本次功能回接范围。
- `/position_cmd` 已在 `setup.launch` 默认避免冲突；如果用户手工将 `publish_position_cmd:=true`，仍需确保不要同时启动 `traj_server_node`。
- runtime 检查需要完整启动 6 终端流程后执行，当前只验证了 launch 解析和构建。

## 8. 后续改进方案

1. `scripts/gb3_runtime_check.sh` 已增加 profile 参数：`rmf_sim`、`xtdrone`，分别检查旧 RMF 链路和当前 XTDrone 链路；后续还可以继续扩展 `gzc_uav`、`ugv`。
2. 将 `uav_control` 的 odom 有效性从 `!= NULL` 改为 `has_visual_odom_` 布尔标志，并补充 topic 超时 warning。
3. 将 `rmf_sim.launch` 的 lidar frame、base frame、trajectory topic 全部参数化，减少硬编码 `rmf_obelix` 的位置。
4. 为 `traj_server_node` 增加轨迹超时保护：长时间无新 trajectory 时发布 hover/hold 或停止发布，并在 runtime 脚本中检查 trajectory age。
5. 后续若需要实机链路，再单独移植并验证 `rmf_real_robot.launch`，避免与当前仿真默认链路混杂。

当前如果跑的是 XTDrone 方形环境，建议直接用：

```bash
scripts/gb3_runtime_check.sh --profile xtdrone
```

## 9. 当前数据链路检查

这次对“环境关闭后 RViz 为空”的问题，静态链路核查结论如下：

- 数据链路本身是闭合的：
  `/gazebo/model_states` -> `/vins_fusion/imu_propagate` -> `odom_to_tf_node` / `odo_throttler`
  -> `/livox/lidar` -> `pointcloud_frame_fixer_node` -> `/livox/lidar_fixed`
  -> `gbplanner_node` -> `pci_general_ros_node` -> `/rmf_obelix/command/trajectory` -> `/position_cmd`
- 真正影响 RViz 的两个点是：
  - `voxblox_sim_config.yaml` 里 `update_mesh_every_n_sec` 之前被设成 `0`，导致 `/gbplanner_node/surface_pointcloud`、`/gbplanner_node/tsdf_pointcloud`、`/gbplanner_node/occupied_nodes` 不会自动刷新。
  - `pointcloud_frame_fixer_node` 默认保留 Gazebo 点云时间戳，而 `voxblox` 的 TF 路径在 `use_tf_transforms: True` 时不使用 `timestamp_tolerance_sec`，容易触发毫秒级 extrapolation。
- 已回补的最小修复：
  - `rmf_sim.launch` 新增 `update_lidar_stamp_to_now:=true`
  - `pointcloud_frame_fixer_node` 通过参数把 stamp 改成当前仿真时间
  - `voxblox_sim_config.yaml` 恢复 `update_mesh_every_n_sec: 1.0`
- 现在 `scripts/gb3_runtime_check.sh` 会额外检查：
  - `/gbplanner_node/surface_pointcloud`
  - `/gbplanner_node/tsdf_pointcloud`
  - `/gbplanner_node/occupied_nodes`
  - `/gbplanner_ros`、`/gbplanner/homing`
  - `world -> rmf_obelix/base_link` 和 `world -> rmf_obelix/rmf_obelix/velodyne`

建议你重新开环境后，优先看这三个话题是否开始有频率：

```bash
rostopic hz /gbplanner_node/surface_pointcloud
rostopic hz /gbplanner_node/tsdf_pointcloud
rostopic hz /gbplanner_node/occupied_nodes
```

## 10. Bag 数据链路复盘

针对 `/home/uestc/csj/uestc-gb3/2026-05-07-16-42-27.bag` 的复盘结论：

- `/livox/lidar` 和 `/livox/lidar_fixed` 数量一致，都是 770 条，没有在点云修正链路里丢包。
- raw lidar 的 `frame_id` 是 `world`，但点云质心始终贴近机体附近，说明这是“坐标数据本身是局部的、frame 标记不对”的场景，`pointcloud_frame_fixer_node` 只改 `frame_id` 的做法是对的。
- `/vins_fusion/imu_propagate`、`/rmf_obelix/ground_truth/odometry_throttled`、`/gbplanner_status`、`/rmf_obelix/command/trajectory` 都有稳定消息流，planner 主链路是闭合的。
- `gbplanner_status` 在 `False/True` 间切换，且 `planning_failed` 事件与 `No feasible path was found` 对齐，说明问题不在“planner 没收到数据”，而在“planner 算出的路径很短、很快就被再次触发”。
- bag 中的有效 trajectory 多数是 0.25m 到 0.56m 量级，原 PCI 配置的 `path_end_dist_thr: 2.4`、`path_progression_dist_thr: 13.2` 会把短路径几乎立即判定为完成；已将 `rmf_obelix` PCI 距离/姿态阈值收敛到短路径尺度。
- bag 里有明显的 `TF_REPEATED_DATA`，重点是 `world -> rmf_obelix/base_link`，这会污染 TF 监控和 map 更新节奏，建议后续把 TF 发布去重。

## 11. 原始 gbplanner3 对照后的规划问题

这次对照 `https://github.com/ntnu-arl/gbplanner_ros/tree/gbplanner3` 后，规划侧最关键的问题已经比较清楚了：

- 当前 `gb3` 的 `PlanningParams` 与原项目不一致，少了 `path_history_penalty`、`path_history_size`、`path_history_decay_time`、`path_reverse_hard_filter`、`path_reverse_dot_threshold`、`min_gain_threshold`、`min_path_length`、`min_unknown_voxels_per_meter` 这组直接抑制抖动和短跳的参数。
- 当前 `gbplanner/src/rrg.cpp` 也没有原项目的路径历史抑制与阈值筛选逻辑，候选路径只按 `path_length_penalty + path_direction_penalty` 比较，容易把局部高增益但反向/过短/低密度的路径选出来。
- 当前 `rmf_obelix` 配置比原项目激进很多，尤其是 `v_max`、`yaw_rate_max`、`edge_length_max`、`nearest_range`、`safety_extension`、`free_frustum_before_planning`、`leafs_only_for_volumetric_gain`、`cluster_vertices_for_gain`、`nonuniform_ray_cast` 这几项，都会把规划器推向更快但更不稳的路径。

我已经把这三块补回来了：

- `planner_common/include/planner_common/params.h`
- `planner_common/src/params.cpp`
- `gbplanner/include/gbplanner/rrg.h`
- `gbplanner/src/rrg.cpp`
- `gbplanner/config/rmf_obelix/gbplanner_config.yaml`

现在 `gbplanner` 已经可以编译通过，静态检查也回到 `0 FATAL`。下一步如果你要继续盯“乱飞乱撞”，重点看 `PathRank` 日志里到底是哪个阈值把路径挡住了，或者哪条 accepted path 的方向历史还在反复撞回头路。

## 12. 狭窄管道撞墙专项修复

本轮针对“gbplanner 在原工程正常、GB3 在狭窄管道乱撞”的现象，重新对照了参考工程和 bag 数据。结论是：控制链路不是主因，规划链路是主因；bag 里 `/gbplanner_path` 与 `/rmf_obelix/command/trajectory` 一致，说明 planner 输出被按原样执行了。

关键问题：

- GB3 的 `rmf_obelix/voxblox_sim_config.yaml` 比参考工程更粗：`tsdf_voxel_size` 为 `0.40`，参考工程为 `0.20`；`truncation_distance` 为 `0.8`，参考为 `0.6`；`max_weight` 为 `50`，参考为 `200`。这会让窄管道壁面和边界距离场更容易被抹平或不稳定。
- `Rrg::reset()` 中单点/半径式碰撞检查的机器人半径用的是 `robot_box_size_.maxCoeff() / 2.0`，参考工程用 `robot_box_size_.norm() / 2.0`。当前默认 `line_check_method: 1` 时这不是主路径检查的唯一入口，但它会影响切换到半径式检查或辅助检查时的安全裕度。
- `getBestPathSimplified()` / `getBestPath()` 在路径经过 `improveFreePath()` 和插值后，之前没有最终硬碰撞验收；如果后处理阶段留下贴边路径，PCI 会继续执行。

已修改：

- `src/exploration/gbplanner_ros/gbplanner/src/rrg.cpp`
  - 将 `setRobotRadius()` 改为参考工程一致的外接球半径：`robot_box_size_.norm() / 2.0`。
  - 在本地规划路径返回前增加最终 `isPathCollisionFree()` 验收；不通过则返回空路径，不再把危险路径送给 PCI。
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/voxblox_sim_config.yaml`
  - 对齐参考工程管道配置：`tsdf_voxel_size: 0.20`、`max_ray_length_m: 50.0`、`truncation_distance: 0.6`、`esdf_max_distance_m: 2.0`、`max_weight: 200`。
  - 恢复 `publish_traversable: True`、`traversability_radius: 0.3`，便于后续如果启用 traversability 辅助过滤时保持参考行为。

验证：

- `catkin build planner_common map_manager gbplanner --summarize`
  - 结果：All 24 packages succeeded；`gbplanner` 仍有既有 warning，无新增编译错误。
- `scripts/gb3_static_check.sh`
  - 结果：0 FATAL，5 WARN；warning 仍是既有可选包/额外包差异。

下一步运行时建议：

```bash
roslaunch px4 pipe.launch
roslaunch gbplanner rmf_sim.launch rviz_en:=true
```

重点观察 rosout：

- 不应再出现执行前仍发送碰撞路径；如果最终验收失败，会看到 `[RRG][FINAL_PATH]`。
- `Path ACCEPTED` 后如果 `improveFreePath()` 失败，应检查是否返回空路径或触发下一轮重规划，而不是继续撞墙。
- RViz 里 `/gbplanner_node/surface_pointcloud` 和 `/gbplanner_node/occupied_nodes` 应该更细，管壁边界会比 `0.40m` 体素时清楚。

## 13. 狭窄管道短段停滞修复

这次复盘的现象不是撞墙，而是“能走一小段，但很快停住，而且没有进入探索完成态”。

关键日志特征：

- `PathRank` 中出现过 `len=0.20`、`density=1389.36` 的候选路径，但 `short_frontier=0`，随后被判成 `pass_all=0`。
- 紧接着出现 `No valid local exploration path. frontier_exists=1 pass_all=0 best_gain=0.00`。
- 说明问题不是传感器没数据，而是局部路径的长度门槛把管道里的前沿步长截断了。

根因有两处：

- `Rrg::evaluateGraph()` 里 `short_frontier_min_length` 设得太高，短于阈值的前沿步长即使密度很高也会被拒绝。
- 无参 `Gbplanner::getExplorationPath()` 在 `GraphStatus::NO_GAIN` 时返回 `L_OK`，BT 的 `LocalExpExhaustedCheck` 过不去，结果就是空路径反复发出，但不会真正切到全局/耗尽分支。

这次已做的修复：

- 将 `short_frontier_min_length` 调低为 `max(0.15, 0.5 * edge_length_min)`，让狭窄管道里 20cm 级的推进可以继续被接受。
- 将无参 `getExplorationPath()` 的 `NO_GAIN` 提升为 `L_EXHAUSTED`，让 BT 在局部没有可行路径时能正常交给后续的全局规划或耗尽逻辑。

验证结果：

- `catkin build planner_common gbplanner --summarize` 通过。
- `bash -n scripts/gb3_runtime_check.sh scripts/gb3_planner_log_check.sh scripts/gb3_static_check.sh` 通过。
- `scripts/gb3_planner_log_check.sh /home/uestc/.ros/log/429d3da6-49fa-11f1-be83-eba5423f2418/rosout.log` 仍能抓到旧日志里的非有限分数和低增益样本，说明监测脚本能定位这类问题。

后续建议：

- 如果方环管道里还是过早停，优先调 `min_gain_threshold`、`path_history_penalty` 和 `path_reverse_hard_filter`，不要再把短前沿长度门槛往上推。
- 观察新版日志里 `PathRank` 的 `len / density / pass_all`，可以直接判断是“门槛卡住了”还是“真实走到尽头了”。
