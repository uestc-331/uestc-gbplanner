; Auto-generated. Do not edit!


(cl:in-package planner_msgs-msg)


;//! \htmlinclude PlanningBound.msg.html

(cl:defclass <PlanningBound> (roslisp-msg-protocol:ros-message)
  ((use_z_val
    :reader use_z_val
    :initarg :use_z_val
    :type cl:boolean
    :initform cl:nil)
   (min_val
    :reader min_val
    :initarg :min_val
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (max_val
    :reader max_val
    :initarg :max_val
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point)))
)

(cl:defclass PlanningBound (<PlanningBound>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PlanningBound>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PlanningBound)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-msg:<PlanningBound> is deprecated: use planner_msgs-msg:PlanningBound instead.")))

(cl:ensure-generic-function 'use_z_val-val :lambda-list '(m))
(cl:defmethod use_z_val-val ((m <PlanningBound>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:use_z_val-val is deprecated.  Use planner_msgs-msg:use_z_val instead.")
  (use_z_val m))

(cl:ensure-generic-function 'min_val-val :lambda-list '(m))
(cl:defmethod min_val-val ((m <PlanningBound>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:min_val-val is deprecated.  Use planner_msgs-msg:min_val instead.")
  (min_val m))

(cl:ensure-generic-function 'max_val-val :lambda-list '(m))
(cl:defmethod max_val-val ((m <PlanningBound>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:max_val-val is deprecated.  Use planner_msgs-msg:max_val instead.")
  (max_val m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PlanningBound>) ostream)
  "Serializes a message object of type '<PlanningBound>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'use_z_val) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'min_val) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'max_val) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PlanningBound>) istream)
  "Deserializes a message object of type '<PlanningBound>"
    (cl:setf (cl:slot-value msg 'use_z_val) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'min_val) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'max_val) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PlanningBound>)))
  "Returns string type for a message object of type '<PlanningBound>"
  "planner_msgs/PlanningBound")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PlanningBound)))
  "Returns string type for a message object of type 'PlanningBound"
  "planner_msgs/PlanningBound")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PlanningBound>)))
  "Returns md5sum for a message object of type '<PlanningBound>"
  "9946f675c617611331fb20682325fff7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PlanningBound)))
  "Returns md5sum for a message object of type 'PlanningBound"
  "9946f675c617611331fb20682325fff7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PlanningBound>)))
  "Returns full string definition for message of type '<PlanningBound>"
  (cl:format cl:nil "# use_z_val~%#    true:  all x, y, z coordinate~%#    false: change only x, y coodinates~%bool use_z_val~%~%# Bottom left corner~%geometry_msgs/Point min_val~%~%# Top right corner~%geometry_msgs/Point max_val~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PlanningBound)))
  "Returns full string definition for message of type 'PlanningBound"
  (cl:format cl:nil "# use_z_val~%#    true:  all x, y, z coordinate~%#    false: change only x, y coodinates~%bool use_z_val~%~%# Bottom left corner~%geometry_msgs/Point min_val~%~%# Top right corner~%geometry_msgs/Point max_val~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PlanningBound>))
  (cl:+ 0
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'min_val))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'max_val))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PlanningBound>))
  "Converts a ROS message object to a list"
  (cl:list 'PlanningBound
    (cl:cons ':use_z_val (use_z_val msg))
    (cl:cons ':min_val (min_val msg))
    (cl:cons ':max_val (max_val msg))
))
