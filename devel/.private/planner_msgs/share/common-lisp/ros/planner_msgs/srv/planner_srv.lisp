; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude planner_srv-request.msg.html

(cl:defclass <planner_srv-request> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (bound_mode
    :reader bound_mode
    :initarg :bound_mode
    :type cl:integer
    :initform 0)
   (root_pose
    :reader root_pose
    :initarg :root_pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose)))
)

(cl:defclass planner_srv-request (<planner_srv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_srv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_srv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_srv-request> is deprecated: use planner_msgs-srv:planner_srv-request instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <planner_srv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:header-val is deprecated.  Use planner_msgs-srv:header instead.")
  (header m))

(cl:ensure-generic-function 'bound_mode-val :lambda-list '(m))
(cl:defmethod bound_mode-val ((m <planner_srv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:bound_mode-val is deprecated.  Use planner_msgs-srv:bound_mode instead.")
  (bound_mode m))

(cl:ensure-generic-function 'root_pose-val :lambda-list '(m))
(cl:defmethod root_pose-val ((m <planner_srv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:root_pose-val is deprecated.  Use planner_msgs-srv:root_pose instead.")
  (root_pose m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<planner_srv-request>)))
    "Constants for message type '<planner_srv-request>"
  '((:KEXTENDEDBOUND . 0)
    (:KRELAXEDBOUND . 1)
    (:KMINBOUND . 2)
    (:KEXACTBOUND . 3)
    (:KNOBOUND . 4))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'planner_srv-request)))
    "Constants for message type 'planner_srv-request"
  '((:KEXTENDEDBOUND . 0)
    (:KRELAXEDBOUND . 1)
    (:KMINBOUND . 2)
    (:KEXACTBOUND . 3)
    (:KNOBOUND . 4))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_srv-request>) ostream)
  "Serializes a message object of type '<planner_srv-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'bound_mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'root_pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_srv-request>) istream)
  "Deserializes a message object of type '<planner_srv-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'bound_mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'root_pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_srv-request>)))
  "Returns string type for a service object of type '<planner_srv-request>"
  "planner_msgs/planner_srvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_srv-request)))
  "Returns string type for a service object of type 'planner_srv-request"
  "planner_msgs/planner_srvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_srv-request>)))
  "Returns md5sum for a message object of type '<planner_srv-request>"
  "a3f85517a01be073ddd96543af02aefb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_srv-request)))
  "Returns md5sum for a message object of type 'planner_srv-request"
  "a3f85517a01be073ddd96543af02aefb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_srv-request>)))
  "Returns full string definition for message of type '<planner_srv-request>"
  (cl:format cl:nil "# Request the planner to run and return a path~%Header header~%~%# Set the bound mode of the robot to use in planner.~%# Use extension to actual size. (default)~%int32 kExtendedBound = 0~%int32 kRelaxedBound = 1~%int32 kMinBound = 2~%int32 kExactBound = 3~%int32 kNoBound = 4~%# Can only be used with one of above values. Check Params/BoundModeType for more details.~%int32 bound_mode~%~%# Set root pose if requires the planner starts planning from this root.~%# Otherwise, set all to zero, planner will start at robot's current state.~%geometry_msgs/Pose root_pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_srv-request)))
  "Returns full string definition for message of type 'planner_srv-request"
  (cl:format cl:nil "# Request the planner to run and return a path~%Header header~%~%# Set the bound mode of the robot to use in planner.~%# Use extension to actual size. (default)~%int32 kExtendedBound = 0~%int32 kRelaxedBound = 1~%int32 kMinBound = 2~%int32 kExactBound = 3~%int32 kNoBound = 4~%# Can only be used with one of above values. Check Params/BoundModeType for more details.~%int32 bound_mode~%~%# Set root pose if requires the planner starts planning from this root.~%# Otherwise, set all to zero, planner will start at robot's current state.~%geometry_msgs/Pose root_pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_srv-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'root_pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_srv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_srv-request
    (cl:cons ':header (header msg))
    (cl:cons ':bound_mode (bound_mode msg))
    (cl:cons ':root_pose (root_pose msg))
))
;//! \htmlinclude planner_srv-response.msg.html

(cl:defclass <planner_srv-response> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:integer
    :initform 0)
   (planning_bound_mode
    :reader planning_bound_mode
    :initarg :planning_bound_mode
    :type cl:integer
    :initform 0)
   (path
    :reader path
    :initarg :path
    :type (cl:vector geometry_msgs-msg:Pose)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Pose :initial-element (cl:make-instance 'geometry_msgs-msg:Pose))))
)

(cl:defclass planner_srv-response (<planner_srv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_srv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_srv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_srv-response> is deprecated: use planner_msgs-srv:planner_srv-response instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <planner_srv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:status-val is deprecated.  Use planner_msgs-srv:status instead.")
  (status m))

(cl:ensure-generic-function 'planning_bound_mode-val :lambda-list '(m))
(cl:defmethod planning_bound_mode-val ((m <planner_srv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:planning_bound_mode-val is deprecated.  Use planner_msgs-srv:planning_bound_mode instead.")
  (planning_bound_mode m))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <planner_srv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:path-val is deprecated.  Use planner_msgs-srv:path instead.")
  (path m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<planner_srv-response>)))
    "Constants for message type '<planner_srv-response>"
  '((:KFORWARD . 0)
    (:KBACKWARD . 1)
    (:KHOMING . 2)
    (:KREPOSITIONING . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'planner_srv-response)))
    "Constants for message type 'planner_srv-response"
  '((:KFORWARD . 0)
    (:KBACKWARD . 1)
    (:KHOMING . 2)
    (:KREPOSITIONING . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_srv-response>) ostream)
  "Serializes a message object of type '<planner_srv-response>"
  (cl:let* ((signed (cl:slot-value msg 'status)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'planning_bound_mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'path))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_srv-response>) istream)
  "Deserializes a message object of type '<planner_srv-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'planning_bound_mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_srv-response>)))
  "Returns string type for a service object of type '<planner_srv-response>"
  "planner_msgs/planner_srvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_srv-response)))
  "Returns string type for a service object of type 'planner_srv-response"
  "planner_msgs/planner_srvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_srv-response>)))
  "Returns md5sum for a message object of type '<planner_srv-response>"
  "a3f85517a01be073ddd96543af02aefb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_srv-response)))
  "Returns md5sum for a message object of type 'planner_srv-response"
  "a3f85517a01be073ddd96543af02aefb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_srv-response>)))
  "Returns full string definition for message of type '<planner_srv-response>"
  (cl:format cl:nil "int32 kForward = 0~%int32 kBackward = 1~%int32 kHoming = 2~%int32 kRepositioning = 3~%# Status of the best path, take one of the above values.~%int32 status~%~%# Return actual bound mode used for planning~%int32 planning_bound_mode~%~%# Return best path.~%geometry_msgs/Pose[] path~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_srv-response)))
  "Returns full string definition for message of type 'planner_srv-response"
  (cl:format cl:nil "int32 kForward = 0~%int32 kBackward = 1~%int32 kHoming = 2~%int32 kRepositioning = 3~%# Status of the best path, take one of the above values.~%int32 status~%~%# Return actual bound mode used for planning~%int32 planning_bound_mode~%~%# Return best path.~%geometry_msgs/Pose[] path~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_srv-response>))
  (cl:+ 0
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'path) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_srv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_srv-response
    (cl:cons ':status (status msg))
    (cl:cons ':planning_bound_mode (planning_bound_mode msg))
    (cl:cons ':path (path msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'planner_srv)))
  'planner_srv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'planner_srv)))
  'planner_srv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_srv)))
  "Returns string type for a service object of type '<planner_srv>"
  "planner_msgs/planner_srv")