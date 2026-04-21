; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude pci_stop-request.msg.html

(cl:defclass <pci_stop-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass pci_stop-request (<pci_stop-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_stop-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_stop-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_stop-request> is deprecated: use planner_msgs-srv:pci_stop-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_stop-request>) ostream)
  "Serializes a message object of type '<pci_stop-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_stop-request>) istream)
  "Deserializes a message object of type '<pci_stop-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_stop-request>)))
  "Returns string type for a service object of type '<pci_stop-request>"
  "planner_msgs/pci_stopRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_stop-request)))
  "Returns string type for a service object of type 'pci_stop-request"
  "planner_msgs/pci_stopRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_stop-request>)))
  "Returns md5sum for a message object of type '<pci_stop-request>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_stop-request)))
  "Returns md5sum for a message object of type 'pci_stop-request"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_stop-request>)))
  "Returns full string definition for message of type '<pci_stop-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_stop-request)))
  "Returns full string definition for message of type 'pci_stop-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_stop-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_stop-request>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_stop-request
))
;//! \htmlinclude pci_stop-response.msg.html

(cl:defclass <pci_stop-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass pci_stop-response (<pci_stop-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_stop-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_stop-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_stop-response> is deprecated: use planner_msgs-srv:pci_stop-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <pci_stop-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_stop-response>) ostream)
  "Serializes a message object of type '<pci_stop-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_stop-response>) istream)
  "Deserializes a message object of type '<pci_stop-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_stop-response>)))
  "Returns string type for a service object of type '<pci_stop-response>"
  "planner_msgs/pci_stopResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_stop-response)))
  "Returns string type for a service object of type 'pci_stop-response"
  "planner_msgs/pci_stopResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_stop-response>)))
  "Returns md5sum for a message object of type '<pci_stop-response>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_stop-response)))
  "Returns md5sum for a message object of type 'pci_stop-response"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_stop-response>)))
  "Returns full string definition for message of type '<pci_stop-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_stop-response)))
  "Returns full string definition for message of type 'pci_stop-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_stop-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_stop-response>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_stop-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'pci_stop)))
  'pci_stop-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'pci_stop)))
  'pci_stop-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_stop)))
  "Returns string type for a service object of type '<pci_stop>"
  "planner_msgs/pci_stop")