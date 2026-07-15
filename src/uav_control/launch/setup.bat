<launch>
  <arg name="ref_points_topic" value="/travel/ref_point_sub"/>

  <node pkg="uav_control" name="uav_control_node" type="uav_control_node" output="screen" launch-prefix="gdb -ex run --args">
    <!-- remap 和 rosparam 与之前相同 -->
    <remap from="/camera/color/image_raw" to="/iris_0/realsense/depth_camera/color/image_raw"/>
    <remap from="/ref_point_topic" to="$(arg ref_points_topic)"/>
    <rosparam command="load" file="$(find uav_control)/config/circle_setting.yaml" />
  </node>
</launch>
