; Auto-generated. Do not edit!


(cl:in-package planner_msgs-msg)


;//! \htmlinclude PlanningMode.msg.html

(cl:defclass <PlanningMode> (roslisp-msg-protocol:ros-message)
  ((mode
    :reader mode
    :initarg :mode
    :type cl:integer
    :initform 0))
)

(cl:defclass PlanningMode (<PlanningMode>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PlanningMode>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PlanningMode)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-msg:<PlanningMode> is deprecated: use planner_msgs-msg:PlanningMode instead.")))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <PlanningMode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:mode-val is deprecated.  Use planner_msgs-msg:mode instead.")
  (mode m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<PlanningMode>)))
    "Constants for message type '<PlanningMode>"
  '((:KBASICEXPLORATION . 0)
    (:KNARROWENVEXPLORATION . 1)
    (:KADAPTIVEEXPLORATION . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'PlanningMode)))
    "Constants for message type 'PlanningMode"
  '((:KBASICEXPLORATION . 0)
    (:KNARROWENVEXPLORATION . 1)
    (:KADAPTIVEEXPLORATION . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PlanningMode>) ostream)
  "Serializes a message object of type '<PlanningMode>"
  (cl:let* ((signed (cl:slot-value msg 'mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PlanningMode>) istream)
  "Deserializes a message object of type '<PlanningMode>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PlanningMode>)))
  "Returns string type for a message object of type '<PlanningMode>"
  "planner_msgs/PlanningMode")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlanningMode)))
  "Returns string type for a message object of type 'PlanningMode"
  "planner_msgs/PlanningMode")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PlanningMode>)))
  "Returns md5sum for a message object of type '<PlanningMode>"
  "565e7cf808eefb4996657b401755699b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PlanningMode)))
  "Returns md5sum for a message object of type 'PlanningMode"
  "565e7cf808eefb4996657b401755699b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PlanningMode>)))
  "Returns full string definition for message of type '<PlanningMode>"
  (cl:format cl:nil "# Planning mode for exploration, defined in Params/PlanningModeType.~%int32 kBasicExploration = 0~%int32 kNarrowEnvExploration = 1~%int32 kAdaptiveExploration = 2~%~%# Set one of above values.~%int32 mode~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PlanningMode)))
  "Returns full string definition for message of type 'PlanningMode"
  (cl:format cl:nil "# Planning mode for exploration, defined in Params/PlanningModeType.~%int32 kBasicExploration = 0~%int32 kNarrowEnvExploration = 1~%int32 kAdaptiveExploration = 2~%~%# Set one of above values.~%int32 mode~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PlanningMode>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PlanningMode>))
  "Converts a ROS message object to a list"
  (cl:list 'PlanningMode
    (cl:cons ':mode (mode msg))
))
