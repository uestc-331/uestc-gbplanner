;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::pci_geofence)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'pci_geofence (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PCI_GEOFENCE")
  (make-package "PLANNER_MSGS::PCI_GEOFENCE"))
(unless (find-package "PLANNER_MSGS::PCI_GEOFENCEREQUEST")
  (make-package "PLANNER_MSGS::PCI_GEOFENCEREQUEST"))
(unless (find-package "PLANNER_MSGS::PCI_GEOFENCERESPONSE")
  (make-package "PLANNER_MSGS::PCI_GEOFENCERESPONSE"))

(in-package "ROS")

(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))




(defclass planner_msgs::pci_geofenceRequest
  :super ros::object
  :slots (_header _rectangles ))

(defmethod planner_msgs::pci_geofenceRequest
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:rectangles __rectangles) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _rectangles __rectangles)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:rectangles
   (&rest __rectangles)
   (if (keywordp (car __rectangles))
       (send* _rectangles __rectangles)
     (progn
       (if __rectangles (setq _rectangles (car __rectangles)))
       _rectangles)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; planner_msgs/RectangleShape[] _rectangles
    (apply #'+ (send-all _rectangles :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; planner_msgs/RectangleShape[] _rectangles
     (write-long (length _rectangles) s)
     (dolist (elem _rectangles)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; planner_msgs/RectangleShape[] _rectangles
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _rectangles (let (r) (dotimes (i n) (push (instance planner_msgs::RectangleShape :init) r)) r))
     (dolist (elem- _rectangles)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass planner_msgs::pci_geofenceResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::pci_geofenceResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass planner_msgs::pci_geofence
  :super ros::object
  :slots ())

(setf (get planner_msgs::pci_geofence :md5sum-) "dc6345ad327f5b0036d6747623b84599")
(setf (get planner_msgs::pci_geofence :datatype-) "planner_msgs/pci_geofence")
(setf (get planner_msgs::pci_geofence :request) planner_msgs::pci_geofenceRequest)
(setf (get planner_msgs::pci_geofence :response) planner_msgs::pci_geofenceResponse)

(defmethod planner_msgs::pci_geofenceRequest
  (:response () (instance planner_msgs::pci_geofenceResponse :init)))

(setf (get planner_msgs::pci_geofenceRequest :md5sum-) "dc6345ad327f5b0036d6747623b84599")
(setf (get planner_msgs::pci_geofenceRequest :datatype-) "planner_msgs/pci_geofenceRequest")
(setf (get planner_msgs::pci_geofenceRequest :definition-)
      "# Add a rectangle to the geofence list.
Header header

planner_msgs/RectangleShape[] rectangles

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
MSG: planner_msgs/RectangleShape
geometry_msgs/Vector3 center
geometry_msgs/Vector3 size
================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
---
bool success
")

(setf (get planner_msgs::pci_geofenceResponse :md5sum-) "dc6345ad327f5b0036d6747623b84599")
(setf (get planner_msgs::pci_geofenceResponse :datatype-) "planner_msgs/pci_geofenceResponse")
(setf (get planner_msgs::pci_geofenceResponse :definition-)
      "# Add a rectangle to the geofence list.
Header header

planner_msgs/RectangleShape[] rectangles

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
MSG: planner_msgs/RectangleShape
geometry_msgs/Vector3 center
geometry_msgs/Vector3 size
================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
---
bool success
")



(provide :planner_msgs/pci_geofence "dc6345ad327f5b0036d6747623b84599")


