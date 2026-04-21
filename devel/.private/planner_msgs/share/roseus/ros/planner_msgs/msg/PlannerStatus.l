;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::PlannerStatus)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'PlannerStatus (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNERSTATUS")
  (make-package "PLANNER_MSGS::PLANNERSTATUS"))

(in-package "ROS")
;;//! \htmlinclude PlannerStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass planner_msgs::PlannerStatus
  :super ros::object
  :slots (_header _success _trigger_mode _bound_mode _planning_mode _exe_path_mode _max_vel ))

(defmethod planner_msgs::PlannerStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:success __success) nil)
    ((:trigger_mode __trigger_mode) (instance planner_msgs::TriggerMode :init))
    ((:bound_mode __bound_mode) (instance planner_msgs::BoundMode :init))
    ((:planning_mode __planning_mode) (instance planner_msgs::PlanningMode :init))
    ((:exe_path_mode __exe_path_mode) (instance planner_msgs::ExecutionPathMode :init))
    ((:max_vel __max_vel) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _success __success)
   (setq _trigger_mode __trigger_mode)
   (setq _bound_mode __bound_mode)
   (setq _planning_mode __planning_mode)
   (setq _exe_path_mode __exe_path_mode)
   (setq _max_vel (float __max_vel))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:trigger_mode
   (&rest __trigger_mode)
   (if (keywordp (car __trigger_mode))
       (send* _trigger_mode __trigger_mode)
     (progn
       (if __trigger_mode (setq _trigger_mode (car __trigger_mode)))
       _trigger_mode)))
  (:bound_mode
   (&rest __bound_mode)
   (if (keywordp (car __bound_mode))
       (send* _bound_mode __bound_mode)
     (progn
       (if __bound_mode (setq _bound_mode (car __bound_mode)))
       _bound_mode)))
  (:planning_mode
   (&rest __planning_mode)
   (if (keywordp (car __planning_mode))
       (send* _planning_mode __planning_mode)
     (progn
       (if __planning_mode (setq _planning_mode (car __planning_mode)))
       _planning_mode)))
  (:exe_path_mode
   (&rest __exe_path_mode)
   (if (keywordp (car __exe_path_mode))
       (send* _exe_path_mode __exe_path_mode)
     (progn
       (if __exe_path_mode (setq _exe_path_mode (car __exe_path_mode)))
       _exe_path_mode)))
  (:max_vel
   (&optional __max_vel)
   (if __max_vel (setq _max_vel __max_vel)) _max_vel)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _success
    1
    ;; planner_msgs/TriggerMode _trigger_mode
    (send _trigger_mode :serialization-length)
    ;; planner_msgs/BoundMode _bound_mode
    (send _bound_mode :serialization-length)
    ;; planner_msgs/PlanningMode _planning_mode
    (send _planning_mode :serialization-length)
    ;; planner_msgs/ExecutionPathMode _exe_path_mode
    (send _exe_path_mode :serialization-length)
    ;; float32 _max_vel
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; planner_msgs/TriggerMode _trigger_mode
       (send _trigger_mode :serialize s)
     ;; planner_msgs/BoundMode _bound_mode
       (send _bound_mode :serialize s)
     ;; planner_msgs/PlanningMode _planning_mode
       (send _planning_mode :serialize s)
     ;; planner_msgs/ExecutionPathMode _exe_path_mode
       (send _exe_path_mode :serialize s)
     ;; float32 _max_vel
       (sys::poke _max_vel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; planner_msgs/TriggerMode _trigger_mode
     (send _trigger_mode :deserialize buf ptr-) (incf ptr- (send _trigger_mode :serialization-length))
   ;; planner_msgs/BoundMode _bound_mode
     (send _bound_mode :deserialize buf ptr-) (incf ptr- (send _bound_mode :serialization-length))
   ;; planner_msgs/PlanningMode _planning_mode
     (send _planning_mode :deserialize buf ptr-) (incf ptr- (send _planning_mode :serialization-length))
   ;; planner_msgs/ExecutionPathMode _exe_path_mode
     (send _exe_path_mode :deserialize buf ptr-) (incf ptr- (send _exe_path_mode :serialization-length))
   ;; float32 _max_vel
     (setq _max_vel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get planner_msgs::PlannerStatus :md5sum-) "457dd68e31cf1be9ac36510d1cf7cba5")
(setf (get planner_msgs::PlannerStatus :datatype-) "planner_msgs/PlannerStatus")
(setf (get planner_msgs::PlannerStatus :definition-)
      "Header header

bool success
planner_msgs/TriggerMode trigger_mode
planner_msgs/BoundMode bound_mode
planner_msgs/PlanningMode planning_mode
planner_msgs/ExecutionPathMode exe_path_mode
float32 max_vel
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
MSG: planner_msgs/TriggerMode
# Trigger mode of planner control interface, defined in PlannerTriggerModeType.
int32 kManual = 0
int32 kAuto = 1

# Set one of above values.
int32 mode
================================================================================
MSG: planner_msgs/BoundMode
# Bound mode of the robot for collision checking, defined in Params/BoundModeType.
int32 kExtendedBound = 0
int32 kRelaxedBound = 1
int32 kMinBound = 2
int32 kExactBound = 3
int32 kNoBound = 4

# Set one of above values.
int32 mode
================================================================================
MSG: planner_msgs/PlanningMode
# Planning mode for exploration, defined in Params/PlanningModeType.
int32 kBasicExploration = 0
int32 kNarrowEnvExploration = 1
int32 kAdaptiveExploration = 2

# Set one of above values.
int32 mode
================================================================================
MSG: planner_msgs/ExecutionPathMode
# Execution path mode, defined in ExecutionPathType.
int32 kLocalPath = 0
int32 kHomingPath = 1
int32 kGlobalPath = 2

# Set one of above values.
int32 mode

# The path is in forward direction compared to current exploration direction or not
bool is_forward
")



(provide :planner_msgs/PlannerStatus "457dd68e31cf1be9ac36510d1cf7cba5")


