; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude pci_geofence-request.msg.html

(cl:defclass <pci_geofence-request> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (rectangles
    :reader rectangles
    :initarg :rectangles
    :type (cl:vector planner_msgs-msg:RectangleShape)
   :initform (cl:make-array 0 :element-type 'planner_msgs-msg:RectangleShape :initial-element (cl:make-instance 'planner_msgs-msg:RectangleShape))))
)

(cl:defclass pci_geofence-request (<pci_geofence-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_geofence-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_geofence-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_geofence-request> is deprecated: use planner_msgs-srv:pci_geofence-request instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <pci_geofence-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:header-val is deprecated.  Use planner_msgs-srv:header instead.")
  (header m))

(cl:ensure-generic-function 'rectangles-val :lambda-list '(m))
(cl:defmethod rectangles-val ((m <pci_geofence-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:rectangles-val is deprecated.  Use planner_msgs-srv:rectangles instead.")
  (rectangles m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_geofence-request>) ostream)
  "Serializes a message object of type '<pci_geofence-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'rectangles))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'rectangles))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_geofence-request>) istream)
  "Deserializes a message object of type '<pci_geofence-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'rectangles) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'rectangles)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'planner_msgs-msg:RectangleShape))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_geofence-request>)))
  "Returns string type for a service object of type '<pci_geofence-request>"
  "planner_msgs/pci_geofenceRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_geofence-request)))
  "Returns string type for a service object of type 'pci_geofence-request"
  "planner_msgs/pci_geofenceRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_geofence-request>)))
  "Returns md5sum for a message object of type '<pci_geofence-request>"
  "dc6345ad327f5b0036d6747623b84599")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_geofence-request)))
  "Returns md5sum for a message object of type 'pci_geofence-request"
  "dc6345ad327f5b0036d6747623b84599")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_geofence-request>)))
  "Returns full string definition for message of type '<pci_geofence-request>"
  (cl:format cl:nil "# Add a rectangle to the geofence list.~%Header header~%~%planner_msgs/RectangleShape[] rectangles~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: planner_msgs/RectangleShape~%geometry_msgs/Vector3 center~%geometry_msgs/Vector3 size~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_geofence-request)))
  "Returns full string definition for message of type 'pci_geofence-request"
  (cl:format cl:nil "# Add a rectangle to the geofence list.~%Header header~%~%planner_msgs/RectangleShape[] rectangles~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: planner_msgs/RectangleShape~%geometry_msgs/Vector3 center~%geometry_msgs/Vector3 size~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_geofence-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'rectangles) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_geofence-request>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_geofence-request
    (cl:cons ':header (header msg))
    (cl:cons ':rectangles (rectangles msg))
))
;//! \htmlinclude pci_geofence-response.msg.html

(cl:defclass <pci_geofence-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass pci_geofence-response (<pci_geofence-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pci_geofence-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pci_geofence-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<pci_geofence-response> is deprecated: use planner_msgs-srv:pci_geofence-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <pci_geofence-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pci_geofence-response>) ostream)
  "Serializes a message object of type '<pci_geofence-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pci_geofence-response>) istream)
  "Deserializes a message object of type '<pci_geofence-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pci_geofence-response>)))
  "Returns string type for a service object of type '<pci_geofence-response>"
  "planner_msgs/pci_geofenceResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_geofence-response)))
  "Returns string type for a service object of type 'pci_geofence-response"
  "planner_msgs/pci_geofenceResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pci_geofence-response>)))
  "Returns md5sum for a message object of type '<pci_geofence-response>"
  "dc6345ad327f5b0036d6747623b84599")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pci_geofence-response)))
  "Returns md5sum for a message object of type 'pci_geofence-response"
  "dc6345ad327f5b0036d6747623b84599")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pci_geofence-response>)))
  "Returns full string definition for message of type '<pci_geofence-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pci_geofence-response)))
  "Returns full string definition for message of type 'pci_geofence-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pci_geofence-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pci_geofence-response>))
  "Converts a ROS message object to a list"
  (cl:list 'pci_geofence-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'pci_geofence)))
  'pci_geofence-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'pci_geofence)))
  'pci_geofence-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pci_geofence)))
  "Returns string type for a service object of type '<pci_geofence>"
  "planner_msgs/pci_geofence")