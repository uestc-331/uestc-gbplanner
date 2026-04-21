;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::Graph)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'Graph (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::GRAPH")
  (make-package "PLANNER_MSGS::GRAPH"))

(in-package "ROS")
;;//! \htmlinclude Graph.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass planner_msgs::Graph
  :super ros::object
  :slots (_header _vertices _edges ))

(defmethod planner_msgs::Graph
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:vertices __vertices) ())
    ((:edges __edges) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _vertices __vertices)
   (setq _edges __edges)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:vertices
   (&rest __vertices)
   (if (keywordp (car __vertices))
       (send* _vertices __vertices)
     (progn
       (if __vertices (setq _vertices (car __vertices)))
       _vertices)))
  (:edges
   (&rest __edges)
   (if (keywordp (car __edges))
       (send* _edges __edges)
     (progn
       (if __edges (setq _edges (car __edges)))
       _edges)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; planner_msgs/Vertex[] _vertices
    (apply #'+ (send-all _vertices :serialization-length)) 4
    ;; planner_msgs/Edge[] _edges
    (apply #'+ (send-all _edges :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; planner_msgs/Vertex[] _vertices
     (write-long (length _vertices) s)
     (dolist (elem _vertices)
       (send elem :serialize s)
       )
     ;; planner_msgs/Edge[] _edges
     (write-long (length _edges) s)
     (dolist (elem _edges)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; planner_msgs/Vertex[] _vertices
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _vertices (let (r) (dotimes (i n) (push (instance planner_msgs::Vertex :init) r)) r))
     (dolist (elem- _vertices)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; planner_msgs/Edge[] _edges
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _edges (let (r) (dotimes (i n) (push (instance planner_msgs::Edge :init) r)) r))
     (dolist (elem- _edges)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get planner_msgs::Graph :md5sum-) "0f1eb1d0b23f9055c17c609dc10e68a8")
(setf (get planner_msgs::Graph :datatype-) "planner_msgs/Graph")
(setf (get planner_msgs::Graph :definition-)
      "Header header
planner_msgs/Vertex[] vertices
planner_msgs/Edge[] edges
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: planner_msgs/Vertex
int32 id
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

================================================================================
MSG: planner_msgs/Edge
int32 source_id
int32 target_id
float32 weight
")



(provide :planner_msgs/Graph "0f1eb1d0b23f9055c17c609dc10e68a8")


