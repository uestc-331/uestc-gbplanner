; Auto-generated. Do not edit!


(cl:in-package planner_msgs-srv)


;//! \htmlinclude planner_global-request.msg.html

(cl:defclass <planner_global-request> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (not_check_frontier
    :reader not_check_frontier
    :initarg :not_check_frontier
    :type cl:boolean
    :initform cl:nil)
   (ignore_time
    :reader ignore_time
    :initarg :ignore_time
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass planner_global-request (<planner_global-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_global-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_global-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_global-request> is deprecated: use planner_msgs-srv:planner_global-request instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <planner_global-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:id-val is deprecated.  Use planner_msgs-srv:id instead.")
  (id m))

(cl:ensure-generic-function 'not_check_frontier-val :lambda-list '(m))
(cl:defmethod not_check_frontier-val ((m <planner_global-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:not_check_frontier-val is deprecated.  Use planner_msgs-srv:not_check_frontier instead.")
  (not_check_frontier m))

(cl:ensure-generic-function 'ignore_time-val :lambda-list '(m))
(cl:defmethod ignore_time-val ((m <planner_global-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:ignore_time-val is deprecated.  Use planner_msgs-srv:ignore_time instead.")
  (ignore_time m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_global-request>) ostream)
  "Serializes a message object of type '<planner_global-request>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'not_check_frontier) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ignore_time) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_global-request>) istream)
  "Deserializes a message object of type '<planner_global-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'not_check_frontier) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'ignore_time) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_global-request>)))
  "Returns string type for a service object of type '<planner_global-request>"
  "planner_msgs/planner_globalRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_global-request)))
  "Returns string type for a service object of type 'planner_global-request"
  "planner_msgs/planner_globalRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_global-request>)))
  "Returns md5sum for a message object of type '<planner_global-request>"
  "3275d6e0291e4113fe8f0b4224d6de5a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_global-request)))
  "Returns md5sum for a message object of type 'planner_global-request"
  "3275d6e0291e4113fe8f0b4224d6de5a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_global-request>)))
  "Returns full string definition for message of type '<planner_global-request>"
  (cl:format cl:nil "# Request the planner to run and return a path~%# Since the global planner solution is almost deterministic,~%# we could choose which frontier (using its id) from the best one to execute.~%# By default, id 0 means selecting the best one.~%int32 id~%# Don't check for frontier properties (e.g. leaf vertex, gain, ...)~%# This could be used to find a path to any vertex in the graph~%bool not_check_frontier~%# Force the planner to provide the path regardless the time budget.~%bool ignore_time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_global-request)))
  "Returns full string definition for message of type 'planner_global-request"
  (cl:format cl:nil "# Request the planner to run and return a path~%# Since the global planner solution is almost deterministic,~%# we could choose which frontier (using its id) from the best one to execute.~%# By default, id 0 means selecting the best one.~%int32 id~%# Don't check for frontier properties (e.g. leaf vertex, gain, ...)~%# This could be used to find a path to any vertex in the graph~%bool not_check_frontier~%# Force the planner to provide the path regardless the time budget.~%bool ignore_time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_global-request>))
  (cl:+ 0
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_global-request>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_global-request
    (cl:cons ':id (id msg))
    (cl:cons ':not_check_frontier (not_check_frontier msg))
    (cl:cons ':ignore_time (ignore_time msg))
))
;//! \htmlinclude planner_global-response.msg.html

(cl:defclass <planner_global-response> (roslisp-msg-protocol:ros-message)
  ((path
    :reader path
    :initarg :path
    :type (cl:vector geometry_msgs-msg:Pose)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Pose :initial-element (cl:make-instance 'geometry_msgs-msg:Pose))))
)

(cl:defclass planner_global-response (<planner_global-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <planner_global-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'planner_global-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-srv:<planner_global-response> is deprecated: use planner_msgs-srv:planner_global-response instead.")))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <planner_global-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-srv:path-val is deprecated.  Use planner_msgs-srv:path instead.")
  (path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <planner_global-response>) ostream)
  "Serializes a message object of type '<planner_global-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'path))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <planner_global-response>) istream)
  "Deserializes a message object of type '<planner_global-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<planner_global-response>)))
  "Returns string type for a service object of type '<planner_global-response>"
  "planner_msgs/planner_globalResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_global-response)))
  "Returns string type for a service object of type 'planner_global-response"
  "planner_msgs/planner_globalResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<planner_global-response>)))
  "Returns md5sum for a message object of type '<planner_global-response>"
  "3275d6e0291e4113fe8f0b4224d6de5a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'planner_global-response)))
  "Returns md5sum for a message object of type 'planner_global-response"
  "3275d6e0291e4113fe8f0b4224d6de5a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<planner_global-response>)))
  "Returns full string definition for message of type '<planner_global-response>"
  (cl:format cl:nil "# Return best path.~%geometry_msgs/Pose[] path~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'planner_global-response)))
  "Returns full string definition for message of type 'planner_global-response"
  (cl:format cl:nil "# Return best path.~%geometry_msgs/Pose[] path~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <planner_global-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'path) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <planner_global-response>))
  "Converts a ROS message object to a list"
  (cl:list 'planner_global-response
    (cl:cons ':path (path msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'planner_global)))
  'planner_global-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'planner_global)))
  'planner_global-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'planner_global)))
  "Returns string type for a service object of type '<planner_global>"
  "planner_msgs/planner_global")