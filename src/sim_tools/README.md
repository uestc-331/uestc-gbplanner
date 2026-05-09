# sim_tools
用于无人机仿真的妙妙工具

## 使用说明(仅python)

### 启动解锁-offboard控制器，键盘按键直接控制无人机模式
`rosrun sim_tools arm.py`

### 启动仿真里程计(全版)--可在launch中修改无人机数量和类型，默认为iris 1架
`roslaunch sim_tools get_real_pose.launch`

### 启动仿真里程计(仅iris odom版)
`rosrun sim_tools get_iris_pose.py`

### 启动模拟遥控器（仅拨杆）
`rosrun sim_tools sim_remote.py`
