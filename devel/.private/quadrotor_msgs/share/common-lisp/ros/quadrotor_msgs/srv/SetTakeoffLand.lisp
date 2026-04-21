; Auto-generated. Do not edit!


(cl:in-package quadrotor_msgs-srv)


;//! \htmlinclude SetTakeoffLand-request.msg.html

(cl:defclass <SetTakeoffLand-request> (roslisp-msg-protocol:ros-message)
  ((takeoff
    :reader takeoff
    :initarg :takeoff
    :type cl:boolean
    :initform cl:nil)
   (takeoff_altitude
    :reader takeoff_altitude
    :initarg :takeoff_altitude
    :type cl:float
    :initform 0.0))
)

(cl:defclass SetTakeoffLand-request (<SetTakeoffLand-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetTakeoffLand-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetTakeoffLand-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name quadrotor_msgs-srv:<SetTakeoffLand-request> is deprecated: use quadrotor_msgs-srv:SetTakeoffLand-request instead.")))

(cl:ensure-generic-function 'takeoff-val :lambda-list '(m))
(cl:defmethod takeoff-val ((m <SetTakeoffLand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadrotor_msgs-srv:takeoff-val is deprecated.  Use quadrotor_msgs-srv:takeoff instead.")
  (takeoff m))

(cl:ensure-generic-function 'takeoff_altitude-val :lambda-list '(m))
(cl:defmethod takeoff_altitude-val ((m <SetTakeoffLand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadrotor_msgs-srv:takeoff_altitude-val is deprecated.  Use quadrotor_msgs-srv:takeoff_altitude instead.")
  (takeoff_altitude m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetTakeoffLand-request>) ostream)
  "Serializes a message object of type '<SetTakeoffLand-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'takeoff) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'takeoff_altitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetTakeoffLand-request>) istream)
  "Deserializes a message object of type '<SetTakeoffLand-request>"
    (cl:setf (cl:slot-value msg 'takeoff) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'takeoff_altitude) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetTakeoffLand-request>)))
  "Returns string type for a service object of type '<SetTakeoffLand-request>"
  "quadrotor_msgs/SetTakeoffLandRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetTakeoffLand-request)))
  "Returns string type for a service object of type 'SetTakeoffLand-request"
  "quadrotor_msgs/SetTakeoffLandRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetTakeoffLand-request>)))
  "Returns md5sum for a message object of type '<SetTakeoffLand-request>"
  "34300860f54be45144752987f014ec7e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetTakeoffLand-request)))
  "Returns md5sum for a message object of type 'SetTakeoffLand-request"
  "34300860f54be45144752987f014ec7e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetTakeoffLand-request>)))
  "Returns full string definition for message of type '<SetTakeoffLand-request>"
  (cl:format cl:nil "bool takeoff ~%float32 takeoff_altitude~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetTakeoffLand-request)))
  "Returns full string definition for message of type 'SetTakeoffLand-request"
  (cl:format cl:nil "bool takeoff ~%float32 takeoff_altitude~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetTakeoffLand-request>))
  (cl:+ 0
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetTakeoffLand-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetTakeoffLand-request
    (cl:cons ':takeoff (takeoff msg))
    (cl:cons ':takeoff_altitude (takeoff_altitude msg))
))
;//! \htmlinclude SetTakeoffLand-response.msg.html

(cl:defclass <SetTakeoffLand-response> (roslisp-msg-protocol:ros-message)
  ((res
    :reader res
    :initarg :res
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SetTakeoffLand-response (<SetTakeoffLand-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetTakeoffLand-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetTakeoffLand-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name quadrotor_msgs-srv:<SetTakeoffLand-response> is deprecated: use quadrotor_msgs-srv:SetTakeoffLand-response instead.")))

(cl:ensure-generic-function 'res-val :lambda-list '(m))
(cl:defmethod res-val ((m <SetTakeoffLand-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader quadrotor_msgs-srv:res-val is deprecated.  Use quadrotor_msgs-srv:res instead.")
  (res m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetTakeoffLand-response>) ostream)
  "Serializes a message object of type '<SetTakeoffLand-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'res) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetTakeoffLand-response>) istream)
  "Deserializes a message object of type '<SetTakeoffLand-response>"
    (cl:setf (cl:slot-value msg 'res) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetTakeoffLand-response>)))
  "Returns string type for a service object of type '<SetTakeoffLand-response>"
  "quadrotor_msgs/SetTakeoffLandResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetTakeoffLand-response)))
  "Returns string type for a service object of type 'SetTakeoffLand-response"
  "quadrotor_msgs/SetTakeoffLandResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetTakeoffLand-response>)))
  "Returns md5sum for a message object of type '<SetTakeoffLand-response>"
  "34300860f54be45144752987f014ec7e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetTakeoffLand-response)))
  "Returns md5sum for a message object of type 'SetTakeoffLand-response"
  "34300860f54be45144752987f014ec7e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetTakeoffLand-response>)))
  "Returns full string definition for message of type '<SetTakeoffLand-response>"
  (cl:format cl:nil "bool res~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetTakeoffLand-response)))
  "Returns full string definition for message of type 'SetTakeoffLand-response"
  (cl:format cl:nil "bool res~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetTakeoffLand-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetTakeoffLand-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetTakeoffLand-response
    (cl:cons ':res (res msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetTakeoffLand)))
  'SetTakeoffLand-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetTakeoffLand)))
  'SetTakeoffLand-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetTakeoffLand)))
  "Returns string type for a service object of type '<SetTakeoffLand>"
  "quadrotor_msgs/SetTakeoffLand")