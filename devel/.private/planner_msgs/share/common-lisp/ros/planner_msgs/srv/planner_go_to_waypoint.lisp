; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude planner_go_to_waypoint-request.msg.html

(cl:defclass <planner_go_to_waypoint-request> (roslisp-msg-protocol:ros-message)
  ((check_collision
    :reader check_collision
    :initarg :check_collision
    :type cl:boolean
    :initform cl:nil)
   (waypoint
    :reader waypoint
    :initarg :waypoint
    :type geometry_msgs-msg:PoseStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PoseStamped)))
)

(cl:defclass planner_go_to_waypoint-request (<planner_go_to_waypoint-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_go_to_waypoint-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_go_to_waypoint-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_go_to_waypoint-request> is deprecated: use planner_msgs-srv:planner_go_to_waypoint-request instead.")))

(cl:ensure-generic-function 'check_collision-val :lambda-list '(m))
(cl:defmethod check_collision-val ((m <planner_go_to_waypoint-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:check_collision-val is deprecated.  Use planner_msgs-srv:check_collision instead.")
  (check_collision m))

(cl:ensure-generic-function 'waypoint-val :lambda-list '(m))
(cl:defmethod waypoint-val ((m <planner_go_to_waypoint-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:waypoint-val is deprecated.  Use planner_msgs-srv:waypoint instead.")
  (waypoint m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_go_to_waypoint-request>) ostream)
  "Serializes a message object of type '<planner_go_to_waypoint-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'check_collision) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'waypoint) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_go_to_waypoint-request>) istream)
  "Deserializes a message object of type '<planner_go_to_waypoint-request>"
    (cl:setf (cl:slot-value msg 'check_collision) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'waypoint) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_go_to_waypoint-request>)))
  "Returns string type for a service object of type '<planner_go_to_waypoint-request>"
  "planner_msgs/planner_go_to_waypointRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_go_to_waypoint-request)))
  "Returns string type for a service object of type 'planner_go_to_waypoint-request"
  "planner_msgs/planner_go_to_waypointRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_go_to_waypoint-request>)))
  "Returns md5sum for a message object of type '<planner_go_to_waypoint-request>"
  "a26081f4c02132c8e0c868df86f2d5fe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_go_to_waypoint-request)))
  "Returns md5sum for a message object of type 'planner_go_to_waypoint-request"
  "a26081f4c02132c8e0c868df86f2d5fe")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_go_to_waypoint-request>)))
  "Returns full string definition for message of type '<planner_go_to_waypoint-request>"
  (cl:format cl:nil "bool check_collision~%geometry_msgs/PoseStamped waypoint~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_go_to_waypoint-request)))
  "Returns full string definition for message of type 'planner_go_to_waypoint-request"
  (cl:format cl:nil "bool check_collision~%geometry_msgs/PoseStamped waypoint~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_go_to_waypoint-request>))
  (cl:+ 0
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'waypoint))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_go_to_waypoint-request>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_go_to_waypoint-request
    (cl:cons ':check_collision (check_collision msg))
    (cl:cons ':waypoint (waypoint msg))
))
;//! \htmlinclude planner_go_to_waypoint-response.msg.html

(cl:defclass <planner_go_to_waypoint-response> (roslisp-msg-protocol:ros-message)
  ((path
    :reader path
    :initarg :path
    :type (cl:vector geometry_msgs-msg:Pose)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Pose :initial-element (cl:make-instance 'geometry_msgs-msg:Pose))))
)

(cl:defclass planner_go_to_waypoint-response (<planner_go_to_waypoint-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_go_to_waypoint-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_go_to_waypoint-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_go_to_waypoint-response> is deprecated: use planner_msgs-srv:planner_go_to_waypoint-response instead.")))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <planner_go_to_waypoint-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:path-val is deprecated.  Use planner_msgs-srv:path instead.")
  (path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_go_to_waypoint-response>) ostream)
  "Serializes a message object of type '<planner_go_to_waypoint-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'path))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_go_to_waypoint-response>) istream)
  "Deserializes a message object of type '<planner_go_to_waypoint-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_go_to_waypoint-response>)))
  "Returns string type for a service object of type '<planner_go_to_waypoint-response>"
  "planner_msgs/planner_go_to_waypointResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_go_to_waypoint-response)))
  "Returns string type for a service object of type 'planner_go_to_waypoint-response"
  "planner_msgs/planner_go_to_waypointResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_go_to_waypoint-response>)))
  "Returns md5sum for a message object of type '<planner_go_to_waypoint-response>"
  "a26081f4c02132c8e0c868df86f2d5fe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_go_to_waypoint-response)))
  "Returns md5sum for a message object of type 'planner_go_to_waypoint-response"
  "a26081f4c02132c8e0c868df86f2d5fe")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_go_to_waypoint-response>)))
  "Returns full string definition for message of type '<planner_go_to_waypoint-response>"
  (cl:format cl:nil "# Return best path.~%geometry_msgs/Pose[] path~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_go_to_waypoint-response)))
  "Returns full string definition for message of type 'planner_go_to_waypoint-response"
  (cl:format cl:nil "# Return best path.~%geometry_msgs/Pose[] path~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_go_to_waypoint-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'path) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_go_to_waypoint-response>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_go_to_waypoint-response
    (cl:cons ':path (path msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'planner_go_to_waypoint)))
  'planner_go_to_waypoint-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'planner_go_to_waypoint)))
  'planner_go_to_waypoint-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_go_to_waypoint)))
  "Returns string type for a service object of type '<planner_go_to_waypoint>"
  "planner_msgs/planner_go_to_waypoint")