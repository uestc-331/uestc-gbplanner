# "Start Planner" 按钮点击流程详解

## 概述
当你在RViz中点击 **"Start Planner"** 按钮时，会触发一系列服务调用和消息传递，最终启动自动探索规划。

## 完整流程

### 1. RViz插件层（gbplanner_ui）

**文件位置：** `src/exploration/gbplanner_ros/gbplanner_ui/src/gbplanner_ui.cpp`

**代码：**
```cpp
void gbplanner_panel::on_start_planner_click() {
  std_srvs::Trigger srv;  // 创建Trigger服务请求（无参数）
  if (!planner_client_start_planner.call(srv)) {
    ROS_ERROR("[GBPLANNER-UI] Service call failed: %s",
              planner_client_start_planner.getService().c_str());
  }
}
```

**发送的服务：**
- **服务名称：** `/planner_control_interface/std_srvs/automatic_planning`
- **服务类型：** `std_srvs::Trigger`
- **请求内容：** 空（Trigger服务不需要参数）
- **响应内容：** `success: bool, message: string`

---

### 2. 规划控制接口层（PlannerControlInterface）

**文件位置：** `src/exploration/gbplanner_ros/planner_control_interface/src/planner_control_interface.cpp`

**服务回调函数：** `stdSrvsAutomaticPlanningCallback` (第428-441行)

**处理逻辑：**
```cpp
bool PlannerControlInterface::stdSrvsAutomaticPlanningCallback(
    std_srvs::Trigger::Request& req, 
    std_srvs::Trigger::Response& res) {
  
  // 创建内部触发请求
  planner_msgs::pci_trigger::Request pci_trigger_request;
  planner_msgs::pci_trigger::Response pci_trigger_response;
  
  // 设置参数
  pci_trigger_request.not_exe_path = false;      // 执行路径
  pci_trigger_request.set_auto = true;            // 设置为自动模式
  pci_trigger_request.bound_mode = 0;            // 边界模式：扩展边界
  pci_trigger_request.vel_max = 0.0;             // 最大速度（0.0表示使用默认值）
  
  // 调用内部触发回调
  res.success = triggerCallback(pci_trigger_request, pci_trigger_response);
  res.success &= pci_trigger_response.success;
  
  return true;
}
```

**关键操作：**
1. ✅ 设置 `trigger_mode_ = PlannerTriggerModeType::kAuto`（自动模式）
2. ✅ 设置 `run_en_ = true`（允许运行）
3. ✅ 设置 `exe_path_en_ = true`（执行路径）
4. ✅ 设置 `bound_mode_ = 0`（扩展边界模式）

---

### 3. 触发回调处理（triggerCallback）

**文件位置：** 同上，第399-426行

**处理逻辑：**
```cpp
bool PlannerControlInterface::triggerCallback(
    planner_msgs::pci_trigger::Request& req,
    planner_msgs::pci_trigger::Response& res) {
  
  // 检查PCI状态
  if (pci_manager_->getStatus() == PCIManager::PCIStatus::kError) {
    ROS_WARN("PCIManager is currently in error state...");
    res.success = false;
    return true;
  }
  
  // 切换触发模式
  if (req.set_auto) {
    trigger_mode_ = PlannerTriggerModeType::kAuto;  // 自动模式
    ROS_WARN("Switch to auto mode.");
  } else {
    trigger_mode_ = PlannerTriggerModeType::kManual; // 手动模式
  }
  
  // 设置参数
  pci_manager_->setVelocity(req.vel_max);  // 设置最大速度
  bound_mode_ = req.bound_mode;            // 设置边界模式
  run_en_ = true;                          // 允许运行
  exe_path_en_ = !req.not_exe_path;        // 是否执行路径
  
  res.success = true;
  return true;
}
```

---

### 4. 主循环处理（run函数）

**文件位置：** 同上，第534-602行

**处理逻辑：**
```cpp
void PlannerControlInterface::run() {
  ros::Rate rr(10);  // 10Hz循环
  while (ros::ok()) {
    PCIManager::PCIStatus pci_status = pci_manager_->getStatus();
    
    if (pci_status == PCIManager::PCIStatus::kReady) {
      // 检查是否处于自动模式或手动触发
      if ((trigger_mode_ == PlannerTriggerModeType::kAuto) || (run_en_)) {
        run_en_ = false;  // 重置标志
        ROS_INFO("PlannerControlInterface: Running Planner (%s)",
                 trigger_mode_ == PlannerTriggerModeType::kAuto ? "kAuto" : "kManual");
        
        // 调用规划器
        runPlanner(exe_path_en_);
      }
    }
    
    ros::spinOnce();
    rr.sleep();
  }
}
```

---

### 5. 规划器执行（runPlanner）

**文件位置：** 同上，第694-775行

**处理逻辑：**
```cpp
void PlannerControlInterface::runPlanner(bool exe_path = false) {
  const int kBBoxLevel = 3;  // 尝试3种边界级别
  bool success = false;
  
  // 1. 设置规划模式
  planner_msgs::planner_set_planning_mode planning_mode_srv;
  if (trigger_mode_ == PlannerTriggerModeType::kAuto) {
    planning_mode_srv.request.planning_mode = 
        planner_msgs::planner_set_planning_mode::Request::kAuto;
  } else {
    planning_mode_srv.request.planning_mode = 
        planner_msgs::planner_set_planning_mode::Request::kManual;
  }
  planner_set_trigger_mode_client_.call(planning_mode_srv);
  
  // 2. 尝试不同边界级别（0, 1, 2）
  for (int ind = 0; ind < kBBoxLevel; ++ind) {
    bound_mode_ = ind;
    
    // 3. 调用gbplanner服务
    planner_msgs::planner_srv plan_srv;
    plan_srv.request.header.stamp = ros::Time::now();
    plan_srv.request.header.seq = planner_iteration_;
    plan_srv.request.header.frame_id = world_frame_id_;
    plan_srv.request.bound_mode = bound_mode_;
    plan_srv.request.root_pose = getPoseToStart();  // 获取起始姿态
    
    // 调用规划服务
    if (planner_client_.call(plan_srv)) {
      if (!plan_srv.response.path.empty()) {
        // 执行路径
        if (exe_path) {
          current_path_.clear();
          std::vector<geometry_msgs::Pose> path_to_be_exe;
          pci_manager_->executePath(plan_srv.response.path, path_to_be_exe,
                                    PCIManager::ExecutionPathType::kLocalPath);
          current_path_ = path_to_be_exe;
          success = true;
        }
      }
      planner_iteration_++;
      if (success) break;  // 成功则退出循环
    }
  }
}
```

**发送的服务：**
- **服务名称：** `planner_server`（映射到 `gbplanner`）
- **服务类型：** `planner_msgs::planner_srv`
- **请求内容：**
  ```cpp
  Header header              // 时间戳、序列号、坐标系
  int8 bound_mode            // 边界模式（0=扩展，1=中等，2=最小）
  geometry_msgs/Pose root_pose  // 起始姿态
  ```
- **响应内容：**
  ```cpp
  std_msgs/Header header
  geometry_msgs/Pose[] path  // 规划出的路径
  int8 status                // 状态（kForward, kBackward, kHoming等）
  ```

---

### 6. gbplanner节点处理（plannerServiceCallback）

**文件位置：** `src/exploration/gbplanner_ros/gbplanner/src/gbplanner.cpp`

**服务回调：** `plannerServiceCallback`

**处理逻辑：**
1. 接收规划请求
2. 调用RRG算法进行路径规划
3. 返回规划好的路径

**关键操作：**
- 构建局部图（RRG）
- 计算体积增益
- 选择最佳路径
- 返回路径点序列

---

### 7. 路径执行（executePath）

**文件位置：** `src/exploration/pci_general/src/pci_general.cpp`

**处理逻辑：**
```cpp
void PCIGeneral::executePath(
    const std::vector<geometry_msgs::Pose>& path,
    std::vector<geometry_msgs::Pose>& path_to_be_exe,
    PCIManager::ExecutionPathType path_type) {
  
  // 1. 路径平滑处理
  // 2. 发布轨迹消息
  trajectory_pub_.publish(trajectory);
  
  // 3. 发布路径可视化
  path_pub_.publish(path_array);
}
```

**发布的消息：**
- **话题名称：** `rmf_obelix/command/trajectory`（根据robot_name）
- **消息类型：** `trajectory_msgs::MultiDOFJointTrajectory`
- **内容：** 包含时间戳、位置、速度、加速度的轨迹点序列

---

## 消息流图

```
[RViz UI]
    |
    | 点击 "Start Planner" 按钮
    ↓
[gbplanner_ui插件]
    |
    | 服务调用: /planner_control_interface/std_srvs/automatic_planning
    | 类型: std_srvs::Trigger
    ↓
[PlannerControlInterface]
    |
    | 1. 设置 trigger_mode_ = kAuto
    | 2. 设置 run_en_ = true
    | 3. 在主循环中检测到自动模式
    ↓
[runPlanner函数]
    |
    | 1. 设置规划模式为 kAuto
    | 2. 调用服务: planner_server (gbplanner)
    | 类型: planner_msgs::planner_srv
    ↓
[gbplanner节点]
    |
    | 1. 接收规划请求
    | 2. 运行RRG算法
    | 3. 返回规划路径
    ↓
[executePath函数]
    |
    | 发布轨迹消息: rmf_obelix/command/trajectory
    | 类型: trajectory_msgs::MultiDOFJointTrajectory
    ↓
[无人机控制器]
    |
    | 执行轨迹，开始探索
```

---

## 关键服务和服务名称

### 1. 启动规划服务
- **服务名称：** `/planner_control_interface/std_srvs/automatic_planning`
- **服务类型：** `std_srvs::Trigger`
- **提供者：** `PlannerControlInterface` 节点

### 2. 规划服务
- **服务名称：** `planner_server`（映射到 `gbplanner`）
- **服务类型：** `planner_msgs::planner_srv`
- **提供者：** `gbplanner_node`

### 3. 设置规划模式服务
- **服务名称：** `/gbplanner/set_planning_trigger_mode`
- **服务类型：** `planner_msgs::planner_set_planning_mode`
- **提供者：** `gbplanner_node`

---

## 关键话题

### 1. 轨迹命令话题
- **话题名称：** `rmf_obelix/command/trajectory`（根据robot_name变化）
- **消息类型：** `trajectory_msgs::MultiDOFJointTrajectory`
- **发布者：** `pci_general_ros_node`
- **订阅者：** 无人机控制器

### 2. 路径可视化话题
- **话题名称：** `pci_command_path`
- **消息类型：** `geometry_msgs::PoseArray`
- **发布者：** `pci_general_ros_node`

### 3. 规划器状态话题
- **话题名称：** `gbplanner_status`
- **消息类型：** `std_msgs::Bool`
- **发布者：** `PlannerControlInterface`

---

## 关键参数设置

点击"Start Planner"后，系统会设置以下参数：

1. **触发模式：** `kAuto`（自动模式）
   - 在自动模式下，规划器会在路径执行完成后自动触发下一次规划

2. **边界模式：** `0`（扩展边界）
   - 0 = 扩展边界（最大探索范围）
   - 1 = 中等边界
   - 2 = 最小边界

3. **执行路径：** `true`
   - 规划出的路径会被执行

4. **最大速度：** `0.0`（使用默认值）
   - 如果设置为0.0，使用配置文件中的默认速度

---

## 自动模式 vs 手动模式

### 自动模式（kAuto）
- 路径执行完成后，自动触发下一次规划
- 持续探索直到手动停止或遇到错误
- 适合长时间自主探索任务

### 手动模式（kManual）
- 每次规划需要手动触发
- 适合精确控制场景

---

## 调试信息

### 查看服务调用
```bash
# 查看服务列表
rosservice list | grep planner_control_interface

# 手动调用服务测试
rosservice call /planner_control_interface/std_srvs/automatic_planning
```

### 查看话题数据
```bash
# 查看轨迹命令
rostopic echo /rmf_obelix/command/trajectory

# 查看规划器状态
rostopic echo /gbplanner_status

# 查看路径可视化
rostopic echo /pci_command_path
```

### 查看节点状态
```bash
# 查看所有节点
rosnode list

# 查看节点信息
rosnode info /pci_general_ros_node
rosnode info /gbplanner_node
```

---

## 常见问题

### Q1: 点击按钮后没有反应？
**检查：**
1. 服务是否可用：`rosservice list | grep automatic_planning`
2. PCI状态是否为kReady：查看日志
3. 是否有odometry数据：`rostopic echo /sim_odom`

### Q2: 规划失败？
**检查：**
1. 查看gbplanner节点日志
2. 检查地图数据是否正常
3. 检查边界设置是否合理

### Q3: 路径不执行？
**检查：**
1. 检查 `exe_path_en_` 是否为true
2. 检查轨迹话题是否有订阅者
3. 检查无人机控制器是否正常运行

---

## 总结

点击"Start Planner"按钮后：
1. ✅ 发送Trigger服务到 `/planner_control_interface/std_srvs/automatic_planning`
2. ✅ 设置系统为自动模式（kAuto）
3. ✅ 触发规划器运行（调用gbplanner服务）
4. ✅ 执行规划出的路径（发布轨迹消息）
5. ✅ 在自动模式下，路径执行完成后自动触发下一次规划

整个过程实现了从用户界面到路径执行的完整闭环。


