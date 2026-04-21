; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude planner_homing-request.msg.html

(cl:defclass <planner_homing-request> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header)))
)

(cl:defclass planner_homing-request (<planner_homing-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_homing-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_homing-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_homing-request> is deprecated: use planner_msgs-srv:planner_homing-request instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <planner_homing-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:header-val is deprecated.  Use planner_msgs-srv:header instead.")
  (header m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_homing-request>) ostream)
  "Serializes a message object of type '<planner_homing-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_homing-request>) istream)
  "Deserializes a message object of type '<planner_homing-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_homing-request>)))
  "Returns string type for a service object of type '<planner_homing-request>"
  "planner_msgs/planner_homingRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_homing-request)))
  "Returns string type for a service object of type 'planner_homing-request"
  "planner_msgs/planner_homingRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_homing-request>)))
  "Returns md5sum for a message object of type '<planner_homing-request>"
  "0e9a67b6e01ddd6d303ae107f62349a1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_homing-request)))
  "Returns md5sum for a message object of type 'planner_homing-request"
  "0e9a67b6e01ddd6d303ae107f62349a1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_homing-request>)))
  "Returns full string definition for message of type '<planner_homing-request>"
  (cl:format cl:nil "# Request the planner get the shortest path to go home.~%Header header~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_homing-request)))
  "Returns full string definition for message of type 'planner_homing-request"
  (cl:format cl:nil "# Request the planner get the shortest path to go home.~%Header header~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_homing-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_homing-request>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_homing-request
    (cl:cons ':header (header msg))
))
;//! \htmlinclude planner_homing-response.msg.html

(cl:defclass <planner_homing-response> (roslisp-msg-protocol:ros-message)
  ((path
    :reader path
    :initarg :path
    :type (cl:vector geometry_msgs-msg:Pose)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Pose :initial-element (cl:make-instance 'geometry_msgs-msg:Pose))))
)

(cl:defclass planner_homing-response (<planner_homing-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_homing-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_homing-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_homing-response> is deprecated: use planner_msgs-srv:planner_homing-response instead.")))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <planner_homing-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:path-val is deprecated.  Use planner_msgs-srv:path instead.")
  (path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_homing-response>) ostream)
  "Serializes a message object of type '<planner_homing-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'path))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_homing-response>) istream)
  "Deserializes a message object of type '<planner_homing-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'path) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'path)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Pose))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_homing-response>)))
  "Returns string type for a service object of type '<planner_homing-response>"
  "planner_msgs/planner_homingResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_homing-response)))
  "Returns string type for a service object of type 'planner_homing-response"
  "planner_msgs/planner_homingResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_homing-response>)))
  "Returns md5sum for a message object of type '<planner_homing-response>"
  "0e9a67b6e01ddd6d303ae107f62349a1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_homing-response)))
  "Returns md5sum for a message object of type 'planner_homing-response"
  "0e9a67b6e01ddd6d303ae107f62349a1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_homing-response>)))
  "Returns full string definition for message of type '<planner_homing-response>"
  (cl:format cl:nil "# Return shortest path to go home.~%geometry_msgs/Pose[] path~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_homing-response)))
  "Returns full string definition for message of type 'planner_homing-response"
  (cl:format cl:nil "# Return shortest path to go home.~%geometry_msgs/Pose[] path~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_homing-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'path) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_homing-response>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_homing-response
    (cl:cons ':path (path msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'planner_homing)))
  'planner_homing-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'planner_homing)))
  'planner_homing-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_homing)))
  "Returns string type for a service object of type '<planner_homing>"
  "planner_msgs/planner_homing")