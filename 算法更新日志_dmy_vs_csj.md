# 算法更新日志：dmy/uestc-gbplanner 相比 csj/uestc-gb3

## 总体结论

`dmy/uestc-gbplanner` 相比 `csj/uestc-gb3`，主要不是重写核心探索框架，而是在原 GBPlanner/RRG 基础上做了面向管道、低空、实机运行的安全约束和工程闭环增强。

核心变化集中在：

- RRG 路径规划增加全局边界硬约束，防止路径平滑、全局规划、返航路径越过设定空间边界。
- Planner Control Interface 增加话题命令入口，支持终端/轻量 UI 直接触发开始、停止、返航、单次规划、初始化运动。
- 里程预算返航逻辑更严格，只在真正执行自动局部探索路径时累计里程，并改为 XY 平面距离累计。
- 实机点云链路新增点云坐标转换节点，支持 TF 坐标变换、最新 TF fallback，以及可选虚拟 Z 边界点。
- 配置参数调整为更保守的管道/低空场景：全局范围更小、局部 Z 采样更窄、速度/加速度更低、Voxblox 建图范围更短。
- 新增 CLI/topic UI，方便无 RViz 或远程终端下操作规划器。

## 1. RRG 路径安全约束增强

相关文件：

- `src/exploration/gbplanner_ros/gbplanner/src/rrg.cpp`
- `src/exploration/gbplanner_ros/gbplanner/include/gbplanner/rrg.h`
- `src/exploration/gbplanner_ros/planner_common/include/planner_common/params.h`
- `src/exploration/gbplanner_ros/planner_common/src/params.cpp`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml`

新增参数：

```yaml
PlanningParams:
  enforce_global_bounds_on_paths: true
```

新增能力：

- 新增 `isPointInsideGlobalPlanningBounds()`，检查单点是否在全局规划边界内。
- 新增 `isSegmentInsideGlobalPlanningBounds()`，检查路径段首尾是否在全局规划边界内。
- 新增 `isPathInsideGlobalPlanningBounds()`，检查整条路径是否在全局规划边界内。
- 检查时会按机器人尺寸缩小可行边界，相当于给机体体积留出安全余量。
- `isPathCollisionFree()` 增加日志上下文，失败时能打印是未知、占据、越界还是某段路径不可行。

影响的规划流程：

- Homing 返航路径：后处理路径失败后会尝试 raw homing path，仍失败则进入 emergency fallback。
- `improveFreePath()` 路径平滑/修正：输入、候选边、输出都会检查全局边界。
- `calculateGlobalPath()` 全局路径结果：最终路径越界会清空并返回失败。
- `runGlobalPlanner()` 全局前沿路径：最终路径越界会清空并返回失败。

实际效果：

- 防止路径后处理把轨迹改到全局边界外。
- 防止管道/低空场景中路径突然越过限高、限宽。
- 出问题时日志更容易定位，例如会输出 `[RRG][GLOBAL_BOUND]` 和 `[RRG][PATH_CHECK]`。

## 2. 管道/低空场景参数重调

相关文件：

- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml`

主要变化：

```yaml
BoundedSpaceParams:
  Global:
    min_val: [-1.0, -12.0, -1.0]
    max_val: [20.0, 1.0, 1.4]
  Local:
    min_val: [-7.5, -7.5, -0.25]
    max_val: [7.5, 7.5, 0.25]
    min_extension: [-5.0, -5.0, 0.0]
    max_extension: [5.0, 5.0, 0.0]
```

相比旧版本：

- 旧版本全局范围较大：`[-1, -60, -1]` 到 `[30, 60, 3]`。
- 新版本全局范围收紧到更像管道/走廊任务的区域。
- 局部 Z 采样从大范围上下搜索改为只在当前高度上下 `0.25m` 内采样。
- Z 方向 extension 设为 `0.0`，避免局部规划额外向上/向下扩展。

RRG 搜索规模变化：

```yaml
edge_length_max: 0.8
num_vertices_max: 200
num_edges_max: 2000
num_loops_cutoff: 500
num_loops_max: 600
path_interpolation_distance: 0.4
```

相比旧版本：

- `edge_length_max` 从 `1.0` 降到 `0.8`，路径边更短。
- 最大顶点数从 `500` 降到 `200`。
- 最大边数从 `7000` 降到 `2000`。
- 最大采样循环从 `3000` 降到 `600`。
- 插值间距从 `0.5` 降到 `0.4`。

实际效果：

- 搜索更轻，适合局部狭窄空间。
- 路径点更密一些，执行连续性更好。
- 规划更保守，但探索范围和搜索充分性低于旧版本。

## 3. Planner Control Interface 执行逻辑增强

相关文件：

- `src/exploration/gbplanner_ros/planner_control_interface/src/planner_control_interface.cpp`
- `src/exploration/gbplanner_ros/planner_control_interface/include/planner_control_interface/planner_control_interface.h`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_sim_config.yaml`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_real_config.yaml`

新增话题命令：

```text
/gbplanner_ui/cmd/start_planner
/gbplanner_ui/cmd/stop_planner
/gbplanner_ui/cmd/homing
/gbplanner_ui/cmd/start_planner_single
/gbplanner_ui/cmd/init_motion
```

这些话题会在 PCI 内部转成原有 service 调用，因此可以不用 RViz 面板，直接通过 topic/CLI 控制规划器。

新增/调整的执行逻辑：

- 自动探索路径真正开始执行后，才激活里程预算统计。
- 停止、返航、重新触发规划时，会重置里程预算状态。
- 里程统计从三维距离改为 XY 平面距离，避免高度抖动影响累计里程。
- odom 跳变过滤改为 XY 距离过滤。
- 达到里程预算后，自动停止探索并触发 homing。

关键参数变化：

```yaml
distance_budget_enable: true
distance_budget_max_step: 1.0
distance_budget_min_step: 0.08
```

实机配置：

```yaml
distance_budget_limit: 28.0
```

仿真配置：

```yaml
distance_budget_limit: 100.0
```

执行轨迹动力学从旧版本更激进的参数改为更柔和：

```yaml
RobotDynamics:
  v_max: 0.6
  v_init_max: 0.5
  v_homing_max: 0.5
  yaw_rate_max: 0.1
  dt: 0.05
  a_max: 1.5
```

相比旧版本：

- 旧版本 `v_max/v_init_max/v_homing_max` 多为 `1.0`。
- 旧版本 `a_max` 为 `4.0`。
- 新版本速度和加速度更低，更适合实机、低空、狭窄环境。

## 4. 实机点云与 TF 适配增强

相关文件：

- `src/exploration/gbplanner_ros/gbplanner/src/pointcloud_real_robot_converter_node.cpp`
- `src/exploration/gbplanner_ros/gbplanner/CMakeLists.txt`
- `src/exploration/gbplanner_ros/gbplanner/launch/rmf/rmf_real.launch`
- `src/exploration/gbplanner_ros/gbplanner/launch/rmf/rmf_real_topic_ui.launch`

新增节点：

```text
pointcloud_real_robot_converter_node
```

新增能力：

- 订阅原始点云，例如 `/cloud_registered_360`。
- 输出规划器使用的点云，例如 `/cloud_registered_fixed`。
- 支持按 TF 对点云做真实坐标变换，而不是只改 `frame_id`。
- 支持 TF 查找失败时使用最新 TF fallback。
- 支持可选 `simple_mode`，只改 frame id。
- 支持可选虚拟 Z 上/下边界点，用点云方式给地图补 Z 边界。

launch 中的实机链路变化：

- 默认 `fix_pointcloud_frame=true`。
- 规划器点云从 `/cloud_registered_360` 改为 `/cloud_registered_fixed`。
- lidar frame 改为 `rmf_obelix/rmf_obelix/velodyne`。
- 增加 `world/camera_init/base_link/velodyne` 等静态 TF。
- 增加 odom throttler，将高频里程计节流后给规划器使用。

注意：

- `virtual_z_walls_enable` 在实机 launch 中默认是 `false`。
- 原因是 Voxblox 会对点云 ray-carve，虚拟墙点可能擦除真实侧壁。
- 当前主要通过 RRG 的 `enforce_global_bounds_on_paths` 来限制路径越界。

## 5. odom_to_tf 发布策略调整

相关文件：

- `src/exploration/gbplanner_ros/gbplanner/src/odom_to_tf_node.cpp`

变化：

- 删除了“时间戳不递增就不发布 TF”的限制。
- 每次收到/定时发布时都会广播当前 odom 对应 TF。

实际效果：

- 对 VINS、仿真桥接、时间戳抖动更宽容。
- 减少 TF 因时间戳不严格递增而停止更新的情况。

## 6. 新增终端/话题 UI

相关文件：

- `src/exploration/gbplanner_ros/gbplanner_ui/src/gbplanner_cli.cpp`
- `src/exploration/gbplanner_ros/gbplanner_ui/src/gbplanner_simple_topic_ui.cpp`
- `src/exploration/gbplanner_ros/gbplanner_ui/CMakeLists.txt`

新增可执行程序：

```text
gbplanner_cli
gbplanner_simple_topic_ui
```

功能：

- `gbplanner_cli`：菜单式终端控制，支持开始、停止、返航、初始化、去 waypoint、global planner、operation mode 切换。
- `gbplanner_simple_topic_ui`：按键式轻量控制，支持开始、停止、返航、单次规划、初始化。

实际效果：

- 不依赖完整 Qt/RViz UI 也能控制规划器。
- 适合 SSH 远程调试、实机飞行前快速触发。

## 7. Voxblox 建图参数调整

相关文件：

- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/voxblox_sim_config.yaml`

主要变化：

```yaml
max_ray_length_m: 15.0
method: "simple"
pointcloud_queue_size: 5
publish_traversable: false
publish_tsdf_map: false
publish_esdf_map: false
max_weight: 100
clearing_ray_weight_factor: 0.5
min_ray_length_m: 0.3
occupancy_min_distance_voxel_size_factor: 0.8
occupancy_distance_voxelsize_factor: 0.8
```

相比旧版本：

- 最大 ray 长度从 `50m` 降到 `15m`。
- 积分方式从 `fast` 改为 `simple`。
- 点云队列从 `1000` 降到 `5`。
- 关闭 TSDF/ESDF map 发布，减少通信和计算负担。
- clearing 权重提高，地图清理更积极。

实际效果：

- 更适合近距离、狭窄空间、实时运行。
- 降低远距离点云对建图和规划的影响。
- 减少大地图发布带来的负载。

## 8. 行为树日志小调整

相关文件：

- `src/exploration/gbplanner_ros/gbplanner/src/gbplanner_bt_nodes.cpp`

变化：

- Homing 成功日志从 `ROS_WARN` 改为 `ROS_ERROR`。

说明：

- 这不是算法逻辑变化，只是日志等级变化。
- 从语义上看，成功事件用 `ROS_ERROR` 并不常规，后续可以考虑改回 `ROS_INFO` 或 `ROS_WARN`。

## 9. 未变化或非核心变化

确认没有核心源码差异的模块：

- `src/exploration/adaptive_obb_ros`
- `src/exploration/gbplanner_ros/map_manager`

因此，本次 dmy 版本相对 csj 版本的主要算法增强不在 adaptive OBB 或 map_manager，而在 RRG 路径可行性检查、PCI 执行逻辑、点云/TF 输入链路和参数策略。

非算法但相关的工程变化：

- `rotors_gazebo/CMakeLists.txt` 做过编译修复，解决 `iris.sdf` 生成时找不到 `component_snippets.xacro` 和旧 xacro 不支持 `$(find ...)` 的问题。
- `scripts/gb3_env.bash` 改为自动指向当前工作空间，并注册 `/home/uestc/PX4_Firmware`，支持在 `/home/uestc/dmy/uestc-gbplanner` 下直接运行 PX4 launch。

## 10. 风险与注意事项

- 全局边界硬约束开启后，边界设置过小会导致规划器找不到路径或返航失败，需要确保 `BoundedSpaceParams/Global` 覆盖真实可飞区域。
- 局部 Z 范围变窄后，探索会更保守，适合管道/低空；如果任务需要明显爬升或下降，需要放宽 `Local/min_val.z` 和 `Local/max_val.z`。
- 搜索规模降低后规划更快，但在复杂环境中可能牺牲路径质量或探索充分性。
- 里程预算采用 XY 距离累计，更适合平面管道/走廊任务；如果任务高度变化大，需要重新评估返航触发距离。
- 点云转换依赖 TF 树完整性，实机启动时需要确认 `world/camera_init/base_link/velodyne` 等 frame 连通。

## 11. 一句话版本

`dmy/uestc-gbplanner` 是在 `csj/uestc-gb3` 基础上面向管道实机任务做的安全增强版：它收紧规划空间、降低执行速度、增加路径越界硬约束、优化里程返航逻辑、补齐点云/TF 实机适配，并提供了更方便的终端话题控制入口。
