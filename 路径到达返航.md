# 距离预算返航修改说明

本文档记录 `planner_control_interface` 中“按照累计距离触发返航”的修改。

## 修改目标

原逻辑只要 PCI 处于 Auto 模式，就会把每次里程计位置变化累加到距离预算里。对无人机来说，原地悬停时的轻微上下/左右摇摆、定位噪声、等待规划时的漂移，都可能被误算成探索距离。

新逻辑改为：只有无人机正在执行 Auto 本地探索路径时才计数，并且只累计水平 XY 方向的锚点阈值位移。

## 修改文件

- `src/exploration/gbplanner_ros/planner_control_interface/include/planner_control_interface/planner_control_interface.h`
- `src/exploration/gbplanner_ros/planner_control_interface/src/planner_control_interface.cpp`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_real_config.yaml`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_sim_config.yaml`

## 具体改动

### 1. 只在真正执行探索路径时计数

新增状态变量：

```cpp
distance_budget_exploration_execution_active_
```

它只会在 `runPlanner()` 成功下发路径后开启，并且必须同时满足：

- 当前触发模式是 `kAuto`
- 路径类型是 `PCIManager::ExecutionPathType::kLocalPath`
- 实际执行路径非空

以下情况会关闭该状态：

- planner reset
- 开始 homing
- 新一轮 planner 调用开始
- 距离预算已经触发 homing
- odom 回调发现当前不满足计数条件

这样可以避免在等待规划、Auto 悬停、homing、manual path、global repositioning path 时继续累计距离。

### 2. 从 3D 每帧累计改为 XY 锚点阈值累计

`updateDistanceBudgetFromOdom()` 现在只计算水平位移：

```cpp
const double dx = position.x - distance_budget_last_odom_position_.x;
const double dy = position.y - distance_budget_last_odom_position_.y;
const double step = std::hypot(dx, dy);
```

也就是说，z 方向上下浮动不会再消耗距离预算。

当 `step < distance_budget_min_step` 时，不累计距离，也不更新锚点。只有当前位置距离上一个有效锚点足够远时，才会把这段水平距离加入累计值，并把锚点更新到当前位置。

当 `step > distance_budget_max_step` 时，认为这是定位跳变，不累计距离，但会把锚点重置到当前位置，避免下一帧继续受到这次跳变影响。

### 3. 参数调整

`rmf_obelix` 的实机和仿真配置都改为：

```yaml
distance_budget_max_step: 1.0
distance_budget_min_step: 0.08
```

`distance_budget_min_step: 0.08` 表示水平移动超过 8 cm 才计入累计距离，用来过滤无人机小幅摇摆和里程计噪声。

`distance_budget_max_step: 1.0` 用来过滤较大的定位跳变。如果 odom 频率很低，或者无人机可能在两帧 odom 之间真实移动超过 1 m，需要适当调大这个值。

## 运行时日志

距离累计日志现在会出现：

```text
[PCI][DIST_BUDGET] accumulated=... trigger=AUTO metric=xy_anchor
```

其中 `metric=xy_anchor` 表示当前累计的是“Auto 本地探索路径执行期间的水平锚点阈值位移”。

触发返航的日志仍然是：

```text
[PCI][DIST_BUDGET] trigger homing accumulated=... limit=...
```

触发后仍保持原来的行为：优先等待当前路径执行完成；如果超过 `distance_budget_release_timeout` 仍未完成，则强制切到 Ready 并执行 direct homing。
