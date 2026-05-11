# GBPlanner 启动指南

这份文档整理了仿真和实机两套启动步骤，以及它们的差异。

## 一、实机启动步骤

### 1. 先启动底层传感与定位

确保以下话题已经存在：

- `/vins_fusion/imu_propagate`
- `/cloud_registered_360`
- `/position_cmd`

必要时先确认 TF 已经就绪。

### 2. 启动实机规划主栈

推荐直接起这套：

```bash
source /opt/ros/noetic/setup.bash
source ~/csj/uestc-gb3/devel/setup.bash
roslaunch gbplanner rmf_real.launch
```

如果你想同时用终端按键控制：

```bash
source /opt/ros/noetic/setup.bash
source ~/csj/uestc-gb3/devel/setup.bash
roslaunch gbplanner_ui gbplanner_topic_terminal.launch
```

### 3. 观察运行结果

重点看这些话题：

- `/rmf_obelix/command/trajectory`
- `/position_cmd`
- `/gbplanner_path`
- `/vis/planning_homing_path`

### 4. 常用按键

终端控制按键：

```text
1 Start Auto Planning
2 Start Single Planning
3 Stop Planning
4 Go Home
5 Initialization Motion
6 Plan To Waypoint
7 Run Global Planner
8 Toggle Operation Mode
```

## 二、仿真启动步骤

### 1. 启动仿真主栈

推荐这条：

```bash
source /opt/ros/noetic/setup.bash
source ~/csj/uestc-gb3/devel/setup.bash
roslaunch gbplanner rmf_sim.launch rviz_en:=true traj_server_en:=true
```

如果你不想开默认 RViz：

```bash
roslaunch gbplanner rmf_sim.launch rviz_en:=false traj_server_en:=true
```

### 2. 启动终端按键控制

```bash
source /opt/ros/noetic/setup.bash
source ~/csj/uestc-gb3/devel/setup.bash
roslaunch gbplanner_ui gbplanner_topic_terminal.launch
```

## 三、两者的差异

### 1. 点云输入不同

实机：

- `/cloud_registered_360`

仿真：

- `/livox/lidar`
- 经过 `pointcloud_frame_fixer_node`

### 2. 里程计输入不同

实机：

- `/vins_fusion/imu_propagate`

仿真：

- `/rmf_obelix/ground_truth/odometry_throttled`

### 3. 控制链路不同

实机：

```text
pci_general -> /rmf_obelix/command/trajectory -> traj_server_node -> /position_cmd -> px4ctrl
```

仿真：

```text
pci_general -> /rmf_obelix/command/trajectory -> traj_server_node -> /position_cmd
```

### 4. TF 处理不同

实机：

- 通常不额外发布 odom TF
- 取决于 VINS 是否已经提供完整 TF

仿真：

- 会显式发布 world 到机体相关 TF
- 还会补点云 frame 修正

### 5. 地图和坐标系假设不同

实机更依赖真实传感器的 frame 对齐，常见基准是：

- `camera_init`
- `body`
- `world`

仿真里坐标系更固定，通常不需要你手动猜传感器外参。

### 6. 启动方式不同

实机更像：

```text
先定位和雷达
再起规划
再起控制桥
再起按键终端
```

仿真更像：

```text
一条 launch 起全套
再看 RViz 和轨迹显示
```

## 四、建议的检查顺序

1. 先看里程计是否正常
2. 再看点云是否正常
3. 再看规划器是否有路径
4. 再看轨迹是否发到控制器
5. 最后看是否触发 homing

## 五、最常用的两条命令

实机：

```bash
roslaunch gbplanner rmf_real.launch
roslaunch gbplanner_ui gbplanner_topic_terminal.launch
```

仿真：

```bash
roslaunch gbplanner rmf_sim.launch rviz_en:=true traj_server_en:=true
roslaunch gbplanner_ui gbplanner_topic_terminal.launch
```
