# 实机无人机部署记录与迁移说明

这份文档总结了当前工程从仿真迁移到实机时，已经确认的接线、需要关注的配置，以及以后迁移到其他类似无人机时的操作顺序。

## 当前实机链路

### 1. 点云输入

实机激光雷达点云话题：

```text
/cloud_registered_360
```

规划器侧接法：

```text
/cloud_registered_360 -> gbplanner_node (/pointcloud)
```

如果原始点云的 `frame_id` 不对，再打开点云修正节点：

```text
fix_pointcloud_frame:=true
```

当前默认目标帧是：

```text
camera_init
```

### 2. 里程计输入

当前使用的定位/里程计话题：

```text
/vins_fusion/imu_propagate
```

规划器和 PCI 都接这个话题：

```text
/vins_fusion/imu_propagate -> gbplanner_node
/vins_fusion/imu_propagate -> pci_general_ros_node
```

### 3. 规划输出到控制器

这里最重要的一点是：

`pci_general` 发的是 `trajectory_msgs/MultiDOFJointTrajectory`，不是 `quadrotor_msgs/PositionCommand`。

所以实机链路要保留中间的轨迹服务器：

```text
pci_general
-> /rmf_obelix/command/trajectory
-> traj_server_node
-> /position_cmd
-> px4ctrl
```

你给出的控制器输入话题是：

```text
/position_cmd
```

所以实机 launch 里需要启动 `traj_server_node`，把轨迹转成控制器能吃的指令。

### 4. TF 关系

当前实机默认：

- `publish_odom_tf=false`
- 如果 VINS 已经提供了完整 TF，就不要再额外重复发布
- 如果缺 TF，再打开 `odom_to_tf_node`

## 当前实机 launch 的核心默认值

文件：

```text
src/exploration/gbplanner_ros/gbplanner/launch/rmf/rmf_real.launch
```

当前关键默认值是：

```text
odometry_topic=/vins_fusion/imu_propagate
lidar_topic=/cloud_registered_360
planner_pointcloud_topic=/cloud_registered_360
publish_odom_tf=false
traj_server_en=true
```

## 这次迁移里已经确认的逻辑

### 返航逻辑

工程里有两类返航：

1. 时间返航
2. 距离返航

它们最后都可能进入 homing，但入口不一样。

### 时间返航

由 `gbplanner` 内部的 `HomingCheck` 决定，触发后会走：

```text
gbplanner/homing
```

然后执行 homepath。

### 距离返航

由 `planner_control_interface` 统计累计距离触发。

如果距离到阈值，PCI 会请求 homing。

### 为什么有时会“回到家后又往前探索一点”

这通常和两点有关：

- 距离返航触发后，当前路径还没自然收完
- 返航结束后又回到了自动探索状态

时间返航之所以更“干净”，是因为它更接近 planner 内部的 homing 状态闭环。

## 以后迁移到其他类似无人机时怎么做

### 第一步：先确认 3 个核心话题

先看这三个话题是否存在：

```text
rostopic info /你的里程计话题
rostopic info /你的点云话题
rostopic info /你的控制器输入话题
```

你需要知道：

- 里程计话题名
- 点云话题名
- 控制器接收的是轨迹还是位置指令

### 第二步：先确认 TF

重点确认：

- 里程计的父子坐标系
- 点云的 `frame_id`
- world / map / camera_init / body 是否一致

### 第三步：改 launch 接线

通常只需要改这些：

- `odometry_topic`
- `lidar_topic`
- `planner_pointcloud_topic`
- `publish_odom_tf`
- `odom_parent_frame`
- `odom_child_frame`
- `fix_pointcloud_frame`
- `lidar_frame_id`
- `traj_server_en`

### 第四步：确认控制链路

如果控制器吃的是 `PositionCommand`：

- 保留 `traj_server_node`
- 让 `pci_general` 继续发轨迹

如果控制器本来就吃轨迹：

- 也许可以不需要 `traj_server_node`
- 但要先确认消息类型一致

### 第五步：确认返航配置

要分别检查：

- 时间返航阈值
- 距离返航阈值
- homing path 是否可生成
- homing 结束后是否还会继续自动探索

## 一句话版结论

实机部署时，最关键的是把三条链路接对：

```text
定位 -> 规划
点云 -> 地图/规划
轨迹 -> 控制器
```

只要这三条线对了，后面改机型通常就是换话题名和 TF 名字。
