;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_srv)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_srv (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_SRV")
  (make-package "PLANNER_MSGS::PLANNER_SRV"))
(unless (find-package "PLANNER_MSGS::PLANNER_SRVREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_SRVREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_SRVRESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_SRVRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(intern "*KEXTENDEDBOUND*" (find-package "PLANNER_MSGS::PLANNER_SRVREQUEST"))
(shadow '*KEXTENDEDBOUND* (find-package "PLANNER_MSGS::PLANNER_SRVREQUEST"))
(defconstant planner_msgs::planner_srvRequest::*KEXTENDEDBOUND* 0)
(intern "*KRELAXEDBOUND*" (find-package "PLANNER_MSGS::PLANNER_SRVREQUEST"))
(shadow '*KRELAXEDBOUND* (find-package "PLANNER_MSGS::PLANNER_SRVREQUEST"))
(defconstant planner_msgs::planner_srvRequest::*KRELAXEDBOUND* 1)
(intern "*KMINBOUND*" (find-package "PLANNER_MSGS::PLANNER_SRVREQUEST"))
(shadow '*KMINBOUND* (find-package "PLANNER_MSGS::PLANNER_SRVREQUEST"))
(defconstant planner_msgs::planner_srvRequest::*KMINBOUND* 2)
(intern "*KEXACTBOUND*" (find-package "PLANNER_MSGS::PLANNER_SRVREQUEST"))
(shadow '*KEXACTBOUND* (find-package "PLANNER_MSGS::PLANNER_SRVREQUEST"))
(defconstant planner_msgs::planner_srvRequest::*KEXACTBOUND* 3)
(intern "*KNOBOUND*" (find-package "PLANNER_MSGS::PLANNER_SRVREQUEST"))
(shadow '*KNOBOUND* (find-package "PLANNER_MSGS::PLANNER_SRVREQUEST"))
(defconstant planner_msgs::planner_srvRequest::*KNOBOUND* 4)

(defun planner_msgs::planner_srvRequest-to-symbol (const)
  (cond
        ((= const 0) 'planner_msgs::planner_srvRequest::*kExtendedBound*)
        ((= const 1) 'planner_msgs::planner_srvRequest::*kRelaxedBound*)
        ((= const 2) 'planner_msgs::planner_srvRequest::*kMinBound*)
        ((= const 3) 'planner_msgs::planner_srvRequest::*kExactBound*)
        ((= const 4) 'planner_msgs::planner_srvRequest::*kNoBound*)
        (t nil)))

(defclass planner_msgs::planner_srvRequest
  :super ros::object
  :slots (_header _bound_mode _root_pose ))

(defmethod planner_msgs::planner_srvRequest
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:bound_mode __bound_mode) 0)
    ((:root_pose __root_pose) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _bound_mode (round __bound_mode))
   (setq _root_pose __root_pose)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:bound_mode
   (&optional __bound_mode)
   (if __bound_mode (setq _bound_mode __bound_mode)) _bound_mode)
  (:root_pose
   (&rest __root_pose)
   (if (keywordp (car __root_pose))
       (send* _root_pose __root_pose)
     (progn
       (if __root_pose (setq _root_pose (car __root_pose)))
       _root_pose)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _bound_mode
    4
    ;; geometry_msgs/Pose _root_pose
    (send _root_pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _bound_mode
       (write-long _bound_mode s)
     ;; geometry_msgs/Pose _root_pose
       (send _root_pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _bound_mode
     (setq _bound_mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Pose _root_pose
     (send _root_pose :deserialize buf ptr-) (incf ptr- (send _root_pose :serialization-length))
   ;;
   self)
  )

(intern "*KFORWARD*" (find-package "PLANNER_MSGS::PLANNER_SRVRESPONSE"))
(shadow '*KFORWARD* (find-package "PLANNER_MSGS::PLANNER_SRVRESPONSE"))
(defconstant planner_msgs::planner_srvResponse::*KFORWARD* 0)
(intern "*KBACKWARD*" (find-package "PLANNER_MSGS::PLANNER_SRVRESPONSE"))
(shadow '*KBACKWARD* (find-package "PLANNER_MSGS::PLANNER_SRVRESPONSE"))
(defconstant planner_msgs::planner_srvResponse::*KBACKWARD* 1)
(intern "*KHOMING*" (find-package "PLANNER_MSGS::PLANNER_SRVRESPONSE"))
(shadow '*KHOMING* (find-package "PLANNER_MSGS::PLANNER_SRVRESPONSE"))
(defconstant planner_msgs::planner_srvResponse::*KHOMING* 2)
(intern "*KREPOSITIONING*" (find-package "PLANNER_MSGS::PLANNER_SRVRESPONSE"))
(shadow '*KREPOSITIONING* (find-package "PLANNER_MSGS::PLANNER_SRVRESPONSE"))
(defconstant planner_msgs::planner_srvResponse::*KREPOSITIONING* 3)

(defun planner_msgs::planner_srvResponse-to-symbol (const)
  (cond
        ((= const 0) 'planner_msgs::planner_srvResponse::*kForward*)
        ((= const 1) 'planner_msgs::planner_srvResponse::*kBackward*)
        ((= const 2) 'planner_msgs::planner_srvResponse::*kHoming*)
        ((= const 3) 'planner_msgs::planner_srvResponse::*kRepositioning*)
        (t nil)))

(defclass planner_msgs::planner_srvResponse
  :super ros::object
  :slots (_status _planning_bound_mode _path ))

(defmethod planner_msgs::planner_srvResponse
  (:init
   (&key
    ((:status __status) 0)
    ((:planning_bound_mode __planning_bound_mode) 0)
    ((:path __path) ())
    )
   (send-super :init)
   (setq _status (round __status))
   (setq _planning_bound_mode (round __planning_bound_mode))
   (setq _path __path)
   self)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:planning_bound_mode
   (&optional __planning_bound_mode)
   (if __planning_bound_mode (setq _planning_bound_mode __planning_bound_mode)) _planning_bound_mode)
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
    ;; int32 _status
    4
    ;; int32 _planning_bound_mode
    4
    ;; geometry_msgs/Pose[] _path
    (apply #'+ (send-all _path :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _status
       (write-long _status s)
     ;; int32 _planning_bound_mode
       (write-long _planning_bound_mode s)
     ;; geometry_msgs/Pose[] _path
     (write-long (length _path) s)
     (dolist (elem _path)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _status
     (setq _status (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _planning_bound_mode
     (setq _planning_bound_mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
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

(defclass planner_msgs::planner_srv
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_srv :md5sum-) "a3f85517a01be073ddd96543af02aefb")
(setf (get planner_msgs::planner_srv :datatype-) "planner_msgs/planner_srv")
(setf (get planner_msgs::planner_srv :request) planner_msgs::planner_srvRequest)
(setf (get planner_msgs::planner_srv :response) planner_msgs::planner_srvResponse)

(defmethod planner_msgs::planner_srvRequest
  (:response () (instance planner_msgs::planner_srvResponse :init)))

(setf (get planner_msgs::planner_srvRequest :md5sum-) "a3f85517a01be073ddd96543af02aefb")
(setf (get planner_msgs::planner_srvRequest :datatype-) "planner_msgs/planner_srvRequest")
(setf (get planner_msgs::planner_srvRequest :definition-)
      "# Request the planner to run and return a path
Header header

# Set the bound mode of the robot to use in planner.
# Use extension to actual size. (default)
int32 kExtendedBound = 0
int32 kRelaxedBound = 1
int32 kMinBound = 2
int32 kExactBound = 3
int32 kNoBound = 4
# Can only be used with one of above values. Check Params/BoundModeType for more details.
int32 bound_mode

# Set root pose if requires the planner starts planning from this root.
# Otherwise, set all to zero, planner will start at robot's current state.
geometry_msgs/Pose root_pose

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
int32 kForward = 0
int32 kBackward = 1
int32 kHoming = 2
int32 kRepositioning = 3
# Status of the best path, take one of the above values.
int32 status

# Return actual bound mode used for planning
int32 planning_bound_mode

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

(setf (get planner_msgs::planner_srvResponse :md5sum-) "a3f85517a01be073ddd96543af02aefb")
(setf (get planner_msgs::planner_srvResponse :datatype-) "planner_msgs/planner_srvResponse")
(setf (get planner_msgs::planner_srvResponse :definition-)
      "# Request the planner to run and return a path
Header header

# Set the bound mode of the robot to use in planner.
# Use extension to actual size. (default)
int32 kExtendedBound = 0
int32 kRelaxedBound = 1
int32 kMinBound = 2
int32 kExactBound = 3
int32 kNoBound = 4
# Can only be used with one of above values. Check Params/BoundModeType for more details.
int32 bound_mode

# Set root pose if requires the planner starts planning from this root.
# Otherwise, set all to zero, planner will start at robot's current state.
geometry_msgs/Pose root_pose

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
int32 kForward = 0
int32 kBackward = 1
int32 kHoming = 2
int32 kRepositioning = 3
# Status of the best path, take one of the above values.
int32 status

# Return actual bound mode used for planning
int32 planning_bound_mode

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



(provide :planner_msgs/planner_srv "a3f85517a01be073ddd96543af02aefb")


