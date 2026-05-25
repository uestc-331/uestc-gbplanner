# gbplanner3 终端话题指令速查

工作空间：`/home/super/uestcgbplanner3`

> 只针对 gbplanner3。下面命令不要混用旧的 `/home/super/uestc-gbplanner` 工作空间。

## 1. 先加载环境

每个新终端先执行：

```bash
cd /home/super/uestcgbplanner3
source /opt/ros/noetic/setup.bash
source /home/super/uestcgbplanner3/devel/setup.bash
```

## 2. 推荐启动方式

gbplanner3 里已有脚本：

```bash
bash /home/super/uestcgbplanner3/scripts/gbplanner.sh
```

这个脚本会启动：

```bash
roslaunch gbplanner rmf_real.launch
rosrun gbplanner_ui gbplanner_cli
```

CLI 菜单对应：

- `1`: Start Planner
- `2`: Stop Planner
- `3`: Homing
- `4`: Initialization
- `5`: Go To Waypoint
- `6`: Global Planner，默认 frontier id 为 `0`
- `7`: Toggle Operation Mode
- `0`: Exit

## 3. 直接发 topic 指令

gbplanner3 的终端话题入口是 `/gbplanner_ui/cmd/...`。这些话题需要 `gbplanner_topic_command_bridge` 或相关 launch 已经启动，否则发出去没人接收。

### 启动规划

```bash
cd /home/super/uestcgbplanner3
source /opt/ros/noetic/setup.bash
source /home/super/uestcgbplanner3/devel/setup.bash
rostopic pub -1 /gbplanner_ui/cmd/start_planner std_msgs/Empty "{}"
```

### 启动单次规划

```bash
rostopic pub -1 /gbplanner_ui/cmd/start_planner_single std_msgs/Empty "{}"
```

### 停止规划

```bash
rostopic pub -1 /gbplanner_ui/cmd/stop_planner std_msgs/Empty "{}"
```

### 回家 / Homing

```bash
rostopic pub -1 /gbplanner_ui/cmd/homing std_msgs/Empty "{}"
```

#### 看是否回家
```bash
rostopic echo /gbplanner_is_homing
```

### 初始化 / Initialization

```bash
rostopic pub -1 /gbplanner_ui/cmd/init_motion std_msgs/Empty "{}"
```

### 去航点 / Go To Waypoint

```bash
rostopic pub -1 /gbplanner_ui/cmd/plan_to_waypoint std_msgs/Empty "{}"
```

### 全局规划

`data` 是 frontier id，默认常用 `0`：

```bash
rostopic pub -1 /gbplanner_ui/cmd/global_frontier_id std_msgs/Int32 "data: 0"
```

指定其他 frontier id，例如 `3`：

```bash
rostopic pub -1 /gbplanner_ui/cmd/global_frontier_id std_msgs/Int32 "data: 3"
```

### 切换 Operation Mode

`false` 表示 EXP，`true` 表示 WP/local navigation：

```bash
rostopic pub -1 /gbplanner_ui/cmd/operation_mode std_msgs/Bool "data: false"
rostopic pub -1 /gbplanner_ui/cmd/operation_mode std_msgs/Bool "data: true"
```

## 4. 起飞 / 降落

gbplanner3 的 `sim_tools/src/uav_ctlcmd_node.cpp` 里发布起飞到：

```text
/Ctrl/takeoff_land
```

消息类型：

```text
quadrotor_msgs/TakeoffLand
TAKEOFF = 1
LAND = 2
```

### 起飞

```bash
rostopic pub -1 /Ctrl/takeoff_land quadrotor_msgs/TakeoffLand "takeoff_land_cmd: 1"
```

### 降落

```bash
rostopic pub -1 /Ctrl/takeoff_land quadrotor_msgs/TakeoffLand "takeoff_land_cmd: 2"
```

注意：`sim_remote.py` 里还有一个特殊用途话题 `/px4ctrl/takeoff_land`。如果你运行的是 `sim_remote.py` 那套控制链，再用：

```bash
rostopic pub -1 /px4ctrl/takeoff_land quadrotor_msgs/TakeoffLand "takeoff_land_cmd: 1"
rostopic pub -1 /px4ctrl/takeoff_land quadrotor_msgs/TakeoffLand "takeoff_land_cmd: 2"
```

## 5. Service 备选命令

gbplanner3 的 RViz UI 直接调用 service。如果 topic bridge 没启动，可以直接用 service：

### 启动规划

```bash
rosservice call /planner_control_interface/std_srvs/automatic_planning "{}"
```

### 单次规划

```bash
rosservice call /planner_control_interface/std_srvs/single_planning "{}"
```

### 停止规划

```bash
rosservice call /planner_control_interface/std_srvs/stop "{}"
```

### 回家 / Homing

```bash
rosservice call /planner_control_interface/std_srvs/homing_trigger "{}"
```

### 去航点

```bash
rosservice call /planner_control_interface/std_srvs/go_to_waypoint "{}"
```

### 切换 Operation Mode

```bash
rosservice call /gbplanner/switch_operation_mode "data: false"
rosservice call /gbplanner/switch_operation_mode "data: true"
```

## 6. 检查话题和服务

检查 gbplanner3 的 topic 入口：

```bash
rostopic list | grep -E "/gbplanner_ui/cmd|/Ctrl/takeoff_land|/px4ctrl/takeoff_land"
```

检查 service：

```bash
rosservice list | grep -E "automatic_planning|single_planning|homing_trigger|go_to_waypoint|switch_operation_mode|pci_global|pci_initialization"
```

查看话题类型：

```bash
rostopic type /gbplanner_ui/cmd/start_planner
rostopic type /gbplanner_ui/cmd/global_frontier_id
rostopic type /gbplanner_ui/cmd/operation_mode
rostopic type /Ctrl/takeoff_land
```

监听命令是否发出：

```bash
rostopic echo /gbplanner_ui/cmd/start_planner
rostopic echo /gbplanner_ui/cmd/homing
rostopic echo /gbplanner_ui/cmd/global_frontier_id
rostopic echo /Ctrl/takeoff_land
```

## 7. 常用流程

```bash
# 1. 起飞
rostopic pub -1 /Ctrl/takeoff_land quadrotor_msgs/TakeoffLand "takeoff_land_cmd: 1"

# 2. 初始化
rostopic pub -1 /gbplanner_ui/cmd/init_motion std_msgs/Empty "{}"

# 3. 启动规划
rostopic pub -1 /gbplanner_ui/cmd/start_planner std_msgs/Empty "{}"

# 4. 需要全局规划时，frontier id 默认为 0
rostopic pub -1 /gbplanner_ui/cmd/global_frontier_id std_msgs/Int32 "data: 0"

# 5. 返航
rostopic pub -1 /gbplanner_ui/cmd/homing std_msgs/Empty "{}"

# 6. 停止规划
rostopic pub -1 /gbplanner_ui/cmd/stop_planner std_msgs/Empty "{}"

# 7. 降落
rostopic pub -1 /Ctrl/takeoff_land quadrotor_msgs/TakeoffLand "takeoff_land_cmd: 2"
```




# 计划
# gbplanner3 路径生成延迟优化计划

  ## 目标

  降低 `rostopic pub -1 /gbplanner_ui/cmd/start_planner std_msgs/Empty "{}"` 后路径生
  成慢、延迟大的问题。

  当前判断：命令触发成功，慢主要来自 voxblox 点云处理和可视化发布开销，不是 topic 指令
  问题。

  ## 主要改动

  修改：

  `/home/super/uestcgbplanner3/src/exploration/gbplanner_ros/gbplanner/config/
  rmf_obelix/voxblox_sim_config.yaml`

  计划参数：

  ```yaml
  pointcloud_queue_size: 5
  min_time_between_msgs_sec: 0.10
  publish_pointclouds: False
  publish_traversable: False
  publish_tsdf_map: False
  publish_esdf_map: False
  update_mesh_every_n_sec: 0

  暂不改采样/规划算法参数，避免影响路径质量。

  ## 验证命令

  重启 gbplanner3 后检查参数：

  rosparam get /gbplanner_node/pointcloud_queue_size
  rosparam get /gbplanner_node/min_time_between_msgs_sec
  rosparam get /gbplanner_node/publish_pointclouds
  rosparam get /gbplanner_node/publish_tsdf_map
  rosparam get /gbplanner_node/publish_esdf_map

  测试启动规划：

  rostopic pub -1 /gbplanner_ui/cmd/start_planner std_msgs/Empty "{}"

  观察是否减少：

  Input pointcloud queue getting too long

  ## 验收标准

  - 路径仍能生成
  - 规划延迟明显降低
  - 不再频繁出现点云队列过长
  - RViz 可以看到路径
  - 不出现新的 TF fail 或空路径问题

  ## 后续

  如果仍然慢，再进入第二阶段：给 /cloud_registered_360 到 /cloud_registered_fixed 增加
  点云限频或降采样。