; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude planner_set_exp_mode-request.msg.html

(cl:defclass <planner_set_exp_mode-request> (roslisp-msg-protocol:ros-message)
  ((exp_mode
    :reader exp_mode
    :initarg :exp_mode
    :type planner_msgs-msg:PlanningMode
    :initform (cl:make-instance 'planner_msgs-msg:PlanningMode)))
)

(cl:defclass planner_set_exp_mode-request (<planner_set_exp_mode-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_set_exp_mode-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_set_exp_mode-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_set_exp_mode-request> is deprecated: use planner_msgs-srv:planner_set_exp_mode-request instead.")))

(cl:ensure-generic-function 'exp_mode-val :lambda-list '(m))
(cl:defmethod exp_mode-val ((m <planner_set_exp_mode-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:exp_mode-val is deprecated.  Use planner_msgs-srv:exp_mode instead.")
  (exp_mode m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_set_exp_mode-request>) ostream)
  "Serializes a message object of type '<planner_set_exp_mode-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'exp_mode) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_set_exp_mode-request>) istream)
  "Deserializes a message object of type '<planner_set_exp_mode-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'exp_mode) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_set_exp_mode-request>)))
  "Returns string type for a service object of type '<planner_set_exp_mode-request>"
  "planner_msgs/planner_set_exp_modeRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_set_exp_mode-request)))
  "Returns string type for a service object of type 'planner_set_exp_mode-request"
  "planner_msgs/planner_set_exp_modeRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_set_exp_mode-request>)))
  "Returns md5sum for a message object of type '<planner_set_exp_mode-request>"
  "77df73f792ae041f34f0514a2cf99738")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_set_exp_mode-request)))
  "Returns md5sum for a message object of type 'planner_set_exp_mode-request"
  "77df73f792ae041f34f0514a2cf99738")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_set_exp_mode-request>)))
  "Returns full string definition for message of type '<planner_set_exp_mode-request>"
  (cl:format cl:nil "planner_msgs/PlanningMode exp_mode~%~%================================================================================~%MSG: planner_msgs/PlanningMode~%# Planning mode for exploration, defined in Params/PlanningModeType.~%int32 kBasicExploration = 0~%int32 kNarrowEnvExploration = 1~%int32 kAdaptiveExploration = 2~%~%# Set one of above values.~%int32 mode~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_set_exp_mode-request)))
  "Returns full string definition for message of type 'planner_set_exp_mode-request"
  (cl:format cl:nil "planner_msgs/PlanningMode exp_mode~%~%================================================================================~%MSG: planner_msgs/PlanningMode~%# Planning mode for exploration, defined in Params/PlanningModeType.~%int32 kBasicExploration = 0~%int32 kNarrowEnvExploration = 1~%int32 kAdaptiveExploration = 2~%~%# Set one of above values.~%int32 mode~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_set_exp_mode-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'exp_mode))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_set_exp_mode-request>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_set_exp_mode-request
    (cl:cons ':exp_mode (exp_mode msg))
))
;//! \htmlinclude planner_set_exp_mode-response.msg.html

(cl:defclass <planner_set_exp_mode-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass planner_set_exp_mode-response (<planner_set_exp_mode-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_set_exp_mode-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_set_exp_mode-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_set_exp_mode-response> is deprecated: use planner_msgs-srv:planner_set_exp_mode-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <planner_set_exp_mode-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_set_exp_mode-response>) ostream)
  "Serializes a message object of type '<planner_set_exp_mode-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_set_exp_mode-response>) istream)
  "Deserializes a message object of type '<planner_set_exp_mode-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_set_exp_mode-response>)))
  "Returns string type for a service object of type '<planner_set_exp_mode-response>"
  "planner_msgs/planner_set_exp_modeResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_set_exp_mode-response)))
  "Returns string type for a service object of type 'planner_set_exp_mode-response"
  "planner_msgs/planner_set_exp_modeResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_set_exp_mode-response>)))
  "Returns md5sum for a message object of type '<planner_set_exp_mode-response>"
  "77df73f792ae041f34f0514a2cf99738")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_set_exp_mode-response)))
  "Returns md5sum for a message object of type 'planner_set_exp_mode-response"
  "77df73f792ae041f34f0514a2cf99738")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_set_exp_mode-response>)))
  "Returns full string definition for message of type '<planner_set_exp_mode-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_set_exp_mode-response)))
  "Returns full string definition for message of type 'planner_set_exp_mode-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_set_exp_mode-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_set_exp_mode-response>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_set_exp_mode-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'planner_set_exp_mode)))
  'planner_set_exp_mode-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'planner_set_exp_mode)))
  'planner_set_exp_mode-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_set_exp_mode)))
  "Returns string type for a service object of type '<planner_set_exp_mode>"
  "planner_msgs/planner_set_exp_mode")