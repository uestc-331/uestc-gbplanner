; Auto-generated. Do not edit!


(cl:in-package planner_msgs-msg)


;//! \htmlinclude Vertex.msg.html

(cl:defclass <Vertex> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (num_unknown_voxels
    :reader num_unknown_voxels
    :initarg :num_unknown_voxels
    :type cl:integer
    :initform 0)
   (num_occupied_voxels
    :reader num_occupied_voxels
    :initarg :num_occupied_voxels
    :type cl:integer
    :initform 0)
   (num_free_voxels
    :reader num_free_voxels
    :initarg :num_free_voxels
    :type cl:integer
    :initform 0)
   (is_frontier
    :reader is_frontier
    :initarg :is_frontier
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Vertex (<Vertex>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Vertex>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Vertex)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-msg:<Vertex> is deprecated: use planner_msgs-msg:Vertex instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Vertex>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:id-val is deprecated.  Use planner_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <Vertex>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:pose-val is deprecated.  Use planner_msgs-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'num_unknown_voxels-val :lambda-list '(m))
(cl:defmethod num_unknown_voxels-val ((m <Vertex>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:num_unknown_voxels-val is deprecated.  Use planner_msgs-msg:num_unknown_voxels instead.")
  (num_unknown_voxels m))

(cl:ensure-generic-function 'num_occupied_voxels-val :lambda-list '(m))
(cl:defmethod num_occupied_voxels-val ((m <Vertex>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:num_occupied_voxels-val is deprecated.  Use planner_msgs-msg:num_occupied_voxels instead.")
  (num_occupied_voxels m))

(cl:ensure-generic-function 'num_free_voxels-val :lambda-list '(m))
(cl:defmethod num_free_voxels-val ((m <Vertex>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:num_free_voxels-val is deprecated.  Use planner_msgs-msg:num_free_voxels instead.")
  (num_free_voxels m))

(cl:ensure-generic-function 'is_frontier-val :lambda-list '(m))
(cl:defmethod is_frontier-val ((m <Vertex>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:is_frontier-val is deprecated.  Use planner_msgs-msg:is_frontier instead.")
  (is_frontier m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Vertex>) ostream)
  "Serializes a message object of type '<Vertex>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (cl:let* ((signed (cl:slot-value msg 'num_unknown_voxels)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'num_occupied_voxels)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'num_free_voxels)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_frontier) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Vertex>) istream)
  "Deserializes a message object of type '<Vertex>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'num_unknown_voxels) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'num_occupied_voxels) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'num_free_voxels) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'is_frontier) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Vertex>)))
  "Returns string type for a message object of type '<Vertex>"
  "planner_msgs/Vertex")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Vertex)))
  "Returns string type for a message object of type 'Vertex"
  "planner_msgs/Vertex")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Vertex>)))
  "Returns md5sum for a message object of type '<Vertex>"
  "663034a815fe27eaa71d6d6b0f8b9b78")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Vertex)))
  "Returns md5sum for a message object of type 'Vertex"
  "663034a815fe27eaa71d6d6b0f8b9b78")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Vertex>)))
  "Returns full string definition for message of type '<Vertex>"
  (cl:format cl:nil "int32 id~%geometry_msgs/Pose pose~%~%# For volumetric gain~%int32 num_unknown_voxels~%int32 num_occupied_voxels~%int32 num_free_voxels~%bool is_frontier~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Vertex)))
  "Returns full string definition for message of type 'Vertex"
  (cl:format cl:nil "int32 id~%geometry_msgs/Pose pose~%~%# For volumetric gain~%int32 num_unknown_voxels~%int32 num_occupied_voxels~%int32 num_free_voxels~%bool is_frontier~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Vertex>))
  (cl:+ 0
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     4
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Vertex>))
  "Converts a ROS message object to a list"
  (cl:list 'Vertex
    (cl:cons ':id (id msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':num_unknown_voxels (num_unknown_voxels msg))
    (cl:cons ':num_occupied_voxels (num_occupied_voxels msg))
    (cl:cons ':num_free_voxels (num_free_voxels msg))
    (cl:cons ':is_frontier (is_frontier msg))
))
