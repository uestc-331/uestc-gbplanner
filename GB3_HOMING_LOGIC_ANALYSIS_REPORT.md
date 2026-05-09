# GB3 返航判断逻辑整理与距离强制返航设计

更新时间：2026-05-09

## 1. 当前结论

当前 GBPlanner3 的自动返航不是一个独立后台定时器触发的功能。返航判断发生在 planner service 被 PCI 调用后，行为树每 tick 一次时执行：

```text
planner_control_interface
  -> planner service
    -> gbplanner_node
      -> MainTree tickOnce()
        -> HomingCheck
          -> Gbplanner::homingRequired()
            -> Rrg::homingRequired()
```

因此，时间到了能不能自动返航，首先取决于 PCI 是否还在自动触发 planner。如果 PCI 因空路径、短路径、手动模式切换等原因停在 `READY + MANUAL`，那么 `HomingCheck` 不会继续被 tick，时间条件也不会继续被检查。

当前已经加过一个保护：自动模式下 planner 返回空的 terminal path 时，PCI 会保留 AUTO，让下一轮继续触发 planner，从而让 `HomingCheck` 继续有机会判断时间预算。

关键日志：

```text
[PCI][AUTO_WATCHDOG] planner returned empty auto path; keeping auto mode alive so HomingCheck/time-budget can be evaluated again
```

## 2. 行为树主流程

主行为树位于：

```text
src/exploration/gbplanner_ros/gbplanner/config/bt_xml/main_tree.xml
```

当前结构可以简化理解为：

```text
Sequence
  ReactiveFallback
    HomingCheck
    lge_homing_lnav
  active_homing
```

含义：

1. 每次 planner service 被调用，先执行 `HomingCheck`。
2. 如果 `HomingCheck` 返回 SUCCESS，说明需要返航，随后进入 `active_homing`，计算并返回 homing path。
3. 如果 `HomingCheck` 返回 FAILURE，才继续执行局部探索、全局探索、局部导航等分支。

所以真正的时间返航触发日志是：

```text
Time to home: ...; Time remaining: ...
REACHED TIME LIMIT: HOMING ENGAGED.
[BT][HomingCheck] Homing needed 1
[BT][CalculateHomingPath] Triggered
```

而下面这个不是“已经返航”，只是全局 frontier 筛选时发现继续去某些 frontier 风险太高：

```text
REACHED TIME LIMIT: BE CAREFUL.
```

## 3. 时间返航判断条件

核心代码在：

```text
src/exploration/gbplanner_ros/gbplanner/src/rrg.cpp
Rrg::homingRequired()
```

当前判断逻辑：

```cpp
time_elapsed = now - rostime_start_;
time_budget_remaining = time_budget_limit - time_elapsed;
time_remaining = min(time_budget_remaining, current_battery_time_remaining_);

homing_path = searchHomingPath(world_frame_, current_state_);
homing_len = pathLength(homing_path);
time_to_home = homing_len / v_homing_max;

if (time_to_home > time_remaining - 20.0) {
  homing_engaged_ = true;
  return true;
}
```

也就是说，满足下面条件才会触发时间返航：

```text
预计返航时间 > 剩余可用时间 - 20 秒安全余量
```

其中：

- `time_budget_limit`：任务总时间预算，配置在 `gbplanner_config.yaml`。
- `current_battery_time_remaining_`：电池剩余时间，如果没有真实电池约束，通常不是主要限制。
- `v_homing_max`：返航速度估计值，配置在 `gbplanner_config.yaml` 的 `RobotDynamics` 相关参数里。
- `20 秒`：代码内固定安全余量 `kTimeDelta`。

注意：如果 `searchHomingPath()` 找不到回 home 的路径，`homingRequired()` 会返回 false。也就是说，系统可能“理论上应该返航”，但因为当前图里找不到安全回家路径，时间返航不会成功进入可执行状态。

## 4. 全局 frontier 的时间可行性检查

除了真正的 `HomingCheck`，全局 planner 里还有一层 frontier 可行性过滤：

```text
src/exploration/gbplanner_ros/gbplanner/src/rrg.cpp
Rrg::calculateGlobalPath()
```

它会估计：

```text
当前点 -> frontier 的时间
+ frontier -> home 的时间
```

如果这笔时间不满足剩余预算，就打印：

```text
REACHED TIME LIMIT: BE CAREFUL.
```

这个分支的作用是：不要再选择一个“去了以后可能回不来”的全局 frontier。它本身不等价于立刻执行返航。若所有 global frontiers 都不可行，会出现：

```text
Get 0 feasible frontiers from global frontiers.
No feasible frontier exists --> Call HOMING instead if fully explored.
```

随后能不能真正 homing，还要看局部/全局完成状态和 homing path 是否能算出来。

## 5. 探索完成触发返航

除了时间条件，当前还有“探索完成后返航”的逻辑。

配置：

```yaml
auto_homing_enable: true
go_home_if_fully_explored: true
```

判断位置：

```text
Rrg::calculateGlobalPath()
```

当全局图没有 frontier 时，会结合最近一次局部探索状态判断局部是否也耗尽：

```cpp
local_exploration_exhausted =
    last_local_completion_candidate_ ||
    last_local_valid_path_count_ <= 0 ||
    last_local_frontier_count_ <= 0;
```

如果：

```text
global_frontiers == 0
&& local_exploration_exhausted == true
&& go_home_if_fully_explored == true
```

则调用：

```text
getHomingPath()
```

并返回 `kHoming`。

典型日志：

```text
[RRG][COMPLETE] Global frontier check: global_frontiers=0, ...
[RRG][COMPLETE] completion decision: local_exhausted=1 go_home_if_fully_explored=1
 --> Calling HOMING instead.
```

## 6. LocalNavigation 与 AUTO 保活修正

之前出现过一个状态问题：局部导航没有目标时，BT 会停留在 `LocalNavigation`，导致后续探索/时间返航分支进不去。

已修正逻辑：

```text
src/exploration/gbplanner_ros/gbplanner/src/gbplanner_bt_nodes.cpp
LocalNavigation::onStart()
```

当局部导航返回：

```text
L_EXHAUSTED
L_STUCK
```

现在会把：

```cpp
bt_states_.operation_mode = 0;
```

切回探索模式。关键日志：

```text
[BT][LocalNavigation] local navigation exhausted; switching back to exploration mode
[BT][LocalNavigation] local navigation stuck; switching back to exploration mode
```

另一个修正位于 PCI：

```text
src/exploration/gbplanner_ros/planner_control_interface/src/planner_control_interface.cpp
```

自动模式下 planner 返回 `kManualCustomPath + empty path` 时，不再直接让系统掉回手动死等，而是 preserve AUTO：

```text
[PCI][AUTO_WATCHDOG] planner returned empty auto path; keeping auto mode alive so HomingCheck/time-budget can be evaluated again
```

## 7. 当前已知风险：homing 失败后仍可能执行旧路径

最近日志暴露了一个需要继续修的安全问题：

```text
[RRG][HOMING] Post-processed homing path failed collision check, trying raw homing path as fallback.
[RRG][HOMING] Raw homing path is also unsafe, returning empty path.
[BT][CalculateHomingPath] failed
GBPlanner service response status=2 path_size=46
```

这组日志说明：

1. 时间返航已经触发。
2. homing path 碰撞检查失败。
3. `CalculateHomingPath` 返回 failed。
4. 但 service response 仍然带着 `status=2` 和非空 path。

这很可能是旧的 `out_srv_res_.path` 没有在失败时清空，导致 PCI 继续执行残留路径。后续需要修正：

```text
CalculateHomingPath failed 时必须清空 response path，
并且不能保留 kHoming + stale path 的组合。
```

否则会出现“返航失败，但执行旧返航路径，然后卡在某个 waypoint”的情况。

## 8. 下一步设计：累计探索距离强制返航

目标：新增一个和时间条件并行的强制返航条件。

期望行为：

```text
时间预算触发
OR
累计探索距离达到阈值
```

任意一个条件满足，都进入强制返航，不再继续选择探索路径。

### 8.1 建议新增参数

建议加在 `gbplanner_config.yaml`：

```yaml
distance_budget_enable: true
distance_budget_limit: 80.0        # m，累计探索距离上限
distance_budget_hysteresis: 0.5    # m，避免阈值附近抖动
```

含义：

- `distance_budget_enable`：是否启用距离预算强制返航。
- `distance_budget_limit`：累计执行/探索距离达到该值后触发返航。
- `distance_budget_hysteresis`：可选，避免距离接近阈值时反复切状态。

### 8.2 距离统计放在哪里

推荐把累计距离统计放在 PCI，而不是 RRG。

原因：

1. PCI 离真实执行路径最近，能看到当前位姿持续变化。
2. RRG 只能估计规划路径长度，规划路径不等于真实执行距离。
3. 如果 planner 返回旧路径、短路径、重规划路径，PCI 统计更接近实际飞行距离。

建议统计源：

```text
PlannerControlInterface::processPose()
```

或 odom/pose callback 中，每次收到新 pose 后：

```cpp
delta = distance(current_pose, previous_pose);
if (delta is reasonable) {
  accumulated_exploration_distance += delta;
}
```

需要过滤异常跳变：

```text
delta <= max_reasonable_pose_jump
```

比如仿真里先设 `2.0 m`，防止 TF/里程计重置导致距离瞬间暴涨。

### 8.3 距离条件如何传给 planner

有两种实现路线。

方案 A：PCI 直接强制触发 homing service。

```text
PCI 累计距离 >= 阈值
  -> 设置 homing_request_
  -> 调用 planner homing
  -> 执行 kHomingPath
```

优点：

- 实现快。
- 不需要改 planner service request。
- 距离条件完全由执行层控制。

缺点：

- `HomingCheck` 的日志里看不到距离触发原因。
- 时间条件在 RRG，距离条件在 PCI，触发来源分散。

方案 B：PCI 把累计距离传给 gbplanner，RRG 在 `homingRequired()` 中统一判断。

```text
PCI 统计 accumulated_distance
  -> planner_srv.request 增加字段
  -> gbplanner 保存到 planning state
  -> Rrg::homingRequired()
       if time condition OR distance condition
         return true
```

优点：

- 判断入口统一。
- 日志统一，便于调试：

```text
[RRG][HOMING_CHECK] reason=time
[RRG][HOMING_CHECK] reason=distance
```

缺点：

- 需要改 `planner_srv.srv`，重新生成消息，影响范围稍大。

当前建议：先用方案 A 快速验证功能；稳定后再升级为方案 B，把触发原因统一收到 planner 侧。

### 8.4 推荐最终判断形式

最终在逻辑上应该收敛成：

```cpp
bool time_limit_reached =
    time_to_home > time_remaining - kTimeDelta;

bool distance_limit_reached =
    distance_budget_enable &&
    accumulated_exploration_distance >= distance_budget_limit;

if (time_limit_reached || distance_limit_reached) {
  homing_engaged_ = true;
  homing_reason =
      time_limit_reached ? "time_budget" : "distance_budget";
  return true;
}
```

如果两个条件同时满足，日志可以优先报时间，也可以报两个：

```text
[RRG][HOMING_CHECK] trigger=time_budget,distance_budget
```

### 8.5 必须配套的安全修正

加入距离强制返航前，建议优先修复第 7 节的问题：

```text
homing path 计算失败时，不允许返回 stale path。
```

否则距离条件会更频繁触发 homing，也会更频繁撞上“返航失败但执行旧路径”的风险。

建议执行顺序：

1. 修复 homing failed 清空 response path。
2. 给 homing response 增加明确日志：成功/失败、path_size、触发原因。
3. 加入 PCI 侧累计距离统计。
4. 先用方案 A 触发 homing。
5. 如果验证稳定，再改 srv 用方案 B 统一判断入口。

## 9. 调试时看哪些日志

确认时间返航是否触发：

```text
Time to home:
REACHED TIME LIMIT: HOMING ENGAGED.
[BT][HomingCheck] Homing needed 1
```

确认只是 frontier 被时间过滤：

```text
REACHED TIME LIMIT: BE CAREFUL.
Get 0 feasible frontiers from global frontiers.
```

确认局部导航是否卡住后切回探索：

```text
[BT][LocalNavigation] local navigation exhausted; switching back to exploration mode
[BT][LocalNavigation] local navigation stuck; switching back to exploration mode
```

确认 PCI 是否仍在自动触发：

```text
[PCI][STATE] status=READY trigger=AUTO
Planning iteration ...
[PCI]: Called plan srv
```

确认 homing path 是否安全失败：

```text
[RRG][HOMING] Post-processed homing path failed collision check
[RRG][HOMING] Raw homing path is also unsafe
[BT][CalculateHomingPath] failed
```

如果同时看到：

```text
[BT][CalculateHomingPath] failed
GBPlanner service response status=2 path_size>0
```

说明 stale path 风险仍然存在，需要优先修。
