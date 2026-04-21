;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_go_to_waypoint)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_go_to_waypoint (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_GO_TO_WAYPOINT")
  (make-package "PLANNER_MSGS::PLANNER_GO_TO_WAYPOINT"))
(unless (find-package "PLANNER_MSGS::PLANNER_GO_TO_WAYPOINTREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_GO_TO_WAYPOINTREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_GO_TO_WAYPOINTRESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_GO_TO_WAYPOINTRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass planner_msgs::planner_go_to_waypointRequest
  :super ros::object
  :slots (_check_collision _waypoint ))

(defmethod planner_msgs::planner_go_to_waypointRequest
  (:init
   (&key
    ((:check_collision __check_collision) nil)
    ((:waypoint __waypoint) (instance geometry_msgs::PoseStamped :init))
    )
   (send-super :init)
   (setq _check_collision __check_collision)
   (setq _waypoint __waypoint)
   self)
  (:check_collision
   (&optional (__check_collision :null))
   (if (not (eq __check_collision :null)) (setq _check_collision __check_collision)) _check_collision)
  (:waypoint
   (&rest __waypoint)
   (if (keywordp (car __waypoint))
       (send* _waypoint __waypoint)
     (progn
       (if __waypoint (setq _waypoint (car __waypoint)))
       _waypoint)))
  (:serialization-length
   ()
   (+
    ;; bool _check_collision
    1
    ;; geometry_msgs/PoseStamped _waypoint
    (send _waypoint :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _check_collision
       (if _check_collision (write-byte -1 s) (write-byte 0 s))
     ;; geometry_msgs/PoseStamped _waypoint
       (send _waypoint :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _check_collision
     (setq _check_collision (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; geometry_msgs/PoseStamped _waypoint
     (send _waypoint :deserialize buf ptr-) (incf ptr- (send _waypoint :serialization-length))
   ;;
   self)
  )

(defclass planner_msgs::planner_go_to_waypointResponse
  :super ros::object
  :slots (_path ))

(defmethod planner_msgs::planner_go_to_waypointResponse
  (:init
   (&key
    ((:path __path) ())
    )
   (send-super :init)
   (setq _path __path)
   self)
  (:path
   (&rest __path)
   (if (keywordp (car __path))
       (send* _path __path)
     (progn
       (if __path (setq _path (car __path)))
       _path)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose[] _path
    (apply #'+ (send-all _path :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose[] _path
     (write-long (length _path) s)
     (dolist (elem _path)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose[] _path
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _path (let (r) (dotimes (i n) (push (instance geometry_msgs::Pose :init) r)) r))
     (dolist (elem- _path)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass planner_msgs::planner_go_to_waypoint
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_go_to_waypoint :md5sum-) "a26081f4c02132c8e0c868df86f2d5fe")
(setf (get planner_msgs::planner_go_to_waypoint :datatype-) "planner_msgs/planner_go_to_waypoint")
(setf (get planner_msgs::planner_go_to_waypoint :request) planner_msgs::planner_go_to_waypointRequest)
(setf (get planner_msgs::planner_go_to_waypoint :response) planner_msgs::planner_go_to_waypointResponse)

(defmethod planner_msgs::planner_go_to_waypointRequest
  (:response () (instance planner_msgs::planner_go_to_waypointResponse :init)))

(setf (get planner_msgs::planner_go_to_waypointRequest :md5sum-) "a26081f4c02132c8e0c868df86f2d5fe")
(setf (get planner_msgs::planner_go_to_waypointRequest :datatype-) "planner_msgs/planner_go_to_waypointRequest")
(setf (get planner_msgs::planner_go_to_waypointRequest :definition-)
      "bool check_collision
geometry_msgs/PoseStamped waypoint

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

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
---
# Return best path.
geometry_msgs/Pose[] path


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

(setf (get planner_msgs::planner_go_to_waypointResponse :md5sum-) "a26081f4c02132c8e0c868df86f2d5fe")
(setf (get planner_msgs::planner_go_to_waypointResponse :datatype-) "planner_msgs/planner_go_to_waypointResponse")
(setf (get planner_msgs::planner_go_to_waypointResponse :definition-)
      "bool check_collision
geometry_msgs/PoseStamped waypoint

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

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
---
# Return best path.
geometry_msgs/Pose[] path


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



(provide :planner_msgs/planner_go_to_waypoint "a26081f4c02132c8e0c868df86f2d5fe")


