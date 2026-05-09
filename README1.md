# UESTC GBPlanner 仿真启动说明

语雀：https://www.yuque.com/uestc_gk/ll7zl6/cnbfwg8gakd9rfyz

## 1. 前提

- ROS 版本：`noetic`
- 当前工作区：`/home/uestc/csj/uestc-gb3`
- 外部 PX4 工程：`/home/uestc/PX4_Firmware`
- `px4 floor5.launch` / `px4 pipe.launch` 依赖 PX4 的 Gazebo 环境和 `mavlink_sitl_gazebo`

每个新终端先执行一次：

```bash
cd /home/uestc/csj/uestc-gb3
source scripts/gb3_env.bash
```

这会加载 ROS、当前工作区、`/home/uestc/PX4_Firmware` 和 `/home/uestc/PX4_Firmware/Tools/sitl_gazebo`。如果你的 `~/.bashrc` 已经配置好了这些路径，也可以省略。

## 2. 编译

先在工作区根目录编译一次：

```bash
cd /home/uestc/csj/uestc-gb3
source scripts/gb3_env.bash
catkin build
```

## 3. 启动顺序

建议按下面顺序分别开 6 个终端启动。

### 终端 1：启动 Gazebo + PX4   环境1是floor5，环境2是pipe，二选一

```bash
cd /home/uestc/csj/uestc-gb3
source scripts/gb3_env.bash
roslaunch px4 floor5.launch
# 或者
roslaunch px4 pipe.launch
roslaunch px4 pipeline_xyq.launch

```

### 终端 2：启动仿真定位

`sim_tools` 会把仿真位姿转换到 `/vins_fusion/imu_propagate`，`px4ctrl` 和 `uav_control` 都依赖这个话题。

```bash
sss
roslaunch sim_tools get_real_pose.launch
```

### 终端 3：启动模拟遥控器

```bash
sss
roslaunch sim_tools sim_remote.launch
```

### 终端 4：启动飞控控制器

```bash
sss
roslaunch px4ctrl run_ctrl.launch
```

### 终端 5：启动调度器

这里的 `uav_control` 负责调度与模式切换；在 `setup.launch` 中已关闭它的 `/position_cmd` 发布，控制输出由终端 6 的 `traj_server_node` 统一发布。

```bash
sss
roslaunch uav_control setup.launch
```

### 终端 6：启动探索规划

这里使用的是 `gbplanner`。`rmf_sim.launch` 内部已经包含：

- `odom_to_tf_node`
- `pointcloud_frame_fixer_node`
- `gbplanner_node`
- `pci_general_ros_node`
- `traj_server_node`

所以这里不用再单独执行 `rosrun sim_tools traj_server_node`。

```bash
sss
roslaunch gbplanner rmf_sim.launch
```

如果需要同时打开 RViz：

```bash
sss
roslaunch gbplanner rmf_sim.launch rviz_en:=true
```

## 4. RViz 操作顺序

`gbplanner` 这套 UI 里，`Start Planner` 不会自动帮你起飞或做初始化动作。

建议顺序：

1. 先确认飞机已经完成起飞/悬停，或者在 RViz 面板里先点一次 `Initialization`
2. 等飞机离地后，再点 `Start Planner`
3. 如果你想指定一个明确目标点：
   在 RViz 用 `2D Nav Goal` 先打目标，再点 `Plan to Waypoint`

如果飞机还在地面，`Start Planner` 可能会出现：

- 规划器持续运行，但没有轨迹输出
- `gbplanner_status` 一直是 `False`
- 日志里出现 `No feasible path` 或 `No positive gain was found`

这是因为当前根状态太低或处于不可规划位置，规划器会返回空路径。

## 5. 运行时检查

建议先确认下面几个关键话题已经正常发布：

```bash
rostopic echo -n 1 /vins_fusion/imu_propagate
rostopic echo -n 1 /rmf_obelix/ground_truth/odometry_throttled
rostopic echo -n 1 /position_cmd
rostopic echo -n 1 /livox/lidar
```

链路关系是：

- `sim_tools/get_real_pose.launch` -> `/vins_fusion/imu_propagate`
- `gbplanner rmf_sim.launch` -> `/vins_fusion/imu_propagate` -> `rmf_obelix/ground_truth/odometry_throttled`
- `gbplanner rmf_sim.launch` -> `rmf_obelix/command/trajectory` -> `/position_cmd`
- `px4ctrl` 订阅 `/vins_fusion/imu_propagate` 和 `/position_cmd`
- `uav_control setup.launch` 默认不发布 `/position_cmd`，避免与 `traj_server_node` 冲突

如果需要额外排查规划是否真的出轨迹，可以再看：

```bash
rostopic echo /gbplanner_status
rostopic echo /rmf_obelix/command/trajectory
```

## 6. 可选：发布风扰

```bash
rostopic pub /wind_xtdrone geometry_msgs/Twist "{linear: {x: 15.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 0.0}}"
```

## 7. 本次核对结论

- 已确认仓库内存在：`roslaunch gbplanner rmf_sim.launch`
- 已确认仓库内存在：`roslaunch sim_tools get_real_pose.launch`
- 已确认仓库内存在：`roslaunch sim_tools sim_remote.launch`
- 已确认仓库内存在：`roslaunch px4ctrl run_ctrl.launch`
- 已确认仓库内存在：`roslaunch uav_control setup.launch`
- 已确认外部 PX4 工程存在：`/home/uestc/PX4_Firmware/launch/floor5.launch`
- 已确认外部 PX4 工程存在：`/home/uestc/PX4_Firmware/launch/pipe.launch`
- 已确认 `source scripts/gb3_env.bash` 后：`roslaunch px4 pipe.launch --ros-args` 可解析
- 已确认 `catkin build --summarize` 全量通过，当前可构建包为 78 个
- `README1.md` 原先引用参考仓库路径，现已按当前 `uestc-gb3` 工作区修正
- `rmf_sim.launch` 当前使用 `sim_tools/traj_server_node`，不再要求 `gbplanner` 包内重复构建同名节点
