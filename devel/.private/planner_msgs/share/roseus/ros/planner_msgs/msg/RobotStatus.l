;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::RobotStatus)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'RobotStatus (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::ROBOTSTATUS")
  (make-package "PLANNER_MSGS::ROBOTSTATUS"))

(in-package "ROS")
;;//! \htmlinclude RobotStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass planner_msgs::RobotStatus
  :super ros::object
  :slots (_header _time_remaining ))

(defmethod planner_msgs::RobotStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:time_remaining __time_remaining) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _time_remaining (float __time_remaining))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:time_remaining
   (&optional __time_remaining)
   (if __time_remaining (setq _time_remaining __time_remaining)) _time_remaining)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _time_remaining
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _time_remaining
       (sys::poke _time_remaining (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _time_remaining
     (setq _time_remaining (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get planner_msgs::RobotStatus :md5sum-) "636924048022df339e82b4d60c88b7ba")
(setf (get planner_msgs::RobotStatus :datatype-) "planner_msgs/RobotStatus")
(setf (get planner_msgs::RobotStatus :definition-)
      "Header header

float32 time_remaining


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

")



(provide :planner_msgs/RobotStatus "636924048022df339e82b4d60c88b7ba")


