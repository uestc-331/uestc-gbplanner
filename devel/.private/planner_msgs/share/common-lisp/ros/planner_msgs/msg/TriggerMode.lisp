; Auto-generated. Do not edit!


(cl:in-package planner_msgs-msg)


;//! \htmlinclude TriggerMode.msg.html

(cl:defclass <TriggerMode> (roslisp-msg-protocol:ros-message)
  ((mode
    :reader mode
    :initarg :mode
    :type cl:integer
    :initform 0))
)

(cl:defclass TriggerMode (<TriggerMode>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TriggerMode>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TriggerMode)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-msg:<TriggerMode> is deprecated: use planner_msgs-msg:TriggerMode instead.")))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <TriggerMode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:mode-val is deprecated.  Use planner_msgs-msg:mode instead.")
  (mode m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<TriggerMode>)))
    "Constants for message type '<TriggerMode>"
  '((:KMANUAL . 0)
    (:KAUTO . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'TriggerMode)))
    "Constants for message type 'TriggerMode"
  '((:KMANUAL . 0)
    (:KAUTO . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TriggerMode>) ostream)
  "Serializes a message object of type '<TriggerMode>"
  (cl:let* ((signed (cl:slot-value msg 'mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TriggerMode>) istream)
  "Deserializes a message object of type '<TriggerMode>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TriggerMode>)))
  "Returns string type for a message object of type '<TriggerMode>"
  "planner_msgs/TriggerMode")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TriggerMode)))
  "Returns string type for a message object of type 'TriggerMode"
  "planner_msgs/TriggerMode")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TriggerMode>)))
  "Returns md5sum for a message object of type '<TriggerMode>"
  "e015c2f806de584b22f4c9d1a829c5b8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TriggerMode)))
  "Returns md5sum for a message object of type 'TriggerMode"
  "e015c2f806de584b22f4c9d1a829c5b8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TriggerMode>)))
  "Returns full string definition for message of type '<TriggerMode>"
  (cl:format cl:nil "# Trigger mode of planner control interface, defined in PlannerTriggerModeType.~%int32 kManual = 0~%int32 kAuto = 1~%~%# Set one of above values.~%int32 mode~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TriggerMode)))
  "Returns full string definition for message of type 'TriggerMode"
  (cl:format cl:nil "# Trigger mode of planner control interface, defined in PlannerTriggerModeType.~%int32 kManual = 0~%int32 kAuto = 1~%~%# Set one of above values.~%int32 mode~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TriggerMode>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TriggerMode>))
  "Converts a ROS message object to a list"
  (cl:list 'TriggerMode
    (cl:cons ':mode (mode msg))
))
