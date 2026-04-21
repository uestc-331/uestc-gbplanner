;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::pci_to_waypoint)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'pci_to_waypoint (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PCI_TO_WAYPOINT")
  (make-package "PLANNER_MSGS::PCI_TO_WAYPOINT"))
(unless (find-package "PLANNER_MSGS::PCI_TO_WAYPOINTREQUEST")
  (make-package "PLANNER_MSGS::PCI_TO_WAYPOINTREQUEST"))
(unless (find-package "PLANNER_MSGS::PCI_TO_WAYPOINTRESPONSE")
  (make-package "PLANNER_MSGS::PCI_TO_WAYPOINTRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))




(defclass planner_msgs::pci_to_waypointRequest
  :super ros::object
  :slots (_header _waypoint ))

(defmethod planner_msgs::pci_to_waypointRequest
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:waypoint __waypoint) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _waypoint __waypoint)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
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
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/Pose _waypoint
    (send _waypoint :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; geometry_msgs/Pose _waypoint
       (send _waypoint :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; geometry_msgs/Pose _waypoint
     (send _waypoint :deserialize buf ptr-) (incf ptr- (send _waypoint :serialization-length))
   ;;
   self)
  )

(defclass planner_msgs::pci_to_waypointResponse
  :super ros::object
  :slots ())

(defmethod planner_msgs::pci_to_waypointResponse
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass planner_msgs::pci_to_waypoint
  :super ros::object
  :slots ())

(setf (get planner_msgs::pci_to_waypoint :md5sum-) "7f5b5ed73b4dc3c42d1110aac543afa5")
(setf (get planner_msgs::pci_to_waypoint :datatype-) "planner_msgs/pci_to_waypoint")
(setf (get planner_msgs::pci_to_waypoint :request) planner_msgs::pci_to_waypointRequest)
(setf (get planner_msgs::pci_to_waypoint :response) planner_msgs::pci_to_waypointResponse)

(defmethod planner_msgs::pci_to_waypointRequest
  (:response () (instance planner_msgs::pci_to_waypointResponse :init)))

(setf (get planner_msgs::pci_to_waypointRequest :md5sum-) "7f5b5ed73b4dc3c42d1110aac543afa5")
(setf (get planner_msgs::pci_to_waypointRequest :datatype-) "planner_msgs/pci_to_waypointRequest")
(setf (get planner_msgs::pci_to_waypointRequest :definition-)
      "# Force the robot to go to a waypoint
Header header

# Return best path.
geometry_msgs/Pose waypoint


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
")

(setf (get planner_msgs::pci_to_waypointResponse :md5sum-) "7f5b5ed73b4dc3c42d1110aac543afa5")
(setf (get planner_msgs::pci_to_waypointResponse :datatype-) "planner_msgs/pci_to_waypointResponse")
(setf (get planner_msgs::pci_to_waypointResponse :definition-)
      "# Force the robot to go to a waypoint
Header header

# Return best path.
geometry_msgs/Pose waypoint


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
")



(provide :planner_msgs/pci_to_waypoint "7f5b5ed73b4dc3c42d1110aac543afa5")


