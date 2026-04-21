; Auto-generated. Do not edit!


(cl:in-package planner_msgs-msg)


;//! \htmlinclude BehaviourPlannerLogger.msg.html

(cl:defclass <BehaviourPlannerLogger> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (total_time
    :reader total_time
    :initarg :total_time
    :type cl:float
    :initform 0.0)
   (planner
    :reader planner
    :initarg :planner
    :type cl:boolean
    :initform cl:nil)
   (current_seen_ratio
    :reader current_seen_ratio
    :initarg :current_seen_ratio
    :type cl:float
    :initform 0.0)
   (exploration_cost
    :reader exploration_cost
    :initarg :exploration_cost
    :type cl:float
    :initform 0.0)
   (coverage_cost
    :reader coverage_cost
    :initarg :coverage_cost
    :type cl:float
    :initform 0.0)
   (room_belief
    :reader room_belief
    :initarg :room_belief
    :type cl:float
    :initform 0.0)
   (tunnel_belief
    :reader tunnel_belief
    :initarg :tunnel_belief
    :type cl:float
    :initform 0.0)
   (perf_exp
    :reader perf_exp
    :initarg :perf_exp
    :type cl:float
    :initform 0.0)
   (perf_cov
    :reader perf_cov
    :initarg :perf_cov
    :type cl:float
    :initform 0.0)
   (delta_seen_surf
    :reader delta_seen_surf
    :initarg :delta_seen_surf
    :type cl:float
    :initform 0.0)
   (delta_seen_vol
    :reader delta_seen_vol
    :initarg :delta_seen_vol
    :type cl:float
    :initform 0.0)
   (image_brightness_utility
    :reader image_brightness_utility
    :initarg :image_brightness_utility
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (utility_sparse
    :reader utility_sparse
    :initarg :utility_sparse
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (utility_dense
    :reader utility_dense
    :initarg :utility_dense
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (utility_corridor
    :reader utility_corridor
    :initarg :utility_corridor
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (final_scores
    :reader final_scores
    :initarg :final_scores
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass BehaviourPlannerLogger (<BehaviourPlannerLogger>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BehaviourPlannerLogger>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BehaviourPlannerLogger)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planner_msgs-msg:<BehaviourPlannerLogger> is deprecated: use planner_msgs-msg:BehaviourPlannerLogger instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:header-val is deprecated.  Use planner_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'total_time-val :lambda-list '(m))
(cl:defmethod total_time-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:total_time-val is deprecated.  Use planner_msgs-msg:total_time instead.")
  (total_time m))

(cl:ensure-generic-function 'planner-val :lambda-list '(m))
(cl:defmethod planner-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:planner-val is deprecated.  Use planner_msgs-msg:planner instead.")
  (planner m))

(cl:ensure-generic-function 'current_seen_ratio-val :lambda-list '(m))
(cl:defmethod current_seen_ratio-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:current_seen_ratio-val is deprecated.  Use planner_msgs-msg:current_seen_ratio instead.")
  (current_seen_ratio m))

(cl:ensure-generic-function 'exploration_cost-val :lambda-list '(m))
(cl:defmethod exploration_cost-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:exploration_cost-val is deprecated.  Use planner_msgs-msg:exploration_cost instead.")
  (exploration_cost m))

(cl:ensure-generic-function 'coverage_cost-val :lambda-list '(m))
(cl:defmethod coverage_cost-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:coverage_cost-val is deprecated.  Use planner_msgs-msg:coverage_cost instead.")
  (coverage_cost m))

(cl:ensure-generic-function 'room_belief-val :lambda-list '(m))
(cl:defmethod room_belief-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:room_belief-val is deprecated.  Use planner_msgs-msg:room_belief instead.")
  (room_belief m))

(cl:ensure-generic-function 'tunnel_belief-val :lambda-list '(m))
(cl:defmethod tunnel_belief-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:tunnel_belief-val is deprecated.  Use planner_msgs-msg:tunnel_belief instead.")
  (tunnel_belief m))

(cl:ensure-generic-function 'perf_exp-val :lambda-list '(m))
(cl:defmethod perf_exp-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:perf_exp-val is deprecated.  Use planner_msgs-msg:perf_exp instead.")
  (perf_exp m))

(cl:ensure-generic-function 'perf_cov-val :lambda-list '(m))
(cl:defmethod perf_cov-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:perf_cov-val is deprecated.  Use planner_msgs-msg:perf_cov instead.")
  (perf_cov m))

(cl:ensure-generic-function 'delta_seen_surf-val :lambda-list '(m))
(cl:defmethod delta_seen_surf-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:delta_seen_surf-val is deprecated.  Use planner_msgs-msg:delta_seen_surf instead.")
  (delta_seen_surf m))

(cl:ensure-generic-function 'delta_seen_vol-val :lambda-list '(m))
(cl:defmethod delta_seen_vol-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:delta_seen_vol-val is deprecated.  Use planner_msgs-msg:delta_seen_vol instead.")
  (delta_seen_vol m))

(cl:ensure-generic-function 'image_brightness_utility-val :lambda-list '(m))
(cl:defmethod image_brightness_utility-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:image_brightness_utility-val is deprecated.  Use planner_msgs-msg:image_brightness_utility instead.")
  (image_brightness_utility m))

(cl:ensure-generic-function 'utility_sparse-val :lambda-list '(m))
(cl:defmethod utility_sparse-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:utility_sparse-val is deprecated.  Use planner_msgs-msg:utility_sparse instead.")
  (utility_sparse m))

(cl:ensure-generic-function 'utility_dense-val :lambda-list '(m))
(cl:defmethod utility_dense-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:utility_dense-val is deprecated.  Use planner_msgs-msg:utility_dense instead.")
  (utility_dense m))

(cl:ensure-generic-function 'utility_corridor-val :lambda-list '(m))
(cl:defmethod utility_corridor-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:utility_corridor-val is deprecated.  Use planner_msgs-msg:utility_corridor instead.")
  (utility_corridor m))

(cl:ensure-generic-function 'final_scores-val :lambda-list '(m))
(cl:defmethod final_scores-val ((m <BehaviourPlannerLogger>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planner_msgs-msg:final_scores-val is deprecated.  Use planner_msgs-msg:final_scores instead.")
  (final_scores m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BehaviourPlannerLogger>) ostream)
  "Serializes a message object of type '<BehaviourPlannerLogger>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'total_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'planner) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'current_seen_ratio))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'exploration_cost))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'coverage_cost))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'room_belief))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tunnel_belief))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'perf_exp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'perf_cov))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'delta_seen_surf))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'delta_seen_vol))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'image_brightness_utility))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'image_brightness_utility))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'utility_sparse))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'utility_sparse))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'utility_dense))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'utility_dense))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'utility_corridor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'utility_corridor))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'final_scores))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'final_scores))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BehaviourPlannerLogger>) istream)
  "Deserializes a message object of type '<BehaviourPlannerLogger>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'total_time) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'planner) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'current_seen_ratio) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'exploration_cost) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'coverage_cost) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'room_belief) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tunnel_belief) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'perf_exp) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'perf_cov) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'delta_seen_surf) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'delta_seen_vol) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'image_brightness_utility) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'image_brightness_utility)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'utility_sparse) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'utility_sparse)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'utility_dense) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'utility_dense)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'utility_corridor) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'utility_corridor)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'final_scores) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'final_scores)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BehaviourPlannerLogger>)))
  "Returns string type for a message object of type '<BehaviourPlannerLogger>"
  "planner_msgs/BehaviourPlannerLogger")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BehaviourPlannerLogger)))
  "Returns string type for a message object of type 'BehaviourPlannerLogger"
  "planner_msgs/BehaviourPlannerLogger")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BehaviourPlannerLogger>)))
  "Returns md5sum for a message object of type '<BehaviourPlannerLogger>"
  "c3c9c34a8a3952fd0863b37239f93bdd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BehaviourPlannerLogger)))
  "Returns md5sum for a message object of type 'BehaviourPlannerLogger"
  "c3c9c34a8a3952fd0863b37239f93bdd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BehaviourPlannerLogger>)))
  "Returns full string definition for message of type '<BehaviourPlannerLogger>"
  (cl:format cl:nil "Header header~%~%float32 total_time~%bool planner~%float32 current_seen_ratio ~%float32 exploration_cost~%float32 coverage_cost ~%float32 room_belief~%float32 tunnel_belief~%float32 perf_exp~%float32 perf_cov~%float32 delta_seen_surf~%float32 delta_seen_vol~%~%#Hypergame log~%float32[] image_brightness_utility~%float32[] utility_sparse~%float32[] utility_dense~%float32[] utility_corridor~%float32[] final_scores~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BehaviourPlannerLogger)))
  "Returns full string definition for message of type 'BehaviourPlannerLogger"
  (cl:format cl:nil "Header header~%~%float32 total_time~%bool planner~%float32 current_seen_ratio ~%float32 exploration_cost~%float32 coverage_cost ~%float32 room_belief~%float32 tunnel_belief~%float32 perf_exp~%float32 perf_cov~%float32 delta_seen_surf~%float32 delta_seen_vol~%~%#Hypergame log~%float32[] image_brightness_utility~%float32[] utility_sparse~%float32[] utility_dense~%float32[] utility_corridor~%float32[] final_scores~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BehaviourPlannerLogger>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     1
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'image_brightness_utility) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'utility_sparse) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'utility_dense) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'utility_corridor) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'final_scores) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BehaviourPlannerLogger>))
  "Converts a ROS message object to a list"
  (cl:list 'BehaviourPlannerLogger
    (cl:cons ':header (header msg))
    (cl:cons ':total_time (total_time msg))
    (cl:cons ':planner (planner msg))
    (cl:cons ':current_seen_ratio (current_seen_ratio msg))
    (cl:cons ':exploration_cost (exploration_cost msg))
    (cl:cons ':coverage_cost (coverage_cost msg))
    (cl:cons ':room_belief (room_belief msg))
    (cl:cons ':tunnel_belief (tunnel_belief msg))
    (cl:cons ':perf_exp (perf_exp msg))
    (cl:cons ':perf_cov (perf_cov msg))
    (cl:cons ':delta_seen_surf (delta_seen_surf msg))
    (cl:cons ':delta_seen_vol (delta_seen_vol msg))
    (cl:cons ':image_brightness_utility (image_brightness_utility msg))
    (cl:cons ':utility_sparse (utility_sparse msg))
    (cl:cons ':utility_dense (utility_dense msg))
    (cl:cons ':utility_corridor (utility_corridor msg))
    (cl:cons ':final_scores (final_scores msg))
))
