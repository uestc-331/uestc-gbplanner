; Auto-generated. Do not edit!


(cl:in-package planner_semantic_msgs-msg)


;//! \htmlinclude SemanticClass.msg.html

(cl:defclass <SemanticClass> (roslisp-msg-protocol:ros-message)
  ((value
    :reader value
    :initarg :value
    :type cl:integer
    :initform 0))
)

(cl:defclass SemanticClass (<SemanticClass>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SemanticClass>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SemanticClass)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_semantic_msgs-msg:<SemanticClass> is deprecated: use planner_semantic_msgs-msg:SemanticClass instead.")))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <SemanticClass>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_semantic_msgs-msg:value-val is deprecated.  Use planner_semantic_msgs-msg:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SemanticClass>)))
    "Constants for message type '<SemanticClass>"
  '((:KNONE . 0)
    (:KSTAIRCASE . 1)
    (:KDOOR . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SemanticClass)))
    "Constants for message type 'SemanticClass"
  '((:KNONE . 0)
    (:KSTAIRCASE . 1)
    (:KDOOR . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SemanticClass>) ostream)
  "Serializes a message object of type '<SemanticClass>"
  (cl:let* ((signed (cl:slot-value msg 'value)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SemanticClass>) istream)
  "Deserializes a message object of type '<SemanticClass>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'value) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SemanticClass>)))
  "Returns string type for a message object of type '<SemanticClass>"
  "planner_semantic_msgs/SemanticClass")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SemanticClass)))
  "Returns string type for a message object of type 'SemanticClass"
  "planner_semantic_msgs/SemanticClass")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SemanticClass>)))
  "Returns md5sum for a message object of type '<SemanticClass>"
  "9ed3cb55cfdae37517f1354dd57dbaba")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SemanticClass)))
  "Returns md5sum for a message object of type 'SemanticClass"
  "9ed3cb55cfdae37517f1354dd57dbaba")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SemanticClass>)))
  "Returns full string definition for message of type '<SemanticClass>"
  (cl:format cl:nil "# Semantic classes~%int32 kNone = 0~%int32 kStaircase = 1~%int32 kDoor = 2~%~%# Can only choose one of the above~%int32 value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SemanticClass)))
  "Returns full string definition for message of type 'SemanticClass"
  (cl:format cl:nil "# Semantic classes~%int32 kNone = 0~%int32 kStaircase = 1~%int32 kDoor = 2~%~%# Can only choose one of the above~%int32 value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SemanticClass>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SemanticClass>))
  "Converts a ROS message object to a list"
  (cl:list 'SemanticClass
    (cl:cons ':value (value msg))
))
