;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::Vertex)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'Vertex (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::VERTEX")
  (make-package "PLANNER_MSGS::VERTEX"))

(in-package "ROS")
;;//! \htmlinclude Vertex.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass planner_msgs::Vertex
  :super ros::object
  :slots (_id _pose _num_unknown_voxels _num_occupied_voxels _num_free_voxels _is_frontier ))

(defmethod planner_msgs::Vertex
  (:init
   (&key
    ((:id __id) 0)
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    ((:num_unknown_voxels __num_unknown_voxels) 0)
    ((:num_occupied_voxels __num_occupied_voxels) 0)
    ((:num_free_voxels __num_free_voxels) 0)
    ((:is_frontier __is_frontier) nil)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _pose __pose)
   (setq _num_unknown_voxels (round __num_unknown_voxels))
   (setq _num_occupied_voxels (round __num_occupied_voxels))
   (setq _num_free_voxels (round __num_free_voxels))
   (setq _is_frontier __is_frontier)
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:num_unknown_voxels
   (&optional __num_unknown_voxels)
   (if __num_unknown_voxels (setq _num_unknown_voxels __num_unknown_voxels)) _num_unknown_voxels)
  (:num_occupied_voxels
   (&optional __num_occupied_voxels)
   (if __num_occupied_voxels (setq _num_occupied_voxels __num_occupied_voxels)) _num_occupied_voxels)
  (:num_free_voxels
   (&optional __num_free_voxels)
   (if __num_free_voxels (setq _num_free_voxels __num_free_voxels)) _num_free_voxels)
  (:is_frontier
   (&optional (__is_frontier :null))
   (if (not (eq __is_frontier :null)) (setq _is_frontier __is_frontier)) _is_frontier)
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ;; int32 _num_unknown_voxels
    4
    ;; int32 _num_occupied_voxels
    4
    ;; int32 _num_free_voxels
    4
    ;; bool _is_frontier
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;; int32 _num_unknown_voxels
       (write-long _num_unknown_voxels s)
     ;; int32 _num_occupied_voxels
       (write-long _num_occupied_voxels s)
     ;; int32 _num_free_voxels
       (write-long _num_free_voxels s)
     ;; bool _is_frontier
       (if _is_frontier (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; int32 _num_unknown_voxels
     (setq _num_unknown_voxels (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _num_occupied_voxels
     (setq _num_occupied_voxels (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _num_free_voxels
     (setq _num_free_voxels (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _is_frontier
     (setq _is_frontier (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get planner_msgs::Vertex :md5sum-) "663034a815fe27eaa71d6d6b0f8b9b78")
(setf (get planner_msgs::Vertex :datatype-) "planner_msgs/Vertex")
(setf (get planner_msgs::Vertex :definition-)
      "int32 id
geometry_msgs/Pose pose

# For volumetric gain
int32 num_unknown_voxels
int32 num_occupied_voxels
int32 num_free_voxels
bool is_frontier
================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :planner_msgs/Vertex "663034a815fe27eaa71d6d6b0f8b9b78")


