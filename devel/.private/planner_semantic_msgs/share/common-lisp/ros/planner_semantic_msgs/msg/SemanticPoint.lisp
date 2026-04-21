; Auto-generated. Do not edit!


(cl:in-package planner_semantic_msgs-msg)


;//! \htmlinclude SemanticPoint.msg.html

(cl:defclass <SemanticPoint> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (type
    :reader type
    :initarg :type
    :type planner_semantic_msgs-msg:SemanticClass
    :initform (cl:make-instance 'planner_semantic_msgs-msg:SemanticClass))
   (description
    :reader description
    :initarg :description
    :type std_msgs-msg:String
    :initform (cl:make-instance 'std_msgs-msg:String))
   (point
    :reader point
    :initarg :point
    :type geometry_msgs-msg:Point32
    :initform (cl:make-instance 'geometry_msgs-msg:Point32)))
)

(cl:defclass SemanticPoint (<SemanticPoint>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SemanticPoint>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SemanticPoint)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_semantic_msgs-msg:<SemanticPoint> is deprecated: use planner_semantic_msgs-msg:SemanticPoint instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <SemanticPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_semantic_msgs-msg:header-val is deprecated.  Use planner_semantic_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <SemanticPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_semantic_msgs-msg:type-val is deprecated.  Use planner_semantic_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'description-val :lambda-list '(m))
(cl:defmethod description-val ((m <SemanticPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_semantic_msgs-msg:description-val is deprecated.  Use planner_semantic_msgs-msg:description instead.")
  (description m))

(cl:ensure-generic-function 'point-val :lambda-list '(m))
(cl:defmethod point-val ((m <SemanticPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_semantic_msgs-msg:point-val is deprecated.  Use planner_semantic_msgs-msg:point instead.")
  (point m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SemanticPoint>) ostream)
  "Serializes a message object of type '<SemanticPoint>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'type) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'description) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'point) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SemanticPoint>) istream)
  "Deserializes a message object of type '<SemanticPoint>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'type) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'description) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'point) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SemanticPoint>)))
  "Returns string type for a message object of type '<SemanticPoint>"
  "planner_semantic_msgs/SemanticPoint")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SemanticPoint)))
  "Returns string type for a message object of type 'SemanticPoint"
  "planner_semantic_msgs/SemanticPoint")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SemanticPoint>)))
  "Returns md5sum for a message object of type '<SemanticPoint>"
  "b4e8d6f91194ca358a218194b2f66232")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SemanticPoint)))
  "Returns md5sum for a message object of type 'SemanticPoint"
  "b4e8d6f91194ca358a218194b2f66232")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SemanticPoint>)))
  "Returns full string definition for message of type '<SemanticPoint>"
  (cl:format cl:nil "# Represent semantics as a 3D point~%std_msgs/Header header~%~%# Class of semantics~%planner_semantic_msgs/SemanticClass type~%~%# Further info if needed~%std_msgs/String description~%~%# Coordinate of the semantics~%geometry_msgs/Point32 point~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: planner_semantic_msgs/SemanticClass~%# Semantic classes~%int32 kNone = 0~%int32 kStaircase = 1~%int32 kDoor = 2~%~%# Can only choose one of the above~%int32 value~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SemanticPoint)))
  "Returns full string definition for message of type 'SemanticPoint"
  (cl:format cl:nil "# Represent semantics as a 3D point~%std_msgs/Header header~%~%# Class of semantics~%planner_semantic_msgs/SemanticClass type~%~%# Further info if needed~%std_msgs/String description~%~%# Coordinate of the semantics~%geometry_msgs/Point32 point~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: planner_semantic_msgs/SemanticClass~%# Semantic classes~%int32 kNone = 0~%int32 kStaircase = 1~%int32 kDoor = 2~%~%# Can only choose one of the above~%int32 value~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SemanticPoint>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'type))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'description))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'point))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SemanticPoint>))
  "Converts a ROS message object to a list"
  (cl:list 'SemanticPoint
    (cl:cons ':header (header msg))
    (cl:cons ':type (type msg))
    (cl:cons ':description (description msg))
    (cl:cons ':point (point msg))
))
