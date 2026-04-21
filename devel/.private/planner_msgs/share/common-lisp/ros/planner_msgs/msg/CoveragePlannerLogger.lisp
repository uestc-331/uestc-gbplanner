; Auto-generated. Do not edit!


(cl:in-package planner_msgs-msg)


;//! \htmlinclude CoveragePlannerLogger.msg.html

(cl:defclass <CoveragePlannerLogger> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (graph_build_time
    :reader graph_build_time
    :initarg :graph_build_time
    :type cl:float
    :initform 0.0)
   (total_time
    :reader total_time
    :initarg :total_time
    :type cl:float
    :initform 0.0)
   (path_length
    :reader path_length
    :initarg :path_length
    :type cl:float
    :initform 0.0)
   (tsp_path_time
    :reader tsp_path_time
    :initarg :tsp_path_time
    :type cl:float
    :initform 0.0))
)

(cl:defclass CoveragePlannerLogger (<CoveragePlannerLogger>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CoveragePlannerLogger>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CoveragePlannerLogger)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-msg:<CoveragePlannerLogger> is deprecated: use planner_msgs-msg:CoveragePlannerLogger instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <CoveragePlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:header-val is deprecated.  Use planner_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'graph_build_time-val :lambda-list '(m))
(cl:defmethod graph_build_time-val ((m <CoveragePlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:graph_build_time-val is deprecated.  Use planner_msgs-msg:graph_build_time instead.")
  (graph_build_time m))

(cl:ensure-generic-function 'total_time-val :lambda-list '(m))
(cl:defmethod total_time-val ((m <CoveragePlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:total_time-val is deprecated.  Use planner_msgs-msg:total_time instead.")
  (total_time m))

(cl:ensure-generic-function 'path_length-val :lambda-list '(m))
(cl:defmethod path_length-val ((m <CoveragePlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:path_length-val is deprecated.  Use planner_msgs-msg:path_length instead.")
  (path_length m))

(cl:ensure-generic-function 'tsp_path_time-val :lambda-list '(m))
(cl:defmethod tsp_path_time-val ((m <CoveragePlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:tsp_path_time-val is deprecated.  Use planner_msgs-msg:tsp_path_time instead.")
  (tsp_path_time m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CoveragePlannerLogger>) ostream)
  "Serializes a message object of type '<CoveragePlannerLogger>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'graph_build_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'total_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'path_length))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tsp_path_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CoveragePlannerLogger>) istream)
  "Deserializes a message object of type '<CoveragePlannerLogger>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'graph_build_time) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'total_time) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'path_length) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tsp_path_time) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CoveragePlannerLogger>)))
  "Returns string type for a message object of type '<CoveragePlannerLogger>"
  "planner_msgs/CoveragePlannerLogger")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CoveragePlannerLogger)))
  "Returns string type for a message object of type 'CoveragePlannerLogger"
  "planner_msgs/CoveragePlannerLogger")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CoveragePlannerLogger>)))
  "Returns md5sum for a message object of type '<CoveragePlannerLogger>"
  "4af5c001f0e3078a457323f300d3ce22")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CoveragePlannerLogger)))
  "Returns md5sum for a message object of type 'CoveragePlannerLogger"
  "4af5c001f0e3078a457323f300d3ce22")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CoveragePlannerLogger>)))
  "Returns full string definition for message of type '<CoveragePlannerLogger>"
  (cl:format cl:nil "Header header~%~%float32 graph_build_time~%float32 total_time~%float32 path_length~%float32 tsp_path_time~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CoveragePlannerLogger)))
  "Returns full string definition for message of type 'CoveragePlannerLogger"
  (cl:format cl:nil "Header header~%~%float32 graph_build_time~%float32 total_time~%float32 path_length~%float32 tsp_path_time~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CoveragePlannerLogger>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CoveragePlannerLogger>))
  "Converts a ROS message object to a list"
  (cl:list 'CoveragePlannerLogger
    (cl:cons ':header (header msg))
    (cl:cons ':graph_build_time (graph_build_time msg))
    (cl:cons ':total_time (total_time msg))
    (cl:cons ':path_length (path_length msg))
    (cl:cons ':tsp_path_time (tsp_path_time msg))
))
