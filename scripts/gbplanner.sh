source /home/super/uestc-gbplanner/devel/setup.bash 
roslaunch gbplanner rmf_real_robot.launch & sleep 2;

rosrun gbplanner_ui gbplanner_cli
wait;