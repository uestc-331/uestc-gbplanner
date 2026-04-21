; Auto-generated. Do not edit!


(cl:in-package planner_msgs-msg)


;//! \htmlinclude BoundMode.msg.html

(cl:defclass <BoundMode> (roslisp-msg-protocol:ros-message)
  ((mode
    :reader mode
    :initarg :mode
    :type cl:integer
    :initform 0))
)

(cl:defclass BoundMode (<BoundMode>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BoundMode>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BoundMode)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-msg:<BoundMode> is deprecated: use planner_msgs-msg:BoundMode instead.")))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <BoundMode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:mode-val is deprecated.  Use planner_msgs-msg:mode instead.")
  (mode m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<BoundMode>)))
    "Constants for message type '<BoundMode>"
  '((:KEXTENDEDBOUND . 0)
    (:KRELAXEDBOUND . 1)
    (:KMINBOUND . 2)
    (:KEXACTBOUND . 3)
    (:KNOBOUND . 4))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'BoundMode)))
    "Constants for message type 'BoundMode"
  '((:KEXTENDEDBOUND . 0)
    (:KRELAXEDBOUND . 1)
    (:KMINBOUND . 2)
    (:KEXACTBOUND . 3)
    (:KNOBOUND . 4))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BoundMode>) ostream)
  "Serializes a message object of type '<BoundMode>"
  (cl:let* ((signed (cl:slot-value msg 'mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BoundMode>) istream)
  "Deserializes a message object of type '<BoundMode>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BoundMode>)))
  "Returns string type for a message object of type '<BoundMode>"
  "planner_msgs/BoundMode")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BoundMode)))
  "Returns string type for a message object of type 'BoundMode"
  "planner_msgs/BoundMode")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BoundMode>)))
  "Returns md5sum for a message object of type '<BoundMode>"
  "f460d6fbd196a4aff993d7d1dbede7d9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BoundMode)))
  "Returns md5sum for a message object of type 'BoundMode"
  "f460d6fbd196a4aff993d7d1dbede7d9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BoundMode>)))
  "Returns full string definition for message of type '<BoundMode>"
  (cl:format cl:nil "# Bound mode of the robot for collision checking, defined in Params/BoundModeType.~%int32 kExtendedBound = 0~%int32 kRelaxedBound = 1~%int32 kMinBound = 2~%int32 kExactBound = 3~%int32 kNoBound = 4~%~%# Set one of above values.~%int32 mode~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BoundMode)))
  "Returns full string definition for message of type 'BoundMode"
  (cl:format cl:nil "# Bound mode of the robot for collision checking, defined in Params/BoundModeType.~%int32 kExtendedBound = 0~%int32 kRelaxedBound = 1~%int32 kMinBound = 2~%int32 kExactBound = 3~%int32 kNoBound = 4~%~%# Set one of above values.~%int32 mode~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BoundMode>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BoundMode>))
  "Converts a ROS message object to a list"
  (cl:list 'BoundMode
    (cl:cons ':mode (mode msg))
))
