; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude pci_to_waypoint-request.msg.html

(cl:defclass <pci_to_waypoint-request> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (waypoint
    :reader waypoint
    :initarg :waypoint
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose)))
)

(cl:defclass pci_to_waypoint-request (<pci_to_waypoint-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_to_waypoint-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_to_waypoint-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_to_waypoint-request> is deprecated: use planner_msgs-srv:pci_to_waypoint-request instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <pci_to_waypoint-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:header-val is deprecated.  Use planner_msgs-srv:header instead.")
  (header m))

(cl:ensure-generic-function 'waypoint-val :lambda-list '(m))
(cl:defmethod waypoint-val ((m <pci_to_waypoint-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:waypoint-val is deprecated.  Use planner_msgs-srv:waypoint instead.")
  (waypoint m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_to_waypoint-request>) ostream)
  "Serializes a message object of type '<pci_to_waypoint-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'waypoint) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_to_waypoint-request>) istream)
  "Deserializes a message object of type '<pci_to_waypoint-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'waypoint) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_to_waypoint-request>)))
  "Returns string type for a service object of type '<pci_to_waypoint-request>"
  "planner_msgs/pci_to_waypointRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_to_waypoint-request)))
  "Returns string type for a service object of type 'pci_to_waypoint-request"
  "planner_msgs/pci_to_waypointRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_to_waypoint-request>)))
  "Returns md5sum for a message object of type '<pci_to_waypoint-request>"
  "7f5b5ed73b4dc3c42d1110aac543afa5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_to_waypoint-request)))
  "Returns md5sum for a message object of type 'pci_to_waypoint-request"
  "7f5b5ed73b4dc3c42d1110aac543afa5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_to_waypoint-request>)))
  "Returns full string definition for message of type '<pci_to_waypoint-request>"
  (cl:format cl:nil "# Force the robot to go to a waypoint~%Header header~%~%# Return best path.~%geometry_msgs/Pose waypoint~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_to_waypoint-request)))
  "Returns full string definition for message of type 'pci_to_waypoint-request"
  (cl:format cl:nil "# Force the robot to go to a waypoint~%Header header~%~%# Return best path.~%geometry_msgs/Pose waypoint~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_to_waypoint-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'waypoint))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_to_waypoint-request>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_to_waypoint-request
    (cl:cons ':header (header msg))
    (cl:cons ':waypoint (waypoint msg))
))
;//! \htmlinclude pci_to_waypoint-response.msg.html

(cl:defclass <pci_to_waypoint-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass pci_to_waypoint-response (<pci_to_waypoint-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_to_waypoint-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_to_waypoint-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_to_waypoint-response> is deprecated: use planner_msgs-srv:pci_to_waypoint-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_to_waypoint-response>) ostream)
  "Serializes a message object of type '<pci_to_waypoint-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_to_waypoint-response>) istream)
  "Deserializes a message object of type '<pci_to_waypoint-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_to_waypoint-response>)))
  "Returns string type for a service object of type '<pci_to_waypoint-response>"
  "planner_msgs/pci_to_waypointResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_to_waypoint-response)))
  "Returns string type for a service object of type 'pci_to_waypoint-response"
  "planner_msgs/pci_to_waypointResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_to_waypoint-response>)))
  "Returns md5sum for a message object of type '<pci_to_waypoint-response>"
  "7f5b5ed73b4dc3c42d1110aac543afa5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_to_waypoint-response)))
  "Returns md5sum for a message object of type 'pci_to_waypoint-response"
  "7f5b5ed73b4dc3c42d1110aac543afa5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_to_waypoint-response>)))
  "Returns full string definition for message of type '<pci_to_waypoint-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_to_waypoint-response)))
  "Returns full string definition for message of type 'pci_to_waypoint-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_to_waypoint-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_to_waypoint-response>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_to_waypoint-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'pci_to_waypoint)))
  'pci_to_waypoint-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'pci_to_waypoint)))
  'pci_to_waypoint-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_to_waypoint)))
  "Returns string type for a service object of type '<pci_to_waypoint>"
  "planner_msgs/pci_to_waypoint")