; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude planner_request_path-request.msg.html

(cl:defclass <planner_request_path-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass planner_request_path-request (<planner_request_path-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_request_path-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_request_path-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_request_path-request> is deprecated: use planner_msgs-srv:planner_request_path-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_request_path-request>) ostream)
  "Serializes a message object of type '<planner_request_path-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_request_path-request>) istream)
  "Deserializes a message object of type '<planner_request_path-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_request_path-request>)))
  "Returns string type for a service object of type '<planner_request_path-request>"
  "planner_msgs/planner_request_pathRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_request_path-request)))
  "Returns string type for a service object of type 'planner_request_path-request"
  "planner_msgs/planner_request_pathRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_request_path-request>)))
  "Returns md5sum for a message object of type '<planner_request_path-request>"
  "1dad867088c8c204d2077d3355d04150")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_request_path-request)))
  "Returns md5sum for a message object of type 'planner_request_path-request"
  "1dad867088c8c204d2077d3355d04150")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_request_path-request>)))
  "Returns full string definition for message of type '<planner_request_path-request>"
  (cl:format cl:nil "# A generic service to request a path from gbplanner~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_request_path-request)))
  "Returns full string definition for message of type 'planner_request_path-request"
  (cl:format cl:nil "# A generic service to request a path from gbplanner~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_request_path-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_request_path-request>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_request_path-request
))
;//! \htmlinclude planner_request_path-response.msg.html

(cl:defclass <planner_request_path-response> (roslisp-msg-protocol:ros-message)
  ((bound
    :reader bound
    :initarg :bound
    :type planner_msgs-msg:BoundMode
    :initform (cl:make-instance 'planner_msgs-msg:BoundMode))
   (path
    :reader path
    :initarg :path
    :type (cl:vector geometry_msgs-msg:Pose)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Pose :initial-element (cl:make-instance 'geometry_msgs-msg:Pose))))
)

(cl:defclass planner_request_path-response (<planner_request_path-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_request_path-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_request_path-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_request_path-response> is deprecated: use planner_msgs-srv:planner_request_path-response instead.")))

(cl:ensure-generic-function 'bound-val :lambda-list '(m))
(cl:defmethod bound-val ((m <planner_request_path-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:bound-val is deprecated.  Use planner_msgs-srv:bound instead.")
  (bound m))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <planner_request_path-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:path-val is deprecated.  Use planner_msgs-srv:path instead.")
  (path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_request_path-response>) ostream)
  "Serializes a message object of type '<planner_request_path-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'bound) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'path))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_request_path-response>) istream)
  "Deserializes a message object of type '<planner_request_path-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'bound) istream)
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_request_path-response>)))
  "Returns string type for a service object of type '<planner_request_path-response>"
  "planner_msgs/planner_request_pathResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_request_path-response)))
  "Returns string type for a service object of type 'planner_request_path-response"
  "planner_msgs/planner_request_pathResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_request_path-response>)))
  "Returns md5sum for a message object of type '<planner_request_path-response>"
  "1dad867088c8c204d2077d3355d04150")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_request_path-response)))
  "Returns md5sum for a message object of type 'planner_request_path-response"
  "1dad867088c8c204d2077d3355d04150")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_request_path-response>)))
  "Returns full string definition for message of type '<planner_request_path-response>"
  (cl:format cl:nil "# Return actual bound mode used in planner.~%BoundMode bound~%~%# Return path.~%geometry_msgs/Pose[] path~%~%================================================================================~%MSG: planner_msgs/BoundMode~%# Bound mode of the robot for collision checking, defined in Params/BoundModeType.~%int32 kExtendedBound = 0~%int32 kRelaxedBound = 1~%int32 kMinBound = 2~%int32 kExactBound = 3~%int32 kNoBound = 4~%~%# Set one of above values.~%int32 mode~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_request_path-response)))
  "Returns full string definition for message of type 'planner_request_path-response"
  (cl:format cl:nil "# Return actual bound mode used in planner.~%BoundMode bound~%~%# Return path.~%geometry_msgs/Pose[] path~%~%================================================================================~%MSG: planner_msgs/BoundMode~%# Bound mode of the robot for collision checking, defined in Params/BoundModeType.~%int32 kExtendedBound = 0~%int32 kRelaxedBound = 1~%int32 kMinBound = 2~%int32 kExactBound = 3~%int32 kNoBound = 4~%~%# Set one of above values.~%int32 mode~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_request_path-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'bound))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'path) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_request_path-response>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_request_path-response
    (cl:cons ':bound (bound msg))
    (cl:cons ':path (path msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'planner_request_path)))
  'planner_request_path-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'planner_request_path)))
  'planner_request_path-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_request_path)))
  "Returns string type for a service object of type '<planner_request_path>"
  "planner_msgs/planner_request_path")