; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude planner_dynamic_global_bound-request.msg.html

(cl:defclass <planner_dynamic_global_bound-request> (roslisp-msg-protocol:ros-message)
  ((reset_to_default
    :reader reset_to_default
    :initarg :reset_to_default
    :type cl:boolean
    :initform cl:nil)
   (header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (center
    :reader center
    :initarg :center
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (left
    :reader left
    :initarg :left
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (front
    :reader front
    :initarg :front
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (up
    :reader up
    :initarg :up
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point)))
)

(cl:defclass planner_dynamic_global_bound-request (<planner_dynamic_global_bound-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_dynamic_global_bound-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_dynamic_global_bound-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_dynamic_global_bound-request> is deprecated: use planner_msgs-srv:planner_dynamic_global_bound-request instead.")))

(cl:ensure-generic-function 'reset_to_default-val :lambda-list '(m))
(cl:defmethod reset_to_default-val ((m <planner_dynamic_global_bound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:reset_to_default-val is deprecated.  Use planner_msgs-srv:reset_to_default instead.")
  (reset_to_default m))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <planner_dynamic_global_bound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:header-val is deprecated.  Use planner_msgs-srv:header instead.")
  (header m))

(cl:ensure-generic-function 'center-val :lambda-list '(m))
(cl:defmethod center-val ((m <planner_dynamic_global_bound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:center-val is deprecated.  Use planner_msgs-srv:center instead.")
  (center m))

(cl:ensure-generic-function 'left-val :lambda-list '(m))
(cl:defmethod left-val ((m <planner_dynamic_global_bound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:left-val is deprecated.  Use planner_msgs-srv:left instead.")
  (left m))

(cl:ensure-generic-function 'front-val :lambda-list '(m))
(cl:defmethod front-val ((m <planner_dynamic_global_bound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:front-val is deprecated.  Use planner_msgs-srv:front instead.")
  (front m))

(cl:ensure-generic-function 'up-val :lambda-list '(m))
(cl:defmethod up-val ((m <planner_dynamic_global_bound-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:up-val is deprecated.  Use planner_msgs-srv:up instead.")
  (up m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_dynamic_global_bound-request>) ostream)
  "Serializes a message object of type '<planner_dynamic_global_bound-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'reset_to_default) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'center) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'left) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'front) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'up) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_dynamic_global_bound-request>) istream)
  "Deserializes a message object of type '<planner_dynamic_global_bound-request>"
    (cl:setf (cl:slot-value msg 'reset_to_default) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'center) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'left) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'front) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'up) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_dynamic_global_bound-request>)))
  "Returns string type for a service object of type '<planner_dynamic_global_bound-request>"
  "planner_msgs/planner_dynamic_global_boundRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_dynamic_global_bound-request)))
  "Returns string type for a service object of type 'planner_dynamic_global_bound-request"
  "planner_msgs/planner_dynamic_global_boundRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_dynamic_global_bound-request>)))
  "Returns md5sum for a message object of type '<planner_dynamic_global_bound-request>"
  "31ef93df2f4c5feda83abcda3ab1ffb3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_dynamic_global_bound-request)))
  "Returns md5sum for a message object of type 'planner_dynamic_global_bound-request"
  "31ef93df2f4c5feda83abcda3ab1ffb3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_dynamic_global_bound-request>)))
  "Returns full string definition for message of type '<planner_dynamic_global_bound-request>"
  (cl:format cl:nil "# reset_to_default:~%#   true:  reset to the default bounding box~%#   false: set new bounding box~%bool reset_to_default~%~%# Header contains the frame in which the bounding box is expressed~%std_msgs/Header header~%~%# All coordinates are absolute and expressed in global frame (as set in the header)~%geometry_msgs/Point center  # Origin of bounding box~%geometry_msgs/Point left    # Vertex on the left of center when looking along the vector of the bb~%geometry_msgs/Point front   # Vertex in the front of center when looking along the vector of the bb~%geometry_msgs/Point up      # Vertex above center when looking along the vector of the bb~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_dynamic_global_bound-request)))
  "Returns full string definition for message of type 'planner_dynamic_global_bound-request"
  (cl:format cl:nil "# reset_to_default:~%#   true:  reset to the default bounding box~%#   false: set new bounding box~%bool reset_to_default~%~%# Header contains the frame in which the bounding box is expressed~%std_msgs/Header header~%~%# All coordinates are absolute and expressed in global frame (as set in the header)~%geometry_msgs/Point center  # Origin of bounding box~%geometry_msgs/Point left    # Vertex on the left of center when looking along the vector of the bb~%geometry_msgs/Point front   # Vertex in the front of center when looking along the vector of the bb~%geometry_msgs/Point up      # Vertex above center when looking along the vector of the bb~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_dynamic_global_bound-request>))
  (cl:+ 0
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'center))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'left))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'front))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'up))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_dynamic_global_bound-request>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_dynamic_global_bound-request
    (cl:cons ':reset_to_default (reset_to_default msg))
    (cl:cons ':header (header msg))
    (cl:cons ':center (center msg))
    (cl:cons ':left (left msg))
    (cl:cons ':front (front msg))
    (cl:cons ':up (up msg))
))
;//! \htmlinclude planner_dynamic_global_bound-response.msg.html

(cl:defclass <planner_dynamic_global_bound-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass planner_dynamic_global_bound-response (<planner_dynamic_global_bound-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_dynamic_global_bound-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_dynamic_global_bound-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_dynamic_global_bound-response> is deprecated: use planner_msgs-srv:planner_dynamic_global_bound-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <planner_dynamic_global_bound-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_dynamic_global_bound-response>) ostream)
  "Serializes a message object of type '<planner_dynamic_global_bound-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_dynamic_global_bound-response>) istream)
  "Deserializes a message object of type '<planner_dynamic_global_bound-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_dynamic_global_bound-response>)))
  "Returns string type for a service object of type '<planner_dynamic_global_bound-response>"
  "planner_msgs/planner_dynamic_global_boundResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_dynamic_global_bound-response)))
  "Returns string type for a service object of type 'planner_dynamic_global_bound-response"
  "planner_msgs/planner_dynamic_global_boundResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_dynamic_global_bound-response>)))
  "Returns md5sum for a message object of type '<planner_dynamic_global_bound-response>"
  "31ef93df2f4c5feda83abcda3ab1ffb3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_dynamic_global_bound-response)))
  "Returns md5sum for a message object of type 'planner_dynamic_global_bound-response"
  "31ef93df2f4c5feda83abcda3ab1ffb3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_dynamic_global_bound-response>)))
  "Returns full string definition for message of type '<planner_dynamic_global_bound-response>"
  (cl:format cl:nil "~%bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_dynamic_global_bound-response)))
  "Returns full string definition for message of type 'planner_dynamic_global_bound-response"
  (cl:format cl:nil "~%bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_dynamic_global_bound-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_dynamic_global_bound-response>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_dynamic_global_bound-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'planner_dynamic_global_bound)))
  'planner_dynamic_global_bound-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'planner_dynamic_global_bound)))
  'planner_dynamic_global_bound-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_dynamic_global_bound)))
  "Returns string type for a service object of type '<planner_dynamic_global_bound>"
  "planner_msgs/planner_dynamic_global_bound")