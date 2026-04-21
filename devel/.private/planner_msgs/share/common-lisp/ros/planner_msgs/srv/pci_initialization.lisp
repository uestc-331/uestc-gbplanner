; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude pci_initialization-request.msg.html

(cl:defclass <pci_initialization-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass pci_initialization-request (<pci_initialization-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_initialization-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_initialization-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_initialization-request> is deprecated: use planner_msgs-srv:pci_initialization-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_initialization-request>) ostream)
  "Serializes a message object of type '<pci_initialization-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_initialization-request>) istream)
  "Deserializes a message object of type '<pci_initialization-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_initialization-request>)))
  "Returns string type for a service object of type '<pci_initialization-request>"
  "planner_msgs/pci_initializationRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_initialization-request)))
  "Returns string type for a service object of type 'pci_initialization-request"
  "planner_msgs/pci_initializationRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_initialization-request>)))
  "Returns md5sum for a message object of type '<pci_initialization-request>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_initialization-request)))
  "Returns md5sum for a message object of type 'pci_initialization-request"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_initialization-request>)))
  "Returns full string definition for message of type '<pci_initialization-request>"
  (cl:format cl:nil "# Request the PCI perform initialization; for example, auto arm and take-off.~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_initialization-request)))
  "Returns full string definition for message of type 'pci_initialization-request"
  (cl:format cl:nil "# Request the PCI perform initialization; for example, auto arm and take-off.~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_initialization-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_initialization-request>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_initialization-request
))
;//! \htmlinclude pci_initialization-response.msg.html

(cl:defclass <pci_initialization-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass pci_initialization-response (<pci_initialization-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_initialization-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_initialization-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_initialization-response> is deprecated: use planner_msgs-srv:pci_initialization-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <pci_initialization-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_initialization-response>) ostream)
  "Serializes a message object of type '<pci_initialization-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_initialization-response>) istream)
  "Deserializes a message object of type '<pci_initialization-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_initialization-response>)))
  "Returns string type for a service object of type '<pci_initialization-response>"
  "planner_msgs/pci_initializationResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_initialization-response)))
  "Returns string type for a service object of type 'pci_initialization-response"
  "planner_msgs/pci_initializationResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_initialization-response>)))
  "Returns md5sum for a message object of type '<pci_initialization-response>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_initialization-response)))
  "Returns md5sum for a message object of type 'pci_initialization-response"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_initialization-response>)))
  "Returns full string definition for message of type '<pci_initialization-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_initialization-response)))
  "Returns full string definition for message of type 'pci_initialization-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_initialization-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_initialization-response>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_initialization-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'pci_initialization)))
  'pci_initialization-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'pci_initialization)))
  'pci_initialization-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_initialization)))
  "Returns string type for a service object of type '<pci_initialization>"
  "planner_msgs/pci_initialization")