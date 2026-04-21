; Auto-generated. Do not edit!


(cl:in-package planner_msgs-msg)


;//! \htmlinclude Edge.msg.html

(cl:defclass <Edge> (roslisp-msg-protocol:ros-message)
  ((source_id
    :reader source_id
    :initarg :source_id
    :type cl:integer
    :initform 0)
   (target_id
    :reader target_id
    :initarg :target_id
    :type cl:integer
    :initform 0)
   (weight
    :reader weight
    :initarg :weight
    :type cl:float
    :initform 0.0))
)

(cl:defclass Edge (<Edge>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Edge>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Edge)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-msg:<Edge> is deprecated: use planner_msgs-msg:Edge instead.")))

(cl:ensure-generic-function 'source_id-val :lambda-list '(m))
(cl:defmethod source_id-val ((m <Edge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:source_id-val is deprecated.  Use planner_msgs-msg:source_id instead.")
  (source_id m))

(cl:ensure-generic-function 'target_id-val :lambda-list '(m))
(cl:defmethod target_id-val ((m <Edge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:target_id-val is deprecated.  Use planner_msgs-msg:target_id instead.")
  (target_id m))

(cl:ensure-generic-function 'weight-val :lambda-list '(m))
(cl:defmethod weight-val ((m <Edge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:weight-val is deprecated.  Use planner_msgs-msg:weight instead.")
  (weight m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Edge>) ostream)
  "Serializes a message object of type '<Edge>"
  (cl:let* ((signed (cl:slot-value msg 'source_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'target_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'weight))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Edge>) istream)
  "Deserializes a message object of type '<Edge>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'source_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'target_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'weight) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Edge>)))
  "Returns string type for a message object of type '<Edge>"
  "planner_msgs/Edge")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Edge)))
  "Returns string type for a message object of type 'Edge"
  "planner_msgs/Edge")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Edge>)))
  "Returns md5sum for a message object of type '<Edge>"
  "4f0bbb1b628ed8cf4b65bbaa06d6225d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Edge)))
  "Returns md5sum for a message object of type 'Edge"
  "4f0bbb1b628ed8cf4b65bbaa06d6225d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Edge>)))
  "Returns full string definition for message of type '<Edge>"
  (cl:format cl:nil "int32 source_id~%int32 target_id~%float32 weight~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Edge)))
  "Returns full string definition for message of type 'Edge"
  (cl:format cl:nil "int32 source_id~%int32 target_id~%float32 weight~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Edge>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Edge>))
  "Converts a ROS message object to a list"
  (cl:list 'Edge
    (cl:cons ':source_id (source_id msg))
    (cl:cons ':target_id (target_id msg))
    (cl:cons ':weight (weight msg))
))
