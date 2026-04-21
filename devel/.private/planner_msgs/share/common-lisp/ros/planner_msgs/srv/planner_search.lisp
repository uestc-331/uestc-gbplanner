; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude planner_search-request.msg.html

(cl:defclass <planner_search-request> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (use_current_state
    :reader use_current_state
    :initarg :use_current_state
    :type cl:boolean
    :initform cl:nil)
   (source
    :reader source
    :initarg :source
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (target
    :reader target
    :initarg :target
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (bound_mode
    :reader bound_mode
    :initarg :bound_mode
    :type cl:integer
    :initform 0))
)

(cl:defclass planner_search-request (<planner_search-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_search-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_search-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_search-request> is deprecated: use planner_msgs-srv:planner_search-request instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <planner_search-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:header-val is deprecated.  Use planner_msgs-srv:header instead.")
  (header m))

(cl:ensure-generic-function 'use_current_state-val :lambda-list '(m))
(cl:defmethod use_current_state-val ((m <planner_search-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:use_current_state-val is deprecated.  Use planner_msgs-srv:use_current_state instead.")
  (use_current_state m))

(cl:ensure-generic-function 'source-val :lambda-list '(m))
(cl:defmethod source-val ((m <planner_search-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:source-val is deprecated.  Use planner_msgs-srv:source instead.")
  (source m))

(cl:ensure-generic-function 'target-val :lambda-list '(m))
(cl:defmethod target-val ((m <planner_search-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:target-val is deprecated.  Use planner_msgs-srv:target instead.")
  (target m))

(cl:ensure-generic-function 'bound_mode-val :lambda-list '(m))
(cl:defmethod bound_mode-val ((m <planner_search-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:bound_mode-val is deprecated.  Use planner_msgs-srv:bound_mode instead.")
  (bound_mode m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<planner_search-request>)))
    "Constants for message type '<planner_search-request>"
  '((:KEXTENDEDBOUND . 0)
    (:KRELAXEDBOUND . 1)
    (:KMINBOUND . 2)
    (:KEXACTBOUND . 3)
    (:KNOBOUND . 4))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'planner_search-request)))
    "Constants for message type 'planner_search-request"
  '((:KEXTENDEDBOUND . 0)
    (:KRELAXEDBOUND . 1)
    (:KMINBOUND . 2)
    (:KEXACTBOUND . 3)
    (:KNOBOUND . 4))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_search-request>) ostream)
  "Serializes a message object of type '<planner_search-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'use_current_state) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'source) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'target) ostream)
  (cl:let* ((signed (cl:slot-value msg 'bound_mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_search-request>) istream)
  "Deserializes a message object of type '<planner_search-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'use_current_state) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'source) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'target) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'bound_mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_search-request>)))
  "Returns string type for a service object of type '<planner_search-request>"
  "planner_msgs/planner_searchRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_search-request)))
  "Returns string type for a service object of type 'planner_search-request"
  "planner_msgs/planner_searchRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_search-request>)))
  "Returns md5sum for a message object of type '<planner_search-request>"
  "e06e5834c0c713453a57f0396fd6674a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_search-request)))
  "Returns md5sum for a message object of type 'planner_search-request"
  "e06e5834c0c713453a57f0396fd6674a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_search-request>)))
  "Returns full string definition for message of type '<planner_search-request>"
  (cl:format cl:nil "# Request the planner to search for a path to connect two arbitrary poses.~%Header header~%# Set True if want to set source pose at current robot's state.~%bool use_current_state~%# Source pose will be ignored if use_current_state is True~%geometry_msgs/Pose source~%# Target pose~%geometry_msgs/Pose target~%~%# Set the bound mode of the robot to use in planner.~%# Use extension to actual size. (default)~%int32 kExtendedBound = 0~%int32 kRelaxedBound = 1~%int32 kMinBound = 2~%int32 kExactBound = 3~%int32 kNoBound = 4~%# Can only be used with one of above values. Check Params/BoundModeType for more details.~%int32 bound_mode~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_search-request)))
  "Returns full string definition for message of type 'planner_search-request"
  (cl:format cl:nil "# Request the planner to search for a path to connect two arbitrary poses.~%Header header~%# Set True if want to set source pose at current robot's state.~%bool use_current_state~%# Source pose will be ignored if use_current_state is True~%geometry_msgs/Pose source~%# Target pose~%geometry_msgs/Pose target~%~%# Set the bound mode of the robot to use in planner.~%# Use extension to actual size. (default)~%int32 kExtendedBound = 0~%int32 kRelaxedBound = 1~%int32 kMinBound = 2~%int32 kExactBound = 3~%int32 kNoBound = 4~%# Can only be used with one of above values. Check Params/BoundModeType for more details.~%int32 bound_mode~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_search-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'source))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'target))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_search-request>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_search-request
    (cl:cons ':header (header msg))
    (cl:cons ':use_current_state (use_current_state msg))
    (cl:cons ':source (source msg))
    (cl:cons ':target (target msg))
    (cl:cons ':bound_mode (bound_mode msg))
))
;//! \htmlinclude planner_search-response.msg.html

(cl:defclass <planner_search-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (path
    :reader path
    :initarg :path
    :type (cl:vector geometry_msgs-msg:Pose)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Pose :initial-element (cl:make-instance 'geometry_msgs-msg:Pose))))
)

(cl:defclass planner_search-response (<planner_search-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_search-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_search-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_search-response> is deprecated: use planner_msgs-srv:planner_search-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <planner_search-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:success-val is deprecated.  Use planner_msgs-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <planner_search-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:path-val is deprecated.  Use planner_msgs-srv:path instead.")
  (path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_search-response>) ostream)
  "Serializes a message object of type '<planner_search-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'path))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_search-response>) istream)
  "Deserializes a message object of type '<planner_search-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_search-response>)))
  "Returns string type for a service object of type '<planner_search-response>"
  "planner_msgs/planner_searchResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_search-response)))
  "Returns string type for a service object of type 'planner_search-response"
  "planner_msgs/planner_searchResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_search-response>)))
  "Returns md5sum for a message object of type '<planner_search-response>"
  "e06e5834c0c713453a57f0396fd6674a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_search-response)))
  "Returns md5sum for a message object of type 'planner_search-response"
  "e06e5834c0c713453a57f0396fd6674a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_search-response>)))
  "Returns full string definition for message of type '<planner_search-response>"
  (cl:format cl:nil "bool success~%# Return best path.~%geometry_msgs/Pose[] path~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_search-response)))
  "Returns full string definition for message of type 'planner_search-response"
  (cl:format cl:nil "bool success~%# Return best path.~%geometry_msgs/Pose[] path~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_search-response>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'path) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_search-response>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_search-response
    (cl:cons ':success (success msg))
    (cl:cons ':path (path msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'planner_search)))
  'planner_search-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'planner_search)))
  'planner_search-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_search)))
  "Returns string type for a service object of type '<planner_search>"
  "planner_msgs/planner_search")