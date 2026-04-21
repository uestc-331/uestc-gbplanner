; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude planner_set_planning_mode-request.msg.html

(cl:defclass <planner_set_planning_mode-request> (roslisp-msg-protocol:ros-message)
  ((planning_mode
    :reader planning_mode
    :initarg :planning_mode
    :type cl:integer
    :initform 0))
)

(cl:defclass planner_set_planning_mode-request (<planner_set_planning_mode-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_set_planning_mode-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_set_planning_mode-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_set_planning_mode-request> is deprecated: use planner_msgs-srv:planner_set_planning_mode-request instead.")))

(cl:ensure-generic-function 'planning_mode-val :lambda-list '(m))
(cl:defmethod planning_mode-val ((m <planner_set_planning_mode-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:planning_mode-val is deprecated.  Use planner_msgs-srv:planning_mode instead.")
  (planning_mode m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<planner_set_planning_mode-request>)))
    "Constants for message type '<planner_set_planning_mode-request>"
  '((:KMANUAL . 0)
    (:KAUTO . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'planner_set_planning_mode-request)))
    "Constants for message type 'planner_set_planning_mode-request"
  '((:KMANUAL . 0)
    (:KAUTO . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_set_planning_mode-request>) ostream)
  "Serializes a message object of type '<planner_set_planning_mode-request>"
  (cl:let* ((signed (cl:slot-value msg 'planning_mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_set_planning_mode-request>) istream)
  "Deserializes a message object of type '<planner_set_planning_mode-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'planning_mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_set_planning_mode-request>)))
  "Returns string type for a service object of type '<planner_set_planning_mode-request>"
  "planner_msgs/planner_set_planning_modeRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_set_planning_mode-request)))
  "Returns string type for a service object of type 'planner_set_planning_mode-request"
  "planner_msgs/planner_set_planning_modeRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_set_planning_mode-request>)))
  "Returns md5sum for a message object of type '<planner_set_planning_mode-request>"
  "f5c508faaff06b83ff7d994be5342caa")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_set_planning_mode-request)))
  "Returns md5sum for a message object of type 'planner_set_planning_mode-request"
  "f5c508faaff06b83ff7d994be5342caa")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_set_planning_mode-request>)))
  "Returns full string definition for message of type '<planner_set_planning_mode-request>"
  (cl:format cl:nil "# Set the planning mode of the robot to use in planner.~%int32 kManual = 0~%int32 kAuto = 1~%# Can only be used with one of above values. Check Params/BoundModeType for more details.~%int32 planning_mode~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_set_planning_mode-request)))
  "Returns full string definition for message of type 'planner_set_planning_mode-request"
  (cl:format cl:nil "# Set the planning mode of the robot to use in planner.~%int32 kManual = 0~%int32 kAuto = 1~%# Can only be used with one of above values. Check Params/BoundModeType for more details.~%int32 planning_mode~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_set_planning_mode-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_set_planning_mode-request>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_set_planning_mode-request
    (cl:cons ':planning_mode (planning_mode msg))
))
;//! \htmlinclude planner_set_planning_mode-response.msg.html

(cl:defclass <planner_set_planning_mode-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass planner_set_planning_mode-response (<planner_set_planning_mode-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_set_planning_mode-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_set_planning_mode-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_set_planning_mode-response> is deprecated: use planner_msgs-srv:planner_set_planning_mode-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <planner_set_planning_mode-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_set_planning_mode-response>) ostream)
  "Serializes a message object of type '<planner_set_planning_mode-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_set_planning_mode-response>) istream)
  "Deserializes a message object of type '<planner_set_planning_mode-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_set_planning_mode-response>)))
  "Returns string type for a service object of type '<planner_set_planning_mode-response>"
  "planner_msgs/planner_set_planning_modeResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_set_planning_mode-response)))
  "Returns string type for a service object of type 'planner_set_planning_mode-response"
  "planner_msgs/planner_set_planning_modeResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_set_planning_mode-response>)))
  "Returns md5sum for a message object of type '<planner_set_planning_mode-response>"
  "f5c508faaff06b83ff7d994be5342caa")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_set_planning_mode-response)))
  "Returns md5sum for a message object of type 'planner_set_planning_mode-response"
  "f5c508faaff06b83ff7d994be5342caa")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_set_planning_mode-response>)))
  "Returns full string definition for message of type '<planner_set_planning_mode-response>"
  (cl:format cl:nil "~%bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_set_planning_mode-response)))
  "Returns full string definition for message of type 'planner_set_planning_mode-response"
  (cl:format cl:nil "~%bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_set_planning_mode-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_set_planning_mode-response>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_set_planning_mode-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'planner_set_planning_mode)))
  'planner_set_planning_mode-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'planner_set_planning_mode)))
  'planner_set_planning_mode-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_set_planning_mode)))
  "Returns string type for a service object of type '<planner_set_planning_mode>"
  "planner_msgs/planner_set_planning_mode")