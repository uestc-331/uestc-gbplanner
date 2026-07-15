# 20260709 GBPlanner 调参和远离墙体改造总结

## 今天主要目标

今天主要围绕两个问题处理：

1. 无人机在 `floor5` 仿真里离墙太近，拐弯处容易切墙甚至撞墙。
2. 无人机有时会长时间停住，日志里常见碰撞检查失败、起点不安全、empty path 等现象。

后半段已经从单纯调参进入到算法层改造：给 GBPlanner 增加 ESDF clearance-aware 逻辑，让规划器不只判断“会不会撞”，还会尽量选离墙更远的路径。

## 今日重要备份

所有关键修改前都做了备份，主要备份目录如下：

- `config_backups/rmf_obelix_before_clear_sphere_1p5_20260709/`
- `config_backups/rmf_obelix_before_reduce_wait_empty_path_20260709/`
- `config_backups/rmf_obelix_before_target_wall_safety_rebalance_20260709/`
- `config_backups/rmf_obelix_before_wall_clearance_recovery_20260709/`
- `config_backups/rmf_obelix_before_clearance_aware_planning_20260709/`

最新算法层改造前的备份在：

```bash
config_backups/rmf_obelix_before_clearance_aware_planning_20260709/
```

里面备份了：

- `params.h`
- `params.cpp`
- `rrg.h`
- `rrg.cpp`
- `gbplanner_config.yaml`
- `README.md`

## 已做的调参方向

### 1. 增大安全边界

在 `rmf_obelix/gbplanner_config.yaml` 中调整过机器人碰撞盒和安全扩展参数，让规划更保守，尽量不要贴墙：

- `size_extension_min`
- `size_extension`
- `safety_extension`
- `edge_overshoot`
- `bound_mode`

当前思路是：不要一味把碰撞盒调得过大，否则容易导致起点附近被判不安全，出现 `Starting position is not clear`、`Planner returned an empty path`，所以后面又做过一轮回收和平衡。

### 2. 减少长时间停住

针对长时间停住和反复 empty path，调整过 RRG 搜索规模和短路径脱困相关参数：

- `num_vertices_max`
- `num_edges_max`
- `num_loops_cutoff`
- `num_loops_max`
- `min_path_length`
- `clear_sphere_radius`

判断结论：慢很多时候不是单次规划本身慢，而是卡在“起点或候选路径碰撞检查失败 -> 多轮 empty path -> 等下一次可行规划”。

### 3. 处理 TF/time 干扰

之前出现过 `TF_OLD_DATA`、`TF_REPEATED_DATA`、RViz 不显示等问题。判断主要和旧 ROS/Gazebo/PX4 进程残留、仿真时间跳变、重复 TF 发布有关。

建议明天每次正式测试前先清理旧进程，再启动仿真。当前已有脚本：

```bash
scripts/kill_current_sim.bash
scripts/run_current_sim.bash
```

## 今天新增的算法功能

### 功能名

ESDF clearance-aware planning，也就是“离墙距离感知规划”。

### 核心目的

以前规划器更像是：

```text
只要不撞，就可以作为候选路径
```

现在增加为：

```text
不撞只是底线；离墙太近的候选路径会被扣分，低于硬安全距离的路径会被拒绝
```

### 新增参数

位置：

```bash
src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml
```

当前新增参数：

```yaml
wall_clearance_enable: true
wall_clearance_min: 0.55
wall_clearance_soft: 1.00
wall_clearance_penalty: 2.0
wall_clearance_sample_step: 0.30
wall_clearance_reject_final_path: true
```

参数含义：

- `wall_clearance_enable`：总开关，`false` 时回到旧逻辑。
- `wall_clearance_min`：硬安全距离，路径采样点低于这个距离会被拒绝。
- `wall_clearance_soft`：软安全距离，低于这个距离但高于 `min` 时会扣分。
- `wall_clearance_penalty`：贴墙惩罚强度，越大越不愿意选贴墙路径。
- `wall_clearance_sample_step`：沿路径采样检查 ESDF 距离的间隔。
- `wall_clearance_reject_final_path`：最终输出前再检查一次，太贴墙就返回 empty path，避免执行危险路径。

### 修改的代码文件

- `src/exploration/gbplanner_ros/planner_common/include/planner_common/params.h`
- `src/exploration/gbplanner_ros/planner_common/src/params.cpp`
- `src/exploration/gbplanner_ros/gbplanner/include/gbplanner/rrg.h`
- `src/exploration/gbplanner_ros/gbplanner/src/rrg.cpp`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml`

### 关键实现点

1. `PlanningParams` 增加了 6 个 `wall_clearance_*` 参数。
2. `Rrg::evaluateGraph()` 中对每条候选路径计算 ESDF clearance cost。
3. 候选路径增益被修改为：

```text
path_gain *= exp(-wall_clearance_penalty * clearance_cost)
```

4. 如果候选路径最小 ESDF 距离低于 `wall_clearance_min`，不参与最佳路径竞争。
5. `Rrg::getBestPath()` 和 `Rrg::getBestPathSimplified()` 最终输出路径前增加二次 clearance 检查。
6. 新增日志：

```text
[RRG][CLEARANCE] leaf=... min=... cost=... pass=... gain=...
```

## 已验证

### YAML 检查

已执行：

```bash
python3 - <<'PY'
import yaml
p='src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml'
yaml.safe_load(open(p))
print('YAML OK:', p)
PY
```

结果：通过。

### 编译检查

已执行：

```bash
catkin build planner_common gbplanner
```

结果：

```text
All 24 packages succeeded
No packages failed
```

编译有 warning，但来自已有依赖和旧代码，例如 `adaptive_obb`、`voxblox_ros`，不是这次新增功能导致的编译失败。

## 明天测试建议

### 1. 先清理旧进程

正式测试前建议先清理旧仿真进程，避免 TF/time 干扰：

```bash
cd /home/uestc/gb3/uestc-gbplanner
bash scripts/kill_current_sim.bash
```

### 2. 重新启动仿真

注意：今天编译通过后，旧的 `gbplanner_node` 不会自动变成新代码，必须重启仿真或至少重启 `gbplanner_node`。

常用启动：

```bash
cd /home/uestc/gb3/uestc-gbplanner
export ROS_MASTER_URI=http://localhost:11311
unset ROS_IP
export ROS_HOSTNAME=localhost
export PX4_FIRMWARE_ROOT=/home/uestc/PX4-Autopilot
unset PX4_BUILD_DIR
source scripts/gb3_env.bash
roslaunch gbplanner rmf_sim.launch rviz_en:=true traj_server_en:=true
```

控制：

```bash
cd /home/uestc/gb3/uestc-gbplanner
export ROS_MASTER_URI=http://localhost:11311
unset ROS_IP
export ROS_HOSTNAME=localhost
export PX4_FIRMWARE_ROOT=/home/uestc/PX4-Autopilot
unset PX4_BUILD_DIR
source scripts/gb3_env.bash
roslaunch px4ctrl run_ctrl.launch
```

### 3. 重点看这些日志

```text
[RRG][CLEARANCE]
Starting position is not clear
Current box contains Occupied voxels
Planner returned an empty path
Newly modified path is not collision-free
GBPlanner service response status=0 path_size=...
```

重点观察：

- `[RRG][CLEARANCE]` 里的 `min` 是否大多数高于 `0.55`。
- `pass=0` 是否特别多。
- `Planner returned an empty path` 是否明显增加。
- 粉色执行路径是否还贴墙或穿墙。
- 无人机转弯处是否仍然切墙。

## 明天优先调参顺序

### 情况 A：离墙明显改善，但 empty path 变多

优先把硬安全距离稍微降低：

```yaml
wall_clearance_min: 0.45
```

先不要直接关闭 `wall_clearance_enable`。

### 情况 B：还是贴墙

可以加大软惩罚，不一定先加硬阈值：

```yaml
wall_clearance_soft: 1.20
wall_clearance_penalty: 3.0
```

这样会更偏向离墙远的候选路径，但不会像提高 `wall_clearance_min` 那样直接拒绝太多路径。

### 情况 C：规划太慢

先观察是否因为 `[RRG][CLEARANCE] pass=0` 太多导致可行路径少。如果是，可先降低：

```yaml
wall_clearance_min: 0.45
```

如果不是 clearance 导致，再回到 RRG 搜索规模参数：

- `num_vertices_max`
- `num_edges_max`
- `num_loops_cutoff`
- `num_loops_max`

### 情况 D：想做对照实验

直接关掉新功能：

```yaml
wall_clearance_enable: false
```

然后重启 `gbplanner_node`，行为应基本回到旧逻辑。

## 当前判断

单纯调大碰撞盒会让无人机更保守，但也容易把起点和窄处判成不可行，导致停住。今天新增的 clearance-aware planning 更像是在“路径选择层”远离墙体，不完全依赖把碰撞盒调大，因此更适合后续继续精调。

明天建议先不要同时大改很多参数。优先围绕 `wall_clearance_min`、`wall_clearance_soft`、`wall_clearance_penalty` 做小步对照。
