# 启动代码：
roslaunch gbplanner rmf_sim.launch


## 前提：XTDrone的通信部分每个终端都要激活conda环境
终端输入：conda activate guikong

# 1.打开仿真环境
cd ~/guikong
roslaunch px4 indoor3_gbplanner.launch

# 2.激活一台无人机的通信
cd  ~/guikong/XTDrone/communication
conda activate guikong
python multirotor_communication.py iris 0


# 3.接收一台无人机的位姿信息
cd ~/guikong/XTDrone/sensing/pose_ground_truth/
conda activate guikong
python get_local_pose.py iris 1

# 4.启动odom转换节点
cd ~/guikong/WJH/gbplanner2_ws_XTDrone/
source devel/setup.bash
roslaunch gbplanner rmf_sim.launch


# 5.打开RVIZ
cd ~/guikong/WJH/Fast-Exploration
source devel/setup.bash
roslaunch exploration_manager rviz.launch

# 6.启动无人机
cd ~/guikong/WJH/Fast-Exploration
source devel/setup.bash
roslaunch exploration_manager exploration.launch

# 7.启动控制程序
cd ~/guikong/WJH/Fast-Exploration
source devel/setup.bash
roslaunch px4ctrl singl_run.launch

# 8.启动监控器
cd ~/guikong/WJH/Fast-Exploration
source devel/setup.bash
roslaunch ftxui_ros single_start.launch




/iris_0/mavros/vision_odom/odom

/iris_0/position_cmd
