# uestc-gbplanner2
# 编译
catkin build

# 运行
## step1:探索节点
### 仿真(运行这个)
roslaunch gbplanner rmf_sim.launch
### 实机（运行这个）
roslaunch gbplanner rmf_real_robot.launch
## step2:>>从机<< 打开rviz,大概位置：src/exploration/gbplanner_ros/gbplanner/config/rviz/rmf_obelix.rviz
rviz
## step3:开始探索：终端输入1；停止：终端输入2；退出：终端输入3
rosrun gbplanner_ui gbplanner_cli


