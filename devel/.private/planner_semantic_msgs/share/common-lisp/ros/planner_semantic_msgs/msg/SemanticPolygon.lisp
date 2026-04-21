; Auto-generated. Do not edit!


(cl:in-package planner_semantic_msgs-msg)


;//! \htmlinclude SemanticPolygon.msg.html

(cl:defclass <SemanticPolygon> (roslisp-msg-protocol:ros-message)
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
   (polygon
    :reader polygon
    :initarg :polygon
    :type geometry_msgs-msg:Polygon
    :initform (cl:make-instance 'geometry_msgs-msg:Polygon)))
)

(cl:defclass SemanticPolygon (<SemanticPolygon>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SemanticPolygon>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SemanticPolygon)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_semantic_msgs-msg:<SemanticPolygon> is deprecated: use planner_semantic_msgs-msg:SemanticPolygon instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <SemanticPolygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_semantic_msgs-msg:header-val is deprecated.  Use planner_semantic_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <SemanticPolygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_semantic_msgs-msg:type-val is deprecated.  Use planner_semantic_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'description-val :lambda-list '(m))
(cl:defmethod description-val ((m <SemanticPolygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_semantic_msgs-msg:description-val is deprecated.  Use planner_semantic_msgs-msg:description instead.")
  (description m))

(cl:ensure-generic-function 'polygon-val :lambda-list '(m))
(cl:defmethod polygon-val ((m <SemanticPolygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_semantic_msgs-msg:polygon-val is deprecated.  Use planner_semantic_msgs-msg:polygon instead.")
  (polygon m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SemanticPolygon>) ostream)
  "Serializes a message object of type '<SemanticPolygon>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'type) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'description) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'polygon) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SemanticPolygon>) istream)
  "Deserializes a message object of type '<SemanticPolygon>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'type) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'description) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'polygon) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SemanticPolygon>)))
  "Returns string type for a message object of type '<SemanticPolygon>"
  "planner_semantic_msgs/SemanticPolygon")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SemanticPolygon)))
  "Returns string type for a message object of type 'SemanticPolygon"
  "planner_semantic_msgs/SemanticPolygon")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SemanticPolygon>)))
  "Returns md5sum for a message object of type '<SemanticPolygon>"
  "3e757e567e8c954d178e7a622f70ad73")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SemanticPolygon)))
  "Returns md5sum for a message object of type 'SemanticPolygon"
  "3e757e567e8c954d178e7a622f70ad73")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SemanticPolygon>)))
  "Returns full string definition for message of type '<SemanticPolygon>"
  (cl:format cl:nil "# Represent semantics as a flat 3D polygon~%std_msgs/Header header~%~%# Class of semantics~%planner_semantic_msgs/SemanticClass type~%~%# Further info if needed~%std_msgs/String description~%~%# Coordinate of 4 corners of the polygon listed in clockwise direction~%geometry_msgs/Polygon polygon~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: planner_semantic_msgs/SemanticClass~%# Semantic classes~%int32 kNone = 0~%int32 kStaircase = 1~%int32 kDoor = 2~%~%# Can only choose one of the above~%int32 value~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SemanticPolygon)))
  "Returns full string definition for message of type 'SemanticPolygon"
  (cl:format cl:nil "# Represent semantics as a flat 3D polygon~%std_msgs/Header header~%~%# Class of semantics~%planner_semantic_msgs/SemanticClass type~%~%# Further info if needed~%std_msgs/String description~%~%# Coordinate of 4 corners of the polygon listed in clockwise direction~%geometry_msgs/Polygon polygon~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: planner_semantic_msgs/SemanticClass~%# Semantic classes~%int32 kNone = 0~%int32 kStaircase = 1~%int32 kDoor = 2~%~%# Can only choose one of the above~%int32 value~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SemanticPolygon>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'type))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'description))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'polygon))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SemanticPolygon>))
  "Converts a ROS message object to a list"
  (cl:list 'SemanticPolygon
    (cl:cons ':header (header msg))
    (cl:cons ':type (type msg))
    (cl:cons ':description (description msg))
    (cl:cons ':polygon (polygon msg))
))
