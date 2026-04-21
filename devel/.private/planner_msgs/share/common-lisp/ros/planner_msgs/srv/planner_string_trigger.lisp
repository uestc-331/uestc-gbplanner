; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude planner_string_trigger-request.msg.html

(cl:defclass <planner_string_trigger-request> (roslisp-msg-protocol:ros-message)
  ((message
    :reader message
    :initarg :message
    :type cl:string
    :initform ""))
)

(cl:defclass planner_string_trigger-request (<planner_string_trigger-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_string_trigger-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_string_trigger-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_string_trigger-request> is deprecated: use planner_msgs-srv:planner_string_trigger-request instead.")))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <planner_string_trigger-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:message-val is deprecated.  Use planner_msgs-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_string_trigger-request>) ostream)
  "Serializes a message object of type '<planner_string_trigger-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_string_trigger-request>) istream)
  "Deserializes a message object of type '<planner_string_trigger-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_string_trigger-request>)))
  "Returns string type for a service object of type '<planner_string_trigger-request>"
  "planner_msgs/planner_string_triggerRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_string_trigger-request)))
  "Returns string type for a service object of type 'planner_string_trigger-request"
  "planner_msgs/planner_string_triggerRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_string_trigger-request>)))
  "Returns md5sum for a message object of type '<planner_string_trigger-request>"
  "8b7095eb8dcd517ba7c37a0a06dcc50b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_string_trigger-request)))
  "Returns md5sum for a message object of type 'planner_string_trigger-request"
  "8b7095eb8dcd517ba7c37a0a06dcc50b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_string_trigger-request>)))
  "Returns full string definition for message of type '<planner_string_trigger-request>"
  (cl:format cl:nil "string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_string_trigger-request)))
  "Returns full string definition for message of type 'planner_string_trigger-request"
  (cl:format cl:nil "string message~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_string_trigger-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_string_trigger-request>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_string_trigger-request
    (cl:cons ':message (message msg))
))
;//! \htmlinclude planner_string_trigger-response.msg.html

(cl:defclass <planner_string_trigger-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass planner_string_trigger-response (<planner_string_trigger-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_string_trigger-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_string_trigger-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_string_trigger-response> is deprecated: use planner_msgs-srv:planner_string_trigger-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <planner_string_trigger-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_string_trigger-response>) ostream)
  "Serializes a message object of type '<planner_string_trigger-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_string_trigger-response>) istream)
  "Deserializes a message object of type '<planner_string_trigger-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_string_trigger-response>)))
  "Returns string type for a service object of type '<planner_string_trigger-response>"
  "planner_msgs/planner_string_triggerResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_string_trigger-response)))
  "Returns string type for a service object of type 'planner_string_trigger-response"
  "planner_msgs/planner_string_triggerResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_string_trigger-response>)))
  "Returns md5sum for a message object of type '<planner_string_trigger-response>"
  "8b7095eb8dcd517ba7c37a0a06dcc50b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_string_trigger-response)))
  "Returns md5sum for a message object of type 'planner_string_trigger-response"
  "8b7095eb8dcd517ba7c37a0a06dcc50b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_string_trigger-response>)))
  "Returns full string definition for message of type '<planner_string_trigger-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_string_trigger-response)))
  "Returns full string definition for message of type 'planner_string_trigger-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_string_trigger-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_string_trigger-response>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_string_trigger-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'planner_string_trigger)))
  'planner_string_trigger-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'planner_string_trigger)))
  'planner_string_trigger-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_string_trigger)))
  "Returns string type for a service object of type '<planner_string_trigger>"
  "planner_msgs/planner_string_trigger")