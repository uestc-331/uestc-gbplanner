;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_homing)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_homing (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_HOMING")
  (make-package "PLANNER_MSGS::PLANNER_HOMING"))
(unless (find-package "PLANNER_MSGS::PLANNER_HOMINGREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_HOMINGREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_HOMINGRESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_HOMINGRESPONSE"))

(in-package "ROS")

(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass planner_msgs::planner_homingRequest
  :super ros::object
  :slots (_header ))

(defmethod planner_msgs::planner_homingRequest
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    )
   (send-super :init)
   (setq _header __header)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;;
   self)
  )

(defclass planner_msgs::planner_homingResponse
  :super ros::object
  :slots (_path ))

(defmethod planner_msgs::planner_homingResponse
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

(defclass planner_msgs::planner_homing
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_homing :md5sum-) "0e9a67b6e01ddd6d303ae107f62349a1")
(setf (get planner_msgs::planner_homing :datatype-) "planner_msgs/planner_homing")
(setf (get planner_msgs::planner_homing :request) planner_msgs::planner_homingRequest)
(setf (get planner_msgs::planner_homing :response) planner_msgs::planner_homingResponse)

(defmethod planner_msgs::planner_homingRequest
  (:response () (instance planner_msgs::planner_homingResponse :init)))

(setf (get planner_msgs::planner_homingRequest :md5sum-) "0e9a67b6e01ddd6d303ae107f62349a1")
(setf (get planner_msgs::planner_homingRequest :datatype-) "planner_msgs/planner_homingRequest")
(setf (get planner_msgs::planner_homingRequest :definition-)
      "# Request the planner get the shortest path to go home.
Header header

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
---
# Return shortest path to go home.
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

(setf (get planner_msgs::planner_homingResponse :md5sum-) "0e9a67b6e01ddd6d303ae107f62349a1")
(setf (get planner_msgs::planner_homingResponse :datatype-) "planner_msgs/planner_homingResponse")
(setf (get planner_msgs::planner_homingResponse :definition-)
      "# Request the planner get the shortest path to go home.
Header header

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
---
# Return shortest path to go home.
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



(provide :planner_msgs/planner_homing "0e9a67b6e01ddd6d303ae107f62349a1")


