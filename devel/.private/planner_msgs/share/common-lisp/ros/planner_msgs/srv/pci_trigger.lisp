; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude pci_trigger-request.msg.html

(cl:defclass <pci_trigger-request> (roslisp-msg-protocol:ros-message)
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
    :initform 0.0))
)

(cl:defclass pci_trigger-request (<pci_trigger-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_trigger-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_trigger-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_trigger-request> is deprecated: use planner_msgs-srv:pci_trigger-request instead.")))

(cl:ensure-generic-function 'not_exe_path-val :lambda-list '(m))
(cl:defmethod not_exe_path-val ((m <pci_trigger-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:not_exe_path-val is deprecated.  Use planner_msgs-srv:not_exe_path instead.")
  (not_exe_path m))

(cl:ensure-generic-function 'set_auto-val :lambda-list '(m))
(cl:defmethod set_auto-val ((m <pci_trigger-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:set_auto-val is deprecated.  Use planner_msgs-srv:set_auto instead.")
  (set_auto m))

(cl:ensure-generic-function 'bound_mode-val :lambda-list '(m))
(cl:defmethod bound_mode-val ((m <pci_trigger-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:bound_mode-val is deprecated.  Use planner_msgs-srv:bound_mode instead.")
  (bound_mode m))

(cl:ensure-generic-function 'vel_max-val :lambda-list '(m))
(cl:defmethod vel_max-val ((m <pci_trigger-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:vel_max-val is deprecated.  Use planner_msgs-srv:vel_max instead.")
  (vel_max m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_trigger-request>) ostream)
  "Serializes a message object of type '<pci_trigger-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'not_exe_path) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'set_auto) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'bound_mode)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vel_max))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_trigger-request>) istream)
  "Deserializes a message object of type '<pci_trigger-request>"
    (cl:setf (cl:slot-value msg 'not_exe_path) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'set_auto) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'bound_mode)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vel_max) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_trigger-request>)))
  "Returns string type for a service object of type '<pci_trigger-request>"
  "planner_msgs/pci_triggerRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_trigger-request)))
  "Returns string type for a service object of type 'pci_trigger-request"
  "planner_msgs/pci_triggerRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_trigger-request>)))
  "Returns md5sum for a message object of type '<pci_trigger-request>"
  "0fd8cc9320dacbac91111ce9de934668")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_trigger-request)))
  "Returns md5sum for a message object of type 'pci_trigger-request"
  "0fd8cc9320dacbac91111ce9de934668")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_trigger-request>)))
  "Returns full string definition for message of type '<pci_trigger-request>"
  (cl:format cl:nil "# Request the planning through the planner control interface node.~%~%# Set not_exe_path to true if don't want the robot to execute the path.~%bool not_exe_path~%# Set set_auto to true to change to auto mode and vice versa.~%bool set_auto~%uint8 bound_mode~%~%# Max velocity allowed.~%float32 vel_max~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_trigger-request)))
  "Returns full string definition for message of type 'pci_trigger-request"
  (cl:format cl:nil "# Request the planning through the planner control interface node.~%~%# Set not_exe_path to true if don't want the robot to execute the path.~%bool not_exe_path~%# Set set_auto to true to change to auto mode and vice versa.~%bool set_auto~%uint8 bound_mode~%~%# Max velocity allowed.~%float32 vel_max~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_trigger-request>))
  (cl:+ 0
     1
     1
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_trigger-request>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_trigger-request
    (cl:cons ':not_exe_path (not_exe_path msg))
    (cl:cons ':set_auto (set_auto msg))
    (cl:cons ':bound_mode (bound_mode msg))
    (cl:cons ':vel_max (vel_max msg))
))
;//! \htmlinclude pci_trigger-response.msg.html

(cl:defclass <pci_trigger-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass pci_trigger-response (<pci_trigger-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_trigger-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_trigger-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_trigger-response> is deprecated: use planner_msgs-srv:pci_trigger-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <pci_trigger-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_trigger-response>) ostream)
  "Serializes a message object of type '<pci_trigger-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_trigger-response>) istream)
  "Deserializes a message object of type '<pci_trigger-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_trigger-response>)))
  "Returns string type for a service object of type '<pci_trigger-response>"
  "planner_msgs/pci_triggerResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_trigger-response)))
  "Returns string type for a service object of type 'pci_trigger-response"
  "planner_msgs/pci_triggerResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_trigger-response>)))
  "Returns md5sum for a message object of type '<pci_trigger-response>"
  "0fd8cc9320dacbac91111ce9de934668")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_trigger-response)))
  "Returns md5sum for a message object of type 'pci_trigger-response"
  "0fd8cc9320dacbac91111ce9de934668")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_trigger-response>)))
  "Returns full string definition for message of type '<pci_trigger-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_trigger-response)))
  "Returns full string definition for message of type 'pci_trigger-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_trigger-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_trigger-response>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_trigger-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'pci_trigger)))
  'pci_trigger-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'pci_trigger)))
  'pci_trigger-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_trigger)))
  "Returns string type for a service object of type '<pci_trigger>"
  "planner_msgs/pci_trigger")