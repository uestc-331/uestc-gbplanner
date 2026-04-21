;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::pci_search)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'pci_search (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PCI_SEARCH")
  (make-package "PLANNER_MSGS::PCI_SEARCH"))
(unless (find-package "PLANNER_MSGS::PCI_SEARCHREQUEST")
  (make-package "PLANNER_MSGS::PCI_SEARCHREQUEST"))
(unless (find-package "PLANNER_MSGS::PCI_SEARCHRESPONSE")
  (make-package "PLANNER_MSGS::PCI_SEARCHRESPONSE"))

(in-package "ROS")

(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(intern "*KEXTENDEDBOUND*" (find-package "PLANNER_MSGS::PCI_SEARCHREQUEST"))
(shadow '*KEXTENDEDBOUND* (find-package "PLANNER_MSGS::PCI_SEARCHREQUEST"))
(defconstant planner_msgs::pci_searchRequest::*KEXTENDEDBOUND* 0)
(intern "*KRELAXEDBOUND*" (find-package "PLANNER_MSGS::PCI_SEARCHREQUEST"))
(shadow '*KRELAXEDBOUND* (find-package "PLANNER_MSGS::PCI_SEARCHREQUEST"))
(defconstant planner_msgs::pci_searchRequest::*KRELAXEDBOUND* 1)
(intern "*KMINBOUND*" (find-package "PLANNER_MSGS::PCI_SEARCHREQUEST"))
(shadow '*KMINBOUND* (find-package "PLANNER_MSGS::PCI_SEARCHREQUEST"))
(defconstant planner_msgs::pci_searchRequest::*KMINBOUND* 2)
(intern "*KEXACTBOUND*" (find-package "PLANNER_MSGS::PCI_SEARCHREQUEST"))
(shadow '*KEXACTBOUND* (find-package "PLANNER_MSGS::PCI_SEARCHREQUEST"))
(defconstant planner_msgs::pci_searchRequest::*KEXACTBOUND* 3)
(intern "*KNOBOUND*" (find-package "PLANNER_MSGS::PCI_SEARCHREQUEST"))
(shadow '*KNOBOUND* (find-package "PLANNER_MSGS::PCI_SEARCHREQUEST"))
(defconstant planner_msgs::pci_searchRequest::*KNOBOUND* 4)

(defun planner_msgs::pci_searchRequest-to-symbol (const)
  (cond
        ((= const 0) 'planner_msgs::pci_searchRequest::*kExtendedBound*)
        ((= const 1) 'planner_msgs::pci_searchRequest::*kRelaxedBound*)
        ((= const 2) 'planner_msgs::pci_searchRequest::*kMinBound*)
        ((= const 3) 'planner_msgs::pci_searchRequest::*kExactBound*)
        ((= const 4) 'planner_msgs::pci_searchRequest::*kNoBound*)
        (t nil)))

(defclass planner_msgs::pci_searchRequest
  :super ros::object
  :slots (_header _use_current_state _not_exe_path _bound_mode ))

(defmethod planner_msgs::pci_searchRequest
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:use_current_state __use_current_state) nil)
    ((:not_exe_path __not_exe_path) nil)
    ((:bound_mode __bound_mode) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _use_current_state __use_current_state)
   (setq _not_exe_path __not_exe_path)
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
  (:not_exe_path
   (&optional (__not_exe_path :null))
   (if (not (eq __not_exe_path :null)) (setq _not_exe_path __not_exe_path)) _not_exe_path)
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
    ;; bool _not_exe_path
    1
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
     ;; bool _not_exe_path
       (if _not_exe_path (write-byte -1 s) (write-byte 0 s))
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
   ;; bool _not_exe_path
     (setq _not_exe_path (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _bound_mode
     (setq _bound_mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass planner_msgs::pci_searchResponse
  :super ros::object
  :slots (_success _path ))

(defmethod planner_msgs::pci_searchResponse
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

(defclass planner_msgs::pci_search
  :super ros::object
  :slots ())

(setf (get planner_msgs::pci_search :md5sum-) "f1ece3929bac9df7327e2d5bd5fa9145")
(setf (get planner_msgs::pci_search :datatype-) "planner_msgs/pci_search")
(setf (get planner_msgs::pci_search :request) planner_msgs::pci_searchRequest)
(setf (get planner_msgs::pci_search :response) planner_msgs::pci_searchResponse)

(defmethod planner_msgs::pci_searchRequest
  (:response () (instance planner_msgs::pci_searchResponse :init)))

(setf (get planner_msgs::pci_searchRequest :md5sum-) "f1ece3929bac9df7327e2d5bd5fa9145")
(setf (get planner_msgs::pci_searchRequest :datatype-) "planner_msgs/pci_searchRequest")
(setf (get planner_msgs::pci_searchRequest :definition-)
      "# Request the planning through the planner control interface node.
Header header
# Set True if want to set source pose at current robot's state;
# otherwise, get from inter=active marker
bool use_current_state
bool not_exe_path

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
---
bool success
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

(setf (get planner_msgs::pci_searchResponse :md5sum-) "f1ece3929bac9df7327e2d5bd5fa9145")
(setf (get planner_msgs::pci_searchResponse :datatype-) "planner_msgs/pci_searchResponse")
(setf (get planner_msgs::pci_searchResponse :definition-)
      "# Request the planning through the planner control interface node.
Header header
# Set True if want to set source pose at current robot's state;
# otherwise, get from inter=active marker
bool use_current_state
bool not_exe_path

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
---
bool success
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



(provide :planner_msgs/pci_search "f1ece3929bac9df7327e2d5bd5fa9145")


