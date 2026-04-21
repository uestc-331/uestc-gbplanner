;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_dynamic_global_bound)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_dynamic_global_bound (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_DYNAMIC_GLOBAL_BOUND")
  (make-package "PLANNER_MSGS::PLANNER_DYNAMIC_GLOBAL_BOUND"))
(unless (find-package "PLANNER_MSGS::PLANNER_DYNAMIC_GLOBAL_BOUNDREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_DYNAMIC_GLOBAL_BOUNDREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_DYNAMIC_GLOBAL_BOUNDRESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_DYNAMIC_GLOBAL_BOUNDRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))




(defclass planner_msgs::planner_dynamic_global_boundRequest
  :super ros::object
  :slots (_reset_to_default _header _center _left _front _up ))

(defmethod planner_msgs::planner_dynamic_global_boundRequest
  (:init
   (&key
    ((:reset_to_default __reset_to_default) nil)
    ((:header __header) (instance std_msgs::Header :init))
    ((:center __center) (instance geometry_msgs::Point :init))
    ((:left __left) (instance geometry_msgs::Point :init))
    ((:front __front) (instance geometry_msgs::Point :init))
    ((:up __up) (instance geometry_msgs::Point :init))
    )
   (send-super :init)
   (setq _reset_to_default __reset_to_default)
   (setq _header __header)
   (setq _center __center)
   (setq _left __left)
   (setq _front __front)
   (setq _up __up)
   self)
  (:reset_to_default
   (&optional (__reset_to_default :null))
   (if (not (eq __reset_to_default :null)) (setq _reset_to_default __reset_to_default)) _reset_to_default)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:center
   (&rest __center)
   (if (keywordp (car __center))
       (send* _center __center)
     (progn
       (if __center (setq _center (car __center)))
       _center)))
  (:left
   (&rest __left)
   (if (keywordp (car __left))
       (send* _left __left)
     (progn
       (if __left (setq _left (car __left)))
       _left)))
  (:front
   (&rest __front)
   (if (keywordp (car __front))
       (send* _front __front)
     (progn
       (if __front (setq _front (car __front)))
       _front)))
  (:up
   (&rest __up)
   (if (keywordp (car __up))
       (send* _up __up)
     (progn
       (if __up (setq _up (car __up)))
       _up)))
  (:serialization-length
   ()
   (+
    ;; bool _reset_to_default
    1
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/Point _center
    (send _center :serialization-length)
    ;; geometry_msgs/Point _left
    (send _left :serialization-length)
    ;; geometry_msgs/Point _front
    (send _front :serialization-length)
    ;; geometry_msgs/Point _up
    (send _up :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _reset_to_default
       (if _reset_to_default (write-byte -1 s) (write-byte 0 s))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; geometry_msgs/Point _center
       (send _center :serialize s)
     ;; geometry_msgs/Point _left
       (send _left :serialize s)
     ;; geometry_msgs/Point _front
       (send _front :serialize s)
     ;; geometry_msgs/Point _up
       (send _up :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _reset_to_default
     (setq _reset_to_default (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; geometry_msgs/Point _center
     (send _center :deserialize buf ptr-) (incf ptr- (send _center :serialization-length))
   ;; geometry_msgs/Point _left
     (send _left :deserialize buf ptr-) (incf ptr- (send _left :serialization-length))
   ;; geometry_msgs/Point _front
     (send _front :deserialize buf ptr-) (incf ptr- (send _front :serialization-length))
   ;; geometry_msgs/Point _up
     (send _up :deserialize buf ptr-) (incf ptr- (send _up :serialization-length))
   ;;
   self)
  )

(defclass planner_msgs::planner_dynamic_global_boundResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::planner_dynamic_global_boundResponse
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

(defclass planner_msgs::planner_dynamic_global_bound
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_dynamic_global_bound :md5sum-) "31ef93df2f4c5feda83abcda3ab1ffb3")
(setf (get planner_msgs::planner_dynamic_global_bound :datatype-) "planner_msgs/planner_dynamic_global_bound")
(setf (get planner_msgs::planner_dynamic_global_bound :request) planner_msgs::planner_dynamic_global_boundRequest)
(setf (get planner_msgs::planner_dynamic_global_bound :response) planner_msgs::planner_dynamic_global_boundResponse)

(defmethod planner_msgs::planner_dynamic_global_boundRequest
  (:response () (instance planner_msgs::planner_dynamic_global_boundResponse :init)))

(setf (get planner_msgs::planner_dynamic_global_boundRequest :md5sum-) "31ef93df2f4c5feda83abcda3ab1ffb3")
(setf (get planner_msgs::planner_dynamic_global_boundRequest :datatype-) "planner_msgs/planner_dynamic_global_boundRequest")
(setf (get planner_msgs::planner_dynamic_global_boundRequest :definition-)
      "# reset_to_default:
#   true:  reset to the default bounding box
#   false: set new bounding box
bool reset_to_default

# Header contains the frame in which the bounding box is expressed
std_msgs/Header header

# All coordinates are absolute and expressed in global frame (as set in the header)
geometry_msgs/Point center  # Origin of bounding box
geometry_msgs/Point left    # Vertex on the left of center when looking along the vector of the bb
geometry_msgs/Point front   # Vertex in the front of center when looking along the vector of the bb
geometry_msgs/Point up      # Vertex above center when looking along the vector of the bb


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
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z
---

bool success
")

(setf (get planner_msgs::planner_dynamic_global_boundResponse :md5sum-) "31ef93df2f4c5feda83abcda3ab1ffb3")
(setf (get planner_msgs::planner_dynamic_global_boundResponse :datatype-) "planner_msgs/planner_dynamic_global_boundResponse")
(setf (get planner_msgs::planner_dynamic_global_boundResponse :definition-)
      "# reset_to_default:
#   true:  reset to the default bounding box
#   false: set new bounding box
bool reset_to_default

# Header contains the frame in which the bounding box is expressed
std_msgs/Header header

# All coordinates are absolute and expressed in global frame (as set in the header)
geometry_msgs/Point center  # Origin of bounding box
geometry_msgs/Point left    # Vertex on the left of center when looking along the vector of the bb
geometry_msgs/Point front   # Vertex in the front of center when looking along the vector of the bb
geometry_msgs/Point up      # Vertex above center when looking along the vector of the bb


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
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z
---

bool success
")



(provide :planner_msgs/planner_dynamic_global_bound "31ef93df2f4c5feda83abcda3ab1ffb3")


