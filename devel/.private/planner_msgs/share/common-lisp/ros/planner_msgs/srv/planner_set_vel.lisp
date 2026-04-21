; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude planner_set_vel-request.msg.html

(cl:defclass <planner_set_vel-request> (roslisp-msg-protocol:ros-message)
  ((root_vel
    :reader root_vel
    :initarg :root_vel
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist))
   (set
    :reader set
    :initarg :set
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass planner_set_vel-request (<planner_set_vel-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_set_vel-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_set_vel-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_set_vel-request> is deprecated: use planner_msgs-srv:planner_set_vel-request instead.")))

(cl:ensure-generic-function 'root_vel-val :lambda-list '(m))
(cl:defmethod root_vel-val ((m <planner_set_vel-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:root_vel-val is deprecated.  Use planner_msgs-srv:root_vel instead.")
  (root_vel m))

(cl:ensure-generic-function 'set-val :lambda-list '(m))
(cl:defmethod set-val ((m <planner_set_vel-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:set-val is deprecated.  Use planner_msgs-srv:set instead.")
  (set m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_set_vel-request>) ostream)
  "Serializes a message object of type '<planner_set_vel-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'root_vel) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'set) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_set_vel-request>) istream)
  "Deserializes a message object of type '<planner_set_vel-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'root_vel) istream)
    (cl:setf (cl:slot-value msg 'set) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_set_vel-request>)))
  "Returns string type for a service object of type '<planner_set_vel-request>"
  "planner_msgs/planner_set_velRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_set_vel-request)))
  "Returns string type for a service object of type 'planner_set_vel-request"
  "planner_msgs/planner_set_velRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_set_vel-request>)))
  "Returns md5sum for a message object of type '<planner_set_vel-request>"
  "f45ed41d58956a227be4845c1fe6bd6d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_set_vel-request)))
  "Returns md5sum for a message object of type 'planner_set_vel-request"
  "f45ed41d58956a227be4845c1fe6bd6d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_set_vel-request>)))
  "Returns full string definition for message of type '<planner_set_vel-request>"
  (cl:format cl:nil "geometry_msgs/Twist root_vel~%bool set~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3 linear~%Vector3 angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_set_vel-request)))
  "Returns full string definition for message of type 'planner_set_vel-request"
  (cl:format cl:nil "geometry_msgs/Twist root_vel~%bool set~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3 linear~%Vector3 angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_set_vel-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'root_vel))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_set_vel-request>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_set_vel-request
    (cl:cons ':root_vel (root_vel msg))
    (cl:cons ':set (set msg))
))
;//! \htmlinclude planner_set_vel-response.msg.html

(cl:defclass <planner_set_vel-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass planner_set_vel-response (<planner_set_vel-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_set_vel-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_set_vel-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_set_vel-response> is deprecated: use planner_msgs-srv:planner_set_vel-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <planner_set_vel-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_set_vel-response>) ostream)
  "Serializes a message object of type '<planner_set_vel-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_set_vel-response>) istream)
  "Deserializes a message object of type '<planner_set_vel-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_set_vel-response>)))
  "Returns string type for a service object of type '<planner_set_vel-response>"
  "planner_msgs/planner_set_velResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_set_vel-response)))
  "Returns string type for a service object of type 'planner_set_vel-response"
  "planner_msgs/planner_set_velResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_set_vel-response>)))
  "Returns md5sum for a message object of type '<planner_set_vel-response>"
  "f45ed41d58956a227be4845c1fe6bd6d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_set_vel-response)))
  "Returns md5sum for a message object of type 'planner_set_vel-response"
  "f45ed41d58956a227be4845c1fe6bd6d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_set_vel-response>)))
  "Returns full string definition for message of type '<planner_set_vel-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_set_vel-response)))
  "Returns full string definition for message of type 'planner_set_vel-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_set_vel-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_set_vel-response>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_set_vel-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'planner_set_vel)))
  'planner_set_vel-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'planner_set_vel)))
  'planner_set_vel-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_set_vel)))
  "Returns string type for a service object of type '<planner_set_vel>"
  "planner_msgs/planner_set_vel")