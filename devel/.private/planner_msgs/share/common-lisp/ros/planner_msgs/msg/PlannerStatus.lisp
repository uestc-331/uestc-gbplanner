; Auto-generated. Do not edit!


(cl:in-package planner_msgs-msg)


;//! \htmlinclude PlannerStatus.msg.html

(cl:defclass <PlannerStatus> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (trigger_mode
    :reader trigger_mode
    :initarg :trigger_mode
    :type planner_msgs-msg:TriggerMode
    :initform (cl:make-instance 'planner_msgs-msg:TriggerMode))
   (bound_mode
    :reader bound_mode
    :initarg :bound_mode
    :type planner_msgs-msg:BoundMode
    :initform (cl:make-instance 'planner_msgs-msg:BoundMode))
   (planning_mode
    :reader planning_mode
    :initarg :planning_mode
    :type planner_msgs-msg:PlanningMode
    :initform (cl:make-instance 'planner_msgs-msg:PlanningMode))
   (exe_path_mode
    :reader exe_path_mode
    :initarg :exe_path_mode
    :type planner_msgs-msg:ExecutionPathMode
    :initform (cl:make-instance 'planner_msgs-msg:ExecutionPathMode))
   (max_vel
    :reader max_vel
    :initarg :max_vel
    :type cl:float
    :initform 0.0))
)

(cl:defclass PlannerStatus (<PlannerStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PlannerStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PlannerStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-msg:<PlannerStatus> is deprecated: use planner_msgs-msg:PlannerStatus instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <PlannerStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:header-val is deprecated.  Use planner_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <PlannerStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:success-val is deprecated.  Use planner_msgs-msg:success instead.")
  (success m))

(cl:ensure-generic-function 'trigger_mode-val :lambda-list '(m))
(cl:defmethod trigger_mode-val ((m <PlannerStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:trigger_mode-val is deprecated.  Use planner_msgs-msg:trigger_mode instead.")
  (trigger_mode m))

(cl:ensure-generic-function 'bound_mode-val :lambda-list '(m))
(cl:defmethod bound_mode-val ((m <PlannerStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:bound_mode-val is deprecated.  Use planner_msgs-msg:bound_mode instead.")
  (bound_mode m))

(cl:ensure-generic-function 'planning_mode-val :lambda-list '(m))
(cl:defmethod planning_mode-val ((m <PlannerStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:planning_mode-val is deprecated.  Use planner_msgs-msg:planning_mode instead.")
  (planning_mode m))

(cl:ensure-generic-function 'exe_path_mode-val :lambda-list '(m))
(cl:defmethod exe_path_mode-val ((m <PlannerStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:exe_path_mode-val is deprecated.  Use planner_msgs-msg:exe_path_mode instead.")
  (exe_path_mode m))

(cl:ensure-generic-function 'max_vel-val :lambda-list '(m))
(cl:defmethod max_vel-val ((m <PlannerStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:max_vel-val is deprecated.  Use planner_msgs-msg:max_vel instead.")
  (max_vel m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PlannerStatus>) ostream)
  "Serializes a message object of type '<PlannerStatus>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'trigger_mode) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'bound_mode) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'planning_mode) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'exe_path_mode) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'max_vel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PlannerStatus>) istream)
  "Deserializes a message object of type '<PlannerStatus>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'trigger_mode) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'bound_mode) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'planning_mode) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'exe_path_mode) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'max_vel) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PlannerStatus>)))
  "Returns string type for a message object of type '<PlannerStatus>"
  "planner_msgs/PlannerStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlannerStatus)))
  "Returns string type for a message object of type 'PlannerStatus"
  "planner_msgs/PlannerStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PlannerStatus>)))
  "Returns md5sum for a message object of type '<PlannerStatus>"
  "457dd68e31cf1be9ac36510d1cf7cba5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PlannerStatus)))
  "Returns md5sum for a message object of type 'PlannerStatus"
  "457dd68e31cf1be9ac36510d1cf7cba5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PlannerStatus>)))
  "Returns full string definition for message of type '<PlannerStatus>"
  (cl:format cl:nil "Header header~%~%bool success~%planner_msgs/TriggerMode trigger_mode~%planner_msgs/BoundMode bound_mode~%planner_msgs/PlanningMode planning_mode~%planner_msgs/ExecutionPathMode exe_path_mode~%float32 max_vel~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: planner_msgs/TriggerMode~%# Trigger mode of planner control interface, defined in PlannerTriggerModeType.~%int32 kManual = 0~%int32 kAuto = 1~%~%# Set one of above values.~%int32 mode~%================================================================================~%MSG: planner_msgs/BoundMode~%# Bound mode of the robot for collision checking, defined in Params/BoundModeType.~%int32 kExtendedBound = 0~%int32 kRelaxedBound = 1~%int32 kMinBound = 2~%int32 kExactBound = 3~%int32 kNoBound = 4~%~%# Set one of above values.~%int32 mode~%================================================================================~%MSG: planner_msgs/PlanningMode~%# Planning mode for exploration, defined in Params/PlanningModeType.~%int32 kBasicExploration = 0~%int32 kNarrowEnvExploration = 1~%int32 kAdaptiveExploration = 2~%~%# Set one of above values.~%int32 mode~%================================================================================~%MSG: planner_msgs/ExecutionPathMode~%# Execution path mode, defined in ExecutionPathType.~%int32 kLocalPath = 0~%int32 kHomingPath = 1~%int32 kGlobalPath = 2~%~%# Set one of above values.~%int32 mode~%~%# The path is in forward direction compared to current exploration direction or not~%bool is_forward~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PlannerStatus)))
  "Returns full string definition for message of type 'PlannerStatus"
  (cl:format cl:nil "Header header~%~%bool success~%planner_msgs/TriggerMode trigger_mode~%planner_msgs/BoundMode bound_mode~%planner_msgs/PlanningMode planning_mode~%planner_msgs/ExecutionPathMode exe_path_mode~%float32 max_vel~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: planner_msgs/TriggerMode~%# Trigger mode of planner control interface, defined in PlannerTriggerModeType.~%int32 kManual = 0~%int32 kAuto = 1~%~%# Set one of above values.~%int32 mode~%================================================================================~%MSG: planner_msgs/BoundMode~%# Bound mode of the robot for collision checking, defined in Params/BoundModeType.~%int32 kExtendedBound = 0~%int32 kRelaxedBound = 1~%int32 kMinBound = 2~%int32 kExactBound = 3~%int32 kNoBound = 4~%~%# Set one of above values.~%int32 mode~%================================================================================~%MSG: planner_msgs/PlanningMode~%# Planning mode for exploration, defined in Params/PlanningModeType.~%int32 kBasicExploration = 0~%int32 kNarrowEnvExploration = 1~%int32 kAdaptiveExploration = 2~%~%# Set one of above values.~%int32 mode~%================================================================================~%MSG: planner_msgs/ExecutionPathMode~%# Execution path mode, defined in ExecutionPathType.~%int32 kLocalPath = 0~%int32 kHomingPath = 1~%int32 kGlobalPath = 2~%~%# Set one of above values.~%int32 mode~%~%# The path is in forward direction compared to current exploration direction or not~%bool is_forward~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PlannerStatus>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'trigger_mode))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'bound_mode))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'planning_mode))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'exe_path_mode))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PlannerStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'PlannerStatus
    (cl:cons ':header (header msg))
    (cl:cons ':success (success msg))
    (cl:cons ':trigger_mode (trigger_mode msg))
    (cl:cons ':bound_mode (bound_mode msg))
    (cl:cons ':planning_mode (planning_mode msg))
    (cl:cons ':exe_path_mode (exe_path_mode msg))
    (cl:cons ':max_vel (max_vel msg))
))
