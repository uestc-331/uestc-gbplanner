; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude pci_homing_trigger-request.msg.html

(cl:defclass <pci_homing_trigger-request> (roslisp-msg-protocol:ros-message)
  ((not_exe_path
    :reader not_exe_path
    :initarg :not_exe_path
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass pci_homing_trigger-request (<pci_homing_trigger-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_homing_trigger-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_homing_trigger-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_homing_trigger-request> is deprecated: use planner_msgs-srv:pci_homing_trigger-request instead.")))

(cl:ensure-generic-function 'not_exe_path-val :lambda-list '(m))
(cl:defmethod not_exe_path-val ((m <pci_homing_trigger-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:not_exe_path-val is deprecated.  Use planner_msgs-srv:not_exe_path instead.")
  (not_exe_path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_homing_trigger-request>) ostream)
  "Serializes a message object of type '<pci_homing_trigger-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'not_exe_path) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_homing_trigger-request>) istream)
  "Deserializes a message object of type '<pci_homing_trigger-request>"
    (cl:setf (cl:slot-value msg 'not_exe_path) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_homing_trigger-request>)))
  "Returns string type for a service object of type '<pci_homing_trigger-request>"
  "planner_msgs/pci_homing_triggerRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_homing_trigger-request)))
  "Returns string type for a service object of type 'pci_homing_trigger-request"
  "planner_msgs/pci_homing_triggerRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_homing_trigger-request>)))
  "Returns md5sum for a message object of type '<pci_homing_trigger-request>"
  "9ac7156ead9cf693072fe52aad9e8e2c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_homing_trigger-request)))
  "Returns md5sum for a message object of type 'pci_homing_trigger-request"
  "9ac7156ead9cf693072fe52aad9e8e2c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_homing_trigger-request>)))
  "Returns full string definition for message of type '<pci_homing_trigger-request>"
  (cl:format cl:nil "# Request the planner control interface to guide the robot go home.~%# Set true if don't want to execute path.~%bool not_exe_path~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_homing_trigger-request)))
  "Returns full string definition for message of type 'pci_homing_trigger-request"
  (cl:format cl:nil "# Request the planner control interface to guide the robot go home.~%# Set true if don't want to execute path.~%bool not_exe_path~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_homing_trigger-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_homing_trigger-request>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_homing_trigger-request
    (cl:cons ':not_exe_path (not_exe_path msg))
))
;//! \htmlinclude pci_homing_trigger-response.msg.html

(cl:defclass <pci_homing_trigger-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass pci_homing_trigger-response (<pci_homing_trigger-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_homing_trigger-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_homing_trigger-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_homing_trigger-response> is deprecated: use planner_msgs-srv:pci_homing_trigger-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <pci_homing_trigger-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_homing_trigger-response>) ostream)
  "Serializes a message object of type '<pci_homing_trigger-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_homing_trigger-response>) istream)
  "Deserializes a message object of type '<pci_homing_trigger-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_homing_trigger-response>)))
  "Returns string type for a service object of type '<pci_homing_trigger-response>"
  "planner_msgs/pci_homing_triggerResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_homing_trigger-response)))
  "Returns string type for a service object of type 'pci_homing_trigger-response"
  "planner_msgs/pci_homing_triggerResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_homing_trigger-response>)))
  "Returns md5sum for a message object of type '<pci_homing_trigger-response>"
  "9ac7156ead9cf693072fe52aad9e8e2c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_homing_trigger-response)))
  "Returns md5sum for a message object of type 'pci_homing_trigger-response"
  "9ac7156ead9cf693072fe52aad9e8e2c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_homing_trigger-response>)))
  "Returns full string definition for message of type '<pci_homing_trigger-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_homing_trigger-response)))
  "Returns full string definition for message of type 'pci_homing_trigger-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_homing_trigger-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_homing_trigger-response>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_homing_trigger-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'pci_homing_trigger)))
  'pci_homing_trigger-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'pci_homing_trigger)))
  'pci_homing_trigger-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_homing_trigger)))
  "Returns string type for a service object of type '<pci_homing_trigger>"
  "planner_msgs/pci_homing_trigger")