; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude pci_global-request.msg.html

(cl:defclass <pci_global-request> (roslisp-msg-protocol:ros-message)
  ((not_exe_path
    :reader not_exe_path
    :initarg :not_exe_path
    :type cl:boolean
    :initform cl:nil)
   (set_auto
    :reader set_auto
    :initarg :set_auto
    :type cl:boolean
    :initform cl:nil)
   (bound_mode
    :reader bound_mode
    :initarg :bound_mode
    :type cl:fixnum
    :initform 0)
   (vel_max
    :reader vel_max
    :initarg :vel_max
    :type cl:float
    :initform 0.0)
   (id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (not_check_frontier
    :reader not_check_frontier
    :initarg :not_check_frontier
    :type cl:boolean
    :initform cl:nil)
   (ignore_time
    :reader ignore_time
    :initarg :ignore_time
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass pci_global-request (<pci_global-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_global-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_global-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_global-request> is deprecated: use planner_msgs-srv:pci_global-request instead.")))

(cl:ensure-generic-function 'not_exe_path-val :lambda-list '(m))
(cl:defmethod not_exe_path-val ((m <pci_global-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:not_exe_path-val is deprecated.  Use planner_msgs-srv:not_exe_path instead.")
  (not_exe_path m))

(cl:ensure-generic-function 'set_auto-val :lambda-list '(m))
(cl:defmethod set_auto-val ((m <pci_global-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:set_auto-val is deprecated.  Use planner_msgs-srv:set_auto instead.")
  (set_auto m))

(cl:ensure-generic-function 'bound_mode-val :lambda-list '(m))
(cl:defmethod bound_mode-val ((m <pci_global-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:bound_mode-val is deprecated.  Use planner_msgs-srv:bound_mode instead.")
  (bound_mode m))

(cl:ensure-generic-function 'vel_max-val :lambda-list '(m))
(cl:defmethod vel_max-val ((m <pci_global-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:vel_max-val is deprecated.  Use planner_msgs-srv:vel_max instead.")
  (vel_max m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <pci_global-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:id-val is deprecated.  Use planner_msgs-srv:id instead.")
  (id m))

(cl:ensure-generic-function 'not_check_frontier-val :lambda-list '(m))
(cl:defmethod not_check_frontier-val ((m <pci_global-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:not_check_frontier-val is deprecated.  Use planner_msgs-srv:not_check_frontier instead.")
  (not_check_frontier m))

(cl:ensure-generic-function 'ignore_time-val :lambda-list '(m))
(cl:defmethod ignore_time-val ((m <pci_global-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:ignore_time-val is deprecated.  Use planner_msgs-srv:ignore_time instead.")
  (ignore_time m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_global-request>) ostream)
  "Serializes a message object of type '<pci_global-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'not_exe_path) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'set_auto) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'bound_mode)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vel_max))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'not_check_frontier) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ignore_time) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_global-request>) istream)
  "Deserializes a message object of type '<pci_global-request>"
    (cl:setf (cl:slot-value msg 'not_exe_path) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'set_auto) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'bound_mode)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vel_max) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'not_check_frontier) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'ignore_time) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_global-request>)))
  "Returns string type for a service object of type '<pci_global-request>"
  "planner_msgs/pci_globalRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_global-request)))
  "Returns string type for a service object of type 'pci_global-request"
  "planner_msgs/pci_globalRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_global-request>)))
  "Returns md5sum for a message object of type '<pci_global-request>"
  "b813db86654aa005e1e7d2d2ea812561")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_global-request)))
  "Returns md5sum for a message object of type 'pci_global-request"
  "b813db86654aa005e1e7d2d2ea812561")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_global-request>)))
  "Returns full string definition for message of type '<pci_global-request>"
  (cl:format cl:nil "# Request the planning through the planner control interface node.~%~%## Params for planner-control-interface~%# Set not_exe_path to true if don't want the robot to execute the path.~%bool not_exe_path~%# Set set_auto to true to change to auto mode and vice versa.~%bool set_auto~%uint8 bound_mode~%# Max velocity allowed.~%float32 vel_max~%~%## Params for planner~%# id of the frontier:~%# --> default is 0: auto-select the best frontier.~%# --> other than 0: manual select with feasibility check.~%int32 id~%# Don't check for frontier properties (e.g. leaf vertex, gain, ...).~%# This could be used to find a path to any vertex in the graph.~%bool not_check_frontier~%# Force the planner to provide the path regardless the time budget.~%bool ignore_time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_global-request)))
  "Returns full string definition for message of type 'pci_global-request"
  (cl:format cl:nil "# Request the planning through the planner control interface node.~%~%## Params for planner-control-interface~%# Set not_exe_path to true if don't want the robot to execute the path.~%bool not_exe_path~%# Set set_auto to true to change to auto mode and vice versa.~%bool set_auto~%uint8 bound_mode~%# Max velocity allowed.~%float32 vel_max~%~%## Params for planner~%# id of the frontier:~%# --> default is 0: auto-select the best frontier.~%# --> other than 0: manual select with feasibility check.~%int32 id~%# Don't check for frontier properties (e.g. leaf vertex, gain, ...).~%# This could be used to find a path to any vertex in the graph.~%bool not_check_frontier~%# Force the planner to provide the path regardless the time budget.~%bool ignore_time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_global-request>))
  (cl:+ 0
     1
     1
     1
     4
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_global-request>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_global-request
    (cl:cons ':not_exe_path (not_exe_path msg))
    (cl:cons ':set_auto (set_auto msg))
    (cl:cons ':bound_mode (bound_mode msg))
    (cl:cons ':vel_max (vel_max msg))
    (cl:cons ':id (id msg))
    (cl:cons ':not_check_frontier (not_check_frontier msg))
    (cl:cons ':ignore_time (ignore_time msg))
))
;//! \htmlinclude pci_global-response.msg.html

(cl:defclass <pci_global-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass pci_global-response (<pci_global-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_global-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_global-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_global-response> is deprecated: use planner_msgs-srv:pci_global-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <pci_global-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_global-response>) ostream)
  "Serializes a message object of type '<pci_global-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_global-response>) istream)
  "Deserializes a message object of type '<pci_global-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_global-response>)))
  "Returns string type for a service object of type '<pci_global-response>"
  "planner_msgs/pci_globalResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_global-response)))
  "Returns string type for a service object of type 'pci_global-response"
  "planner_msgs/pci_globalResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_global-response>)))
  "Returns md5sum for a message object of type '<pci_global-response>"
  "b813db86654aa005e1e7d2d2ea812561")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_global-response)))
  "Returns md5sum for a message object of type 'pci_global-response"
  "b813db86654aa005e1e7d2d2ea812561")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_global-response>)))
  "Returns full string definition for message of type '<pci_global-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_global-response)))
  "Returns full string definition for message of type 'pci_global-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_global-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_global-response>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_global-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'pci_global)))
  'pci_global-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'pci_global)))
  'pci_global-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_global)))
  "Returns string type for a service object of type '<pci_global>"
  "planner_msgs/pci_global")