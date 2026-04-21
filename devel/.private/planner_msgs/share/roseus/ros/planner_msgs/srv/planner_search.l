;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_search)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_search (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_SEARCH")
  (make-package "PLANNER_MSGS::PLANNER_SEARCH"))
(unless (find-package "PLANNER_MSGS::PLANNER_SEARCHREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_SEARCHREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_SEARCHRESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_SEARCHRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(intern "*KEXTENDEDBOUND*" (find-package "PLANNER_MSGS::PLANNER_SEARCHREQUEST"))
(shadow '*KEXTENDEDBOUND* (find-package "PLANNER_MSGS::PLANNER_SEARCHREQUEST"))
(defconstant planner_msgs::planner_searchRequest::*KEXTENDEDBOUND* 0)
(intern "*KRELAXEDBOUND*" (find-package "PLANNER_MSGS::PLANNER_SEARCHREQUEST"))
(shadow '*KRELAXEDBOUND* (find-package "PLANNER_MSGS::PLANNER_SEARCHREQUEST"))
(defconstant planner_msgs::planner_searchRequest::*KRELAXEDBOUND* 1)
(intern "*KMINBOUND*" (find-package "PLANNER_MSGS::PLANNER_SEARCHREQUEST"))
(shadow '*KMINBOUND* (find-package "PLANNER_MSGS::PLANNER_SEARCHREQUEST"))
(defconstant planner_msgs::planner_searchRequest::*KMINBOUND* 2)
(intern "*KEXACTBOUND*" (find-package "PLANNER_MSGS::PLANNER_SEARCHREQUEST"))
(shadow '*KEXACTBOUND* (find-package "PLANNER_MSGS::PLANNER_SEARCHREQUEST"))
(defconstant planner_msgs::planner_searchRequest::*KEXACTBOUND* 3)
(intern "*KNOBOUND*" (find-package "PLANNER_MSGS::PLANNER_SEARCHREQUEST"))
(shadow '*KNOBOUND* (find-package "PLANNER_MSGS::PLANNER_SEARCHREQUEST"))
(defconstant planner_msgs::planner_searchRequest::*KNOBOUND* 4)

(defun planner_msgs::planner_searchRequest-to-symbol (const)
  (cond
        ((= const 0) 'planner_msgs::planner_searchRequest::*kExtendedBound*)
        ((= const 1) 'planner_msgs::planner_searchRequest::*kRelaxedBound*)
        ((= const 2) 'planner_msgs::planner_searchRequest::*kMinBound*)
        ((= const 3) 'planner_msgs::planner_searchRequest::*kExactBound*)
        ((= const 4) 'planner_msgs::planner_searchRequest::*kNoBound*)
        (t nil)))

(defclass planner_msgs::planner_searchRequest
  :super ros::object
  :slots (_header _use_current_state _source _target _bound_mode ))

(defmethod planner_msgs::planner_searchRequest
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:use_current_state __use_current_state) nil)
    ((:source __source) (instance geometry_msgs::Pose :init))
    ((:target __target) (instance geometry_msgs::Pose :init))
    ((:bound_mode __bound_mode) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _use_current_state __use_current_state)
   (setq _source __source)
   (setq _target __target)
   (setq _bound_mode (round __bound_mode))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:use_current_state
   (&optional (__use_current_state :null))
   (if (not (eq __use_current_state :null)) (setq _use_current_state __use_current_state)) _use_current_state)
  (:source
   (&rest __source)
   (if (keywordp (car __source))
       (send* _source __source)
     (progn
       (if __source (setq _source (car __source)))
       _source)))
  (:target
   (&rest __target)
   (if (keywordp (car __target))
       (send* _target __target)
     (progn
       (if __target (setq _target (car __target)))
       _target)))
  (:bound_mode
   (&optional __bound_mode)
   (if __bound_mode (setq _bound_mode __bound_mode)) _bound_mode)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _use_current_state
    1
    ;; geometry_msgs/Pose _source
    (send _source :serialization-length)
    ;; geometry_msgs/Pose _target
    (send _target :serialization-length)
    ;; int32 _bound_mode
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _use_current_state
       (if _use_current_state (write-byte -1 s) (write-byte 0 s))
     ;; geometry_msgs/Pose _source
       (send _source :serialize s)
     ;; geometry_msgs/Pose _target
       (send _target :serialize s)
     ;; int32 _bound_mode
       (write-long _bound_mode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _use_current_state
     (setq _use_current_state (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; geometry_msgs/Pose _source
     (send _source :deserialize buf ptr-) (incf ptr- (send _source :serialization-length))
   ;; geometry_msgs/Pose _target
     (send _target :deserialize buf ptr-) (incf ptr- (send _target :serialization-length))
   ;; int32 _bound_mode
     (setq _bound_mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass planner_msgs::planner_searchResponse
  :super ros::object
  :slots (_success _path ))

(defmethod planner_msgs::planner_searchResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:path __path) ())
    )
   (send-super :init)
   (setq _success __success)
   (setq _path __path)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
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
    ;; bool _success
    1
    ;; geometry_msgs/Pose[] _path
    (apply #'+ (send-all _path :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; geometry_msgs/Pose[] _path
     (write-long (length _path) s)
     (dolist (elem _path)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
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

(defclass planner_msgs::planner_search
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_search :md5sum-) "e06e5834c0c713453a57f0396fd6674a")
(setf (get planner_msgs::planner_search :datatype-) "planner_msgs/planner_search")
(setf (get planner_msgs::planner_search :request) planner_msgs::planner_searchRequest)
(setf (get planner_msgs::planner_search :response) planner_msgs::planner_searchResponse)

(defmethod planner_msgs::planner_searchRequest
  (:response () (instance planner_msgs::planner_searchResponse :init)))

(setf (get planner_msgs::planner_searchRequest :md5sum-) "e06e5834c0c713453a57f0396fd6674a")
(setf (get planner_msgs::planner_searchRequest :datatype-) "planner_msgs/planner_searchRequest")
(setf (get planner_msgs::planner_searchRequest :definition-)
      "# Request the planner to search for a path to connect two arbitrary poses.
Header header
# Set True if want to set source pose at current robot's state.
bool use_current_state
# Source pose will be ignored if use_current_state is True
geometry_msgs/Pose source
# Target pose
geometry_msgs/Pose target

# Set the bound mode of the robot to use in planner.
# Use extension to actual size. (default)
int32 kExtendedBound = 0
int32 kRelaxedBound = 1
int32 kMinBound = 2
int32 kExactBound = 3
int32 kNoBound = 4
# Can only be used with one of above values. Check Params/BoundModeType for more details.
int32 bound_mode

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
bool success
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

(setf (get planner_msgs::planner_searchResponse :md5sum-) "e06e5834c0c713453a57f0396fd6674a")
(setf (get planner_msgs::planner_searchResponse :datatype-) "planner_msgs/planner_searchResponse")
(setf (get planner_msgs::planner_searchResponse :definition-)
      "# Request the planner to search for a path to connect two arbitrary poses.
Header header
# Set True if want to set source pose at current robot's state.
bool use_current_state
# Source pose will be ignored if use_current_state is True
geometry_msgs/Pose source
# Target pose
geometry_msgs/Pose target

# Set the bound mode of the robot to use in planner.
# Use extension to actual size. (default)
int32 kExtendedBound = 0
int32 kRelaxedBound = 1
int32 kMinBound = 2
int32 kExactBound = 3
int32 kNoBound = 4
# Can only be used with one of above values. Check Params/BoundModeType for more details.
int32 bound_mode

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
bool success
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



(provide :planner_msgs/planner_search "e06e5834c0c713453a57f0396fd6674a")


