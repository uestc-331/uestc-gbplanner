# GB3 RViz 关键可视化说明

更新时间：2026-05-09

## 1. 路径类显示

### `/vis/planning_homing_path`

RViz 名称：

```text
PlannerViz / HomingPath
```

含义：

```text
真正的 homing / go home 路径候选。
```

这是 RRG 在全局图上从当前位置或当前图节点搜索回 home 的路径。现在颜色已改为亮青色：

```text
RGB ~= 0, 217, 255
```

代码位置：

```text
src/exploration/gbplanner_ros/gbplanner/src/gbplanner_rviz.cpp
Visualization::visualizeHomingPath()
```

注意：这个 topic 是 `MarkerArray`，颜色由代码里的 marker color 决定，不是 RViz 配置文件里单独调出来的。

### `/vis/planning_global_path`

RViz 名称：

```text
PlannerViz / PlanningGlobalPath
```

里面通常有两条路径：

```text
current2frontier：绿色
frontier2home：暗红色
```

你看到的“和 go home 路径大致相同的暗红色路径”，一般就是：

```text
/vis/planning_global_path 的 frontier2home
```

它不是当前马上执行的回家路径，而是 global planner 在评估某个 frontier 时，用来检查：

```text
如果先去这个 frontier，之后还能不能从 frontier 回 home
```

所以它经常和真正的 homing path 形状相似，但语义不同：

```text
亮青色 HomingPath：当前实际回家候选路径
暗红色 frontier2home：全局 frontier 可行性检查路径
```

### `/vis/ref_path`

RViz 名称：

```text
PlannerViz / RefPath
```

含义：

```text
planner 当前选中的参考路径/返回给上层的候选路径可视化。
```

在探索、全局重定位、homing path 后处理等地方都会被复用，所以它不一定只代表一种模式。当前代码里普通 ref path 是偏紫色线。

### `/gbplanner_path`

RViz 名称：

```text
Path / gbplanner_path
```

含义：

```text
PCI/Planner 对外发布的当前路径显示，最接近“现在准备执行或正在执行的路径”。
```

调试“飞机到底被要求去哪”时，这个比内部候选路径更重要。

### `/rmf_obelix/command/trajectory`

RViz 名称：

```text
MultiDOFJointTrajectory
```

含义：

```text
PCI 发给轨迹执行链的最终 command trajectory。
```

如果 `/gbplanner_path` 看起来正常，但飞机执行不对，要继续看这个 topic 和 `/position_cmd`。

## 2. 图和 frontier 类显示

### `/vis/planning_global_graph`

RViz 名称：

```text
PlannerViz / GlobalGraph
```

常用 namespace：

```text
frontier
vertices
edges
gain
```

含义：

```text
全局探索图和全局 frontier。
```

你看到“附近还有很多 frontier”时，通常就是这个 topic 的 `frontier` namespace。

### `/vis/planning_graph`

RViz 名称：

```text
PlannerViz / PlanningGraph
```

含义：

```text
当前局部 RRG 采样图。
```

默认可以关掉，需要分析局部采样、局部连边、候选路径为什么被拒时再打开。

### `/vis/best_planning_paths`

RViz 名称：

```text
PlannerViz / BestPaths
```

含义：

```text
局部 evaluateGraph 排名前几的候选路径。
```

配合日志里的 `PathRank[1] ... pass=[G L U Dir ALL]` 使用很有价值。

## 3. 执行状态类显示

### `/pci_carrot`

RViz 名称：

```text
PlannerViz / PCI_Carrot
```

含义：

```text
PCI 当前追踪的 carrot / reference pose。
```

你看到跟随无人机的黄色箭头，大概率就是它。它不是 frontier，也不是最终目标点，而是执行器当前追踪的局部参考姿态。

### `/vis/robot_state`

RViz 名称：

```text
PlannerViz / RobotState
```

含义：

```text
planner 内部认为的机器人状态。
```

如果它和真实 odom / base_link 偏差大，说明输入位姿或 frame 可能有问题。

## 4. 地图类显示

### `/gbplanner_node/surface_pointcloud`

RViz 名称：

```text
Voxblox / SurfacePCL
```

含义：

```text
voxblox / mapper 提取的环境表面点云。
```

用于看地图是否正常建出来、障碍物是否被错误投影到路径附近。

### `/gbplanner_node/occupied_nodes`

RViz 名称：

```text
Voxblox / Occupied
```

含义：

```text
被认为占据的节点/体素。
```

如果 homing path 或 ref path 明显穿过 occupied 区域，说明碰撞检查或地图膨胀参数需要重点看。

## 5. 推荐调试组合

普通探索调试：

```text
/gbplanner_path
/rmf_obelix/command/trajectory
/vis/planning_global_graph 的 frontier
/vis/ref_path
/pci_carrot
/gbplanner_node/surface_pointcloud
```

时间返航/强制返航调试：

```text
/vis/planning_homing_path
/vis/planning_global_path
/vis/ref_path
/gbplanner_path
/rmf_obelix/command/trajectory
```

局部路径为什么被拒：

```text
/vis/best_planning_paths
/vis/planning_graph
/vis/planning_global_graph
rosout 里的 [RRG][DIAG] 和 PathRank
```
