; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude planner_set_global_bound-request.msg.html

(cl:defclass <planner_set_global_bound-request> (roslisp-msg-protocol:ros-message)
  ((get_current_bound
    :reader get_current_bound
    :initarg :get_current_bound
    :type cl:boolean
    :initform cl:nil)
   (reset_to_default
    :reader reset_to_default
    :initarg :reset_to_default
    :type cl:boolean
    :initform cl:nil)
   (bound
    :reader bound
    :initarg :bound
    :type planner_msgs-msg:PlanningBound
    :initform (cl:make-instance 'planner_msgs-msg:PlanningBound)))
)

(cl:defclass planner_set_global_bound-request (<planner_set_global_bound-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_set_global_bound-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_set_global_bound-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_set_global_bound-request> is deprecated: use planner_msgs-srv:planner_set_global_bound-request instead.")))

(cl:ensure-generic-function 'get_current_bound-val :lambda-list '(m))
(cl:defmethod get_current_bound-val ((m <planner_set_global_bound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:get_current_bound-val is deprecated.  Use planner_msgs-srv:get_current_bound instead.")
  (get_current_bound m))

(cl:ensure-generic-function 'reset_to_default-val :lambda-list '(m))
(cl:defmethod reset_to_default-val ((m <planner_set_global_bound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:reset_to_default-val is deprecated.  Use planner_msgs-srv:reset_to_default instead.")
  (reset_to_default m))

(cl:ensure-generic-function 'bound-val :lambda-list '(m))
(cl:defmethod bound-val ((m <planner_set_global_bound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:bound-val is deprecated.  Use planner_msgs-srv:bound instead.")
  (bound m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_set_global_bound-request>) ostream)
  "Serializes a message object of type '<planner_set_global_bound-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'get_current_bound) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'reset_to_default) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'bound) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_set_global_bound-request>) istream)
  "Deserializes a message object of type '<planner_set_global_bound-request>"
    (cl:setf (cl:slot-value msg 'get_current_bound) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'reset_to_default) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'bound) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_set_global_bound-request>)))
  "Returns string type for a service object of type '<planner_set_global_bound-request>"
  "planner_msgs/planner_set_global_boundRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_set_global_bound-request)))
  "Returns string type for a service object of type 'planner_set_global_bound-request"
  "planner_msgs/planner_set_global_boundRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_set_global_bound-request>)))
  "Returns md5sum for a message object of type '<planner_set_global_bound-request>"
  "1aed38fc3ce6d17635872f522b7dea8f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_set_global_bound-request)))
  "Returns md5sum for a message object of type 'planner_set_global_bound-request"
  "1aed38fc3ce6d17635872f522b7dea8f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_set_global_bound-request>)))
  "Returns full string definition for message of type '<planner_set_global_bound-request>"
  (cl:format cl:nil "# get_current_bound:~%#   true: get current bound, nothing to set~%#   false: set bound then returns the latest bound~%bool get_current_bound~%~%# reset_to_default:~%#   true:  reset to the default bounding box~%#   false: set new bounding box~%bool reset_to_default~%~%planner_msgs/PlanningBound bound~%~%================================================================================~%MSG: planner_msgs/PlanningBound~%# use_z_val~%#    true:  all x, y, z coordinate~%#    false: change only x, y coodinates~%bool use_z_val~%~%# Bottom left corner~%geometry_msgs/Point min_val~%~%# Top right corner~%geometry_msgs/Point max_val~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_set_global_bound-request)))
  "Returns full string definition for message of type 'planner_set_global_bound-request"
  (cl:format cl:nil "# get_current_bound:~%#   true: get current bound, nothing to set~%#   false: set bound then returns the latest bound~%bool get_current_bound~%~%# reset_to_default:~%#   true:  reset to the default bounding box~%#   false: set new bounding box~%bool reset_to_default~%~%planner_msgs/PlanningBound bound~%~%================================================================================~%MSG: planner_msgs/PlanningBound~%# use_z_val~%#    true:  all x, y, z coordinate~%#    false: change only x, y coodinates~%bool use_z_val~%~%# Bottom left corner~%geometry_msgs/Point min_val~%~%# Top right corner~%geometry_msgs/Point max_val~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_set_global_bound-request>))
  (cl:+ 0
     1
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'bound))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_set_global_bound-request>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_set_global_bound-request
    (cl:cons ':get_current_bound (get_current_bound msg))
    (cl:cons ':reset_to_default (reset_to_default msg))
    (cl:cons ':bound (bound msg))
))
;//! \htmlinclude planner_set_global_bound-response.msg.html

(cl:defclass <planner_set_global_bound-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (bound_ret
    :reader bound_ret
    :initarg :bound_ret
    :type planner_msgs-msg:PlanningBound
    :initform (cl:make-instance 'planner_msgs-msg:PlanningBound)))
)

(cl:defclass planner_set_global_bound-response (<planner_set_global_bound-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_set_global_bound-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_set_global_bound-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_set_global_bound-response> is deprecated: use planner_msgs-srv:planner_set_global_bound-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <planner_set_global_bound-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'bound_ret-val :lambda-list '(m))
(cl:defmethod bound_ret-val ((m <planner_set_global_bound-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:bound_ret-val is deprecated.  Use planner_msgs-srv:bound_ret instead.")
  (bound_ret m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_set_global_bound-response>) ostream)
  "Serializes a message object of type '<planner_set_global_bound-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'bound_ret) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_set_global_bound-response>) istream)
  "Deserializes a message object of type '<planner_set_global_bound-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'bound_ret) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_set_global_bound-response>)))
  "Returns string type for a service object of type '<planner_set_global_bound-response>"
  "planner_msgs/planner_set_global_boundResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_set_global_bound-response)))
  "Returns string type for a service object of type 'planner_set_global_bound-response"
  "planner_msgs/planner_set_global_boundResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_set_global_bound-response>)))
  "Returns md5sum for a message object of type '<planner_set_global_bound-response>"
  "1aed38fc3ce6d17635872f522b7dea8f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_set_global_bound-response)))
  "Returns md5sum for a message object of type 'planner_set_global_bound-response"
  "1aed38fc3ce6d17635872f522b7dea8f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_set_global_bound-response>)))
  "Returns full string definition for message of type '<planner_set_global_bound-response>"
  (cl:format cl:nil "bool success~%~%# Return the actual value inside planner after calling this service~%planner_msgs/PlanningBound bound_ret~%~%================================================================================~%MSG: planner_msgs/PlanningBound~%# use_z_val~%#    true:  all x, y, z coordinate~%#    false: change only x, y coodinates~%bool use_z_val~%~%# Bottom left corner~%geometry_msgs/Point min_val~%~%# Top right corner~%geometry_msgs/Point max_val~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_set_global_bound-response)))
  "Returns full string definition for message of type 'planner_set_global_bound-response"
  (cl:format cl:nil "bool success~%~%# Return the actual value inside planner after calling this service~%planner_msgs/PlanningBound bound_ret~%~%================================================================================~%MSG: planner_msgs/PlanningBound~%# use_z_val~%#    true:  all x, y, z coordinate~%#    false: change only x, y coodinates~%bool use_z_val~%~%# Bottom left corner~%geometry_msgs/Point min_val~%~%# Top right corner~%geometry_msgs/Point max_val~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_set_global_bound-response>))
  (cl:+ 0
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'bound_ret))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_set_global_bound-response>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_set_global_bound-response
    (cl:cons ':success (success msg))
    (cl:cons ':bound_ret (bound_ret msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'planner_set_global_bound)))
  'planner_set_global_bound-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'planner_set_global_bound)))
  'planner_set_global_bound-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_set_global_bound)))
  "Returns string type for a service object of type '<planner_set_global_bound>"
  "planner_msgs/planner_set_global_bound")