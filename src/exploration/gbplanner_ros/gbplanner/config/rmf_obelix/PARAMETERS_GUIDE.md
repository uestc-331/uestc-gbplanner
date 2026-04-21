# GBPlanner 参数配置指南

本文档说明规划器运行过程中涉及的关键参数配置文件。

## 主要配置文件

1. **gbplanner_config.yaml** - 规划器主配置文件
2. **voxblox_sim_config.yaml** - 地图构建（Voxblox）配置文件
3. **planner_control_interface_sim_config.yaml** - 规划控制接口配置文件

---

## 1. 无人机尺寸参数 (gbplanner_config.yaml)

### RobotParams 部分

```yaml
RobotParams:
  type:               kAerialRobot
  size:               [0.2, 0.2, 0.2]  # 无人机实际尺寸 [x, y, z] (米)
  size_extension_min: [0.1, 0.1, 0.1]  # 最小扩展尺寸，允许操作的最小空间
  size_extension:     [0.2, 0.2, 0.2]  # 最大扩展尺寸，规划时允许的最大空间
  center_offset:      [0.0, 0.0, 0.0]  # 中心偏移量
  relax_ratio:        0.5               # 在 size_extension_min 和 size_extension 之间的中间值比例
  safety_extension:   [3.0, 4.0, 3.0]  # 安全扩展，用于路径段边界框外推，使路径远离障碍物
```

**关键参数说明：**
- `size`: 无人机的实际物理尺寸
- `safety_extension`: **路径距离墙壁的安全距离**，用于将路径推离障碍物
  - [3.0, 4.0, 3.0] 表示在 x, y, z 方向上分别保持 3.0m, 4.0m, 3.0m 的安全距离

---

## 2. 探索点生成尺寸 (gbplanner_config.yaml)

### BoundedSpaceParams 部分

```yaml
BoundedSpaceParams:
  Global:              # 全局探索空间
    type:           kCuboid
    min_val:        [-3000.0, -3000.0, -300.0]
    max_val:        [3000.0, 3000.0, 300.0]
  
  Local:              # 局部规划空间（探索点生成范围）
    type:           kCuboid
    min_val:        [-15.0, -15.0, -3.0]    # 局部空间最小值 [x, y, z]
    max_val:        [15.0, 15.0, 3.0]       # 局部空间最大值 [x, y, z]
    min_extension:  [-20.0, -20.0, -20.0]   # 最小扩展范围
    max_extension:  [20.0, 20.0, 20.0]     # 最大扩展范围
  
  LocalSearch:       # 局部搜索空间
    type:           kCuboid
    min_val:        [-50.0, -50.0, -1.0]
    max_val:        [50.0, 50.0, 1.0]
  
  LocalAdaptiveExp:  # 自适应探索空间
    type:           kCuboid
    min_val:        [-10.0, -10.0, -0.75]
    max_val:        [10.0, 10.0, 0.75]
```

**关键参数说明：**
- `Local`: **探索点生成的主要空间范围**
  - `min_val` / `max_val`: 定义局部空间的边界
  - 当前设置：±15m (x, y), ±3m (z)
- `LocalSearch`: 用于搜索的更大范围空间

---

## 3. 路径平滑和墙壁距离 (gbplanner_config.yaml)

### PlanningParams 部分

```yaml
PlanningParams:
  path_safety_enhance_enable: true      # 启用路径安全增强（推离障碍物）
  path_interpolation_distance: 0.5     # 路径插值距离（米），用于路径平滑
  edge_length_min:  0.2                # 最小边长度（米）
  edge_length_max:  2.0                # 最大边长度（米）
  nearest_range:    2.0                 # 新顶点连接现有顶点的最大范围（米）
  clustering_radius: 0.5               # 顶点聚类半径（米），用于增益计算
```

**关键参数说明：**
- `path_safety_enhance_enable`: 启用后，路径会被推离障碍物（使用 `safety_extension` 参数）
- `path_interpolation_distance`: **路径平滑的插值距离**，值越小路径越平滑但计算量越大
- `edge_length_min/max`: 控制路径段的长度范围

### RobotParams 中的安全距离

```yaml
safety_extension: [3.0, 4.0, 3.0]  # 路径距离墙壁的安全距离 [x, y, z] (米)
```

**这是控制路径距离墙壁距离的主要参数！**

---

## 4. 地图构建参数 (voxblox_sim_config.yaml)

```yaml
tsdf_voxel_size: 0.20              # TSDF 体素大小（米），影响地图分辨率
truncation_distance: 0.6           # 截断距离（米），影响障碍物边界的平滑度
esdf_max_distance_m: 2.0          # ESDF 最大距离（米），用于距离场计算
clear_sphere_radius: 0.8          # 清除球半径（米），用于规划时的空间清除
traversability_radius: 0.4        # 可穿越性半径（米）
```

**关键参数说明：**
- `tsdf_voxel_size`: 体素大小，影响地图精度和计算量
- `truncation_distance`: 影响障碍物边界的表示精度
- `esdf_max_distance_m`: 距离场的最大计算距离

---

## 5. 路径平滑参数 (planner_control_interface_sim_config.yaml)

```yaml
smooth_heading_enable: true       # 启用航向角平滑
RobotDynamics:
  v_max: 1.0                      # 最大速度 (m/s)
  v_homing_max: 0.9               # 返航最大速度 (m/s)
  yaw_rate_max: 0.15              # 最大角速度 (rad/s)
  dt: 0.05                        # 时间步长 (秒)
```

---

## 6. 探索相关参数 (gbplanner_config.yaml)

```yaml
PlanningParams:
  unknown_voxel_gain: 60.0        # 未知体素增益，探索未知区域的权重
  path_length_penalty: 0.04       # 路径长度惩罚，偏好更短的路径
  path_direction_penalty: 0.1     # 路径方向惩罚
  traverse_length_max: 8.0        # 最大遍历长度（米），路径会被截断到此长度
  num_vertices_max: 700           # 图构建的最大顶点数
  num_edges_max: 9000             # 图构建的最大边数
```

---

## 快速调整指南

### 增加路径距离墙壁的距离
修改 `gbplanner_config.yaml` 中的：
```yaml
RobotParams:
  safety_extension: [3.0, 4.0, 3.0]  # 增加这些值，例如 [4.0, 5.0, 4.0]
```

### 调整探索点生成范围
修改 `gbplanner_config.yaml` 中的：
```yaml
BoundedSpaceParams:
  Local:
    min_val: [-15.0, -15.0, -3.0]  # 调整这些值
    max_val: [15.0, 15.0, 3.0]
```

### 调整路径平滑度
修改 `gbplanner_config.yaml` 中的：
```yaml
PlanningParams:
  path_interpolation_distance: 0.5  # 减小此值使路径更平滑（但计算量更大）
```

### 调整无人机尺寸
修改 `gbplanner_config.yaml` 中的：
```yaml
RobotParams:
  size: [0.2, 0.2, 0.2]  # 根据实际无人机尺寸修改
```

---

## 配置文件位置

- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/gbplanner_config.yaml`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/voxblox_sim_config.yaml`
- `src/exploration/gbplanner_ros/gbplanner/config/rmf_obelix/planner_control_interface_sim_config.yaml`

