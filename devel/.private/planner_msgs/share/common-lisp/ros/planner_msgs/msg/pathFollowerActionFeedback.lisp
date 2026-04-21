; Auto-generated. Do not edit!


(cl:in-package planner_msgs-msg)


;//! \htmlinclude pathFollowerActionFeedback.msg.html

(cl:defclass <pathFollowerActionFeedback> (roslisp-msg-protocol:ros-message)
  ((remaining_waypoints
    :reader remaining_waypoints
    :initarg :remaining_waypoints
    :type cl:integer
    :initform 0)
   (dist_to_goal
    :reader dist_to_goal
    :initarg :dist_to_goal
    :type cl:float
    :initform 0.0)
   (estimated_time_remaining
    :reader estimated_time_remaining
    :initarg :estimated_time_remaining
    :type cl:float
    :initform 0.0))
)

(cl:defclass pathFollowerActionFeedback (<pathFollowerActionFeedback>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pathFollowerActionFeedback>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pathFollowerActionFeedback)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-msg:<pathFollowerActionFeedback> is deprecated: use planner_msgs-msg:pathFollowerActionFeedback instead.")))

(cl:ensure-generic-function 'remaining_waypoints-val :lambda-list '(m))
(cl:defmethod remaining_waypoints-val ((m <pathFollowerActionFeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:remaining_waypoints-val is deprecated.  Use planner_msgs-msg:remaining_waypoints instead.")
  (remaining_waypoints m))

(cl:ensure-generic-function 'dist_to_goal-val :lambda-list '(m))
(cl:defmethod dist_to_goal-val ((m <pathFollowerActionFeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:dist_to_goal-val is deprecated.  Use planner_msgs-msg:dist_to_goal instead.")
  (dist_to_goal m))

(cl:ensure-generic-function 'estimated_time_remaining-val :lambda-list '(m))
(cl:defmethod estimated_time_remaining-val ((m <pathFollowerActionFeedback>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:estimated_time_remaining-val is deprecated.  Use planner_msgs-msg:estimated_time_remaining instead.")
  (estimated_time_remaining m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pathFollowerActionFeedback>) ostream)
  "Serializes a message object of type '<pathFollowerActionFeedback>"
  (cl:let* ((signed (cl:slot-value msg 'remaining_waypoints)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dist_to_goal))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'estimated_time_remaining))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pathFollowerActionFeedback>) istream)
  "Deserializes a message object of type '<pathFollowerActionFeedback>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'remaining_waypoints) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dist_to_goal) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'estimated_time_remaining) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pathFollowerActionFeedback>)))
  "Returns string type for a message object of type '<pathFollowerActionFeedback>"
  "planner_msgs/pathFollowerActionFeedback")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pathFollowerActionFeedback)))
  "Returns string type for a message object of type 'pathFollowerActionFeedback"
  "planner_msgs/pathFollowerActionFeedback")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pathFollowerActionFeedback>)))
  "Returns md5sum for a message object of type '<pathFollowerActionFeedback>"
  "33050b047bebb42f5c1e671aa1431b25")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pathFollowerActionFeedback)))
  "Returns md5sum for a message object of type 'pathFollowerActionFeedback"
  "33050b047bebb42f5c1e671aa1431b25")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pathFollowerActionFeedback>)))
  "Returns full string definition for message of type '<pathFollowerActionFeedback>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# feedback~%int32 remaining_waypoints~%float32 dist_to_goal~%float32 estimated_time_remaining~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pathFollowerActionFeedback)))
  "Returns full string definition for message of type 'pathFollowerActionFeedback"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# feedback~%int32 remaining_waypoints~%float32 dist_to_goal~%float32 estimated_time_remaining~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pathFollowerActionFeedback>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pathFollowerActionFeedback>))
  "Converts a ROS message object to a list"
  (cl:list 'pathFollowerActionFeedback
    (cl:cons ':remaining_waypoints (remaining_waypoints msg))
    (cl:cons ':dist_to_goal (dist_to_goal msg))
    (cl:cons ':estimated_time_remaining (estimated_time_remaining msg))
))
