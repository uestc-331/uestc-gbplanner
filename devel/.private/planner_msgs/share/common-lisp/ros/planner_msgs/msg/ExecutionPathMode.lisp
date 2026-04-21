; Auto-generated. Do not edit!


(cl:in-package planner_msgs-msg)


;//! \htmlinclude ExecutionPathMode.msg.html

(cl:defclass <ExecutionPathMode> (roslisp-msg-protocol:ros-message)
  ((mode
    :reader mode
    :initarg :mode
    :type cl:integer
    :initform 0)
   (is_forward
    :reader is_forward
    :initarg :is_forward
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ExecutionPathMode (<ExecutionPathMode>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExecutionPathMode>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExecutionPathMode)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-msg:<ExecutionPathMode> is deprecated: use planner_msgs-msg:ExecutionPathMode instead.")))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <ExecutionPathMode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:mode-val is deprecated.  Use planner_msgs-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'is_forward-val :lambda-list '(m))
(cl:defmethod is_forward-val ((m <ExecutionPathMode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:is_forward-val is deprecated.  Use planner_msgs-msg:is_forward instead.")
  (is_forward m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ExecutionPathMode>)))
    "Constants for message type '<ExecutionPathMode>"
  '((:KLOCALPATH . 0)
    (:KHOMINGPATH . 1)
    (:KGLOBALPATH . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ExecutionPathMode)))
    "Constants for message type 'ExecutionPathMode"
  '((:KLOCALPATH . 0)
    (:KHOMINGPATH . 1)
    (:KGLOBALPATH . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExecutionPathMode>) ostream)
  "Serializes a message object of type '<ExecutionPathMode>"
  (cl:let* ((signed (cl:slot-value msg 'mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_forward) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExecutionPathMode>) istream)
  "Deserializes a message object of type '<ExecutionPathMode>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'is_forward) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExecutionPathMode>)))
  "Returns string type for a message object of type '<ExecutionPathMode>"
  "planner_msgs/ExecutionPathMode")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExecutionPathMode)))
  "Returns string type for a message object of type 'ExecutionPathMode"
  "planner_msgs/ExecutionPathMode")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExecutionPathMode>)))
  "Returns md5sum for a message object of type '<ExecutionPathMode>"
  "9e0ca27c7cff652c41de65686e5ccf7d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExecutionPathMode)))
  "Returns md5sum for a message object of type 'ExecutionPathMode"
  "9e0ca27c7cff652c41de65686e5ccf7d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExecutionPathMode>)))
  "Returns full string definition for message of type '<ExecutionPathMode>"
  (cl:format cl:nil "# Execution path mode, defined in ExecutionPathType.~%int32 kLocalPath = 0~%int32 kHomingPath = 1~%int32 kGlobalPath = 2~%~%# Set one of above values.~%int32 mode~%~%# The path is in forward direction compared to current exploration direction or not~%bool is_forward~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExecutionPathMode)))
  "Returns full string definition for message of type 'ExecutionPathMode"
  (cl:format cl:nil "# Execution path mode, defined in ExecutionPathType.~%int32 kLocalPath = 0~%int32 kHomingPath = 1~%int32 kGlobalPath = 2~%~%# Set one of above values.~%int32 mode~%~%# The path is in forward direction compared to current exploration direction or not~%bool is_forward~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExecutionPathMode>))
  (cl:+ 0
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExecutionPathMode>))
  "Converts a ROS message object to a list"
  (cl:list 'ExecutionPathMode
    (cl:cons ':mode (mode msg))
    (cl:cons ':is_forward (is_forward msg))
))
