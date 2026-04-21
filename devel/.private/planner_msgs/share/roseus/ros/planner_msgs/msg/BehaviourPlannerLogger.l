;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::BehaviourPlannerLogger)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'BehaviourPlannerLogger (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::BEHAVIOURPLANNERLOGGER")
  (make-package "PLANNER_MSGS::BEHAVIOURPLANNERLOGGER"))

(in-package "ROS")
;;//! \htmlinclude BehaviourPlannerLogger.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass planner_msgs::BehaviourPlannerLogger
  :super ros::object
  :slots (_header _total_time _planner _current_seen_ratio _exploration_cost _coverage_cost _room_belief _tunnel_belief _perf_exp _perf_cov _delta_seen_surf _delta_seen_vol _image_brightness_utility _utility_sparse _utility_dense _utility_corridor _final_scores ))

(defmethod planner_msgs::BehaviourPlannerLogger
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:total_time __total_time) 0.0)
    ((:planner __planner) nil)
    ((:current_seen_ratio __current_seen_ratio) 0.0)
    ((:exploration_cost __exploration_cost) 0.0)
    ((:coverage_cost __coverage_cost) 0.0)
    ((:room_belief __room_belief) 0.0)
    ((:tunnel_belief __tunnel_belief) 0.0)
    ((:perf_exp __perf_exp) 0.0)
    ((:perf_cov __perf_cov) 0.0)
    ((:delta_seen_surf __delta_seen_surf) 0.0)
    ((:delta_seen_vol __delta_seen_vol) 0.0)
    ((:image_brightness_utility __image_brightness_utility) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:utility_sparse __utility_sparse) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:utility_dense __utility_dense) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:utility_corridor __utility_corridor) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:final_scores __final_scores) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _total_time (float __total_time))
   (setq _planner __planner)
   (setq _current_seen_ratio (float __current_seen_ratio))
   (setq _exploration_cost (float __exploration_cost))
   (setq _coverage_cost (float __coverage_cost))
   (setq _room_belief (float __room_belief))
   (setq _tunnel_belief (float __tunnel_belief))
   (setq _perf_exp (float __perf_exp))
   (setq _perf_cov (float __perf_cov))
   (setq _delta_seen_surf (float __delta_seen_surf))
   (setq _delta_seen_vol (float __delta_seen_vol))
   (setq _image_brightness_utility __image_brightness_utility)
   (setq _utility_sparse __utility_sparse)
   (setq _utility_dense __utility_dense)
   (setq _utility_corridor __utility_corridor)
   (setq _final_scores __final_scores)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:total_time
   (&optional __total_time)
   (if __total_time (setq _total_time __total_time)) _total_time)
  (:planner
   (&optional (__planner :null))
   (if (not (eq __planner :null)) (setq _planner __planner)) _planner)
  (:current_seen_ratio
   (&optional __current_seen_ratio)
   (if __current_seen_ratio (setq _current_seen_ratio __current_seen_ratio)) _current_seen_ratio)
  (:exploration_cost
   (&optional __exploration_cost)
   (if __exploration_cost (setq _exploration_cost __exploration_cost)) _exploration_cost)
  (:coverage_cost
   (&optional __coverage_cost)
   (if __coverage_cost (setq _coverage_cost __coverage_cost)) _coverage_cost)
  (:room_belief
   (&optional __room_belief)
   (if __room_belief (setq _room_belief __room_belief)) _room_belief)
  (:tunnel_belief
   (&optional __tunnel_belief)
   (if __tunnel_belief (setq _tunnel_belief __tunnel_belief)) _tunnel_belief)
  (:perf_exp
   (&optional __perf_exp)
   (if __perf_exp (setq _perf_exp __perf_exp)) _perf_exp)
  (:perf_cov
   (&optional __perf_cov)
   (if __perf_cov (setq _perf_cov __perf_cov)) _perf_cov)
  (:delta_seen_surf
   (&optional __delta_seen_surf)
   (if __delta_seen_surf (setq _delta_seen_surf __delta_seen_surf)) _delta_seen_surf)
  (:delta_seen_vol
   (&optional __delta_seen_vol)
   (if __delta_seen_vol (setq _delta_seen_vol __delta_seen_vol)) _delta_seen_vol)
  (:image_brightness_utility
   (&optional __image_brightness_utility)
   (if __image_brightness_utility (setq _image_brightness_utility __image_brightness_utility)) _image_brightness_utility)
  (:utility_sparse
   (&optional __utility_sparse)
   (if __utility_sparse (setq _utility_sparse __utility_sparse)) _utility_sparse)
  (:utility_dense
   (&optional __utility_dense)
   (if __utility_dense (setq _utility_dense __utility_dense)) _utility_dense)
  (:utility_corridor
   (&optional __utility_corridor)
   (if __utility_corridor (setq _utility_corridor __utility_corridor)) _utility_corridor)
  (:final_scores
   (&optional __final_scores)
   (if __final_scores (setq _final_scores __final_scores)) _final_scores)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _total_time
    4
    ;; bool _planner
    1
    ;; float32 _current_seen_ratio
    4
    ;; float32 _exploration_cost
    4
    ;; float32 _coverage_cost
    4
    ;; float32 _room_belief
    4
    ;; float32 _tunnel_belief
    4
    ;; float32 _perf_exp
    4
    ;; float32 _perf_cov
    4
    ;; float32 _delta_seen_surf
    4
    ;; float32 _delta_seen_vol
    4
    ;; float32[] _image_brightness_utility
    (* 4    (length _image_brightness_utility)) 4
    ;; float32[] _utility_sparse
    (* 4    (length _utility_sparse)) 4
    ;; float32[] _utility_dense
    (* 4    (length _utility_dense)) 4
    ;; float32[] _utility_corridor
    (* 4    (length _utility_corridor)) 4
    ;; float32[] _final_scores
    (* 4    (length _final_scores)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _total_time
       (sys::poke _total_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _planner
       (if _planner (write-byte -1 s) (write-byte 0 s))
     ;; float32 _current_seen_ratio
       (sys::poke _current_seen_ratio (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _exploration_cost
       (sys::poke _exploration_cost (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _coverage_cost
       (sys::poke _coverage_cost (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _room_belief
       (sys::poke _room_belief (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _tunnel_belief
       (sys::poke _tunnel_belief (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _perf_exp
       (sys::poke _perf_exp (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _perf_cov
       (sys::poke _perf_cov (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _delta_seen_surf
       (sys::poke _delta_seen_surf (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _delta_seen_vol
       (sys::poke _delta_seen_vol (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _image_brightness_utility
     (write-long (length _image_brightness_utility) s)
     (dotimes (i (length _image_brightness_utility))
       (sys::poke (elt _image_brightness_utility i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _utility_sparse
     (write-long (length _utility_sparse) s)
     (dotimes (i (length _utility_sparse))
       (sys::poke (elt _utility_sparse i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _utility_dense
     (write-long (length _utility_dense) s)
     (dotimes (i (length _utility_dense))
       (sys::poke (elt _utility_dense i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _utility_corridor
     (write-long (length _utility_corridor) s)
     (dotimes (i (length _utility_corridor))
       (sys::poke (elt _utility_corridor i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _final_scores
     (write-long (length _final_scores) s)
     (dotimes (i (length _final_scores))
       (sys::poke (elt _final_scores i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _total_time
     (setq _total_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _planner
     (setq _planner (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _current_seen_ratio
     (setq _current_seen_ratio (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _exploration_cost
     (setq _exploration_cost (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _coverage_cost
     (setq _coverage_cost (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _room_belief
     (setq _room_belief (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _tunnel_belief
     (setq _tunnel_belief (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _perf_exp
     (setq _perf_exp (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _perf_cov
     (setq _perf_cov (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _delta_seen_surf
     (setq _delta_seen_surf (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _delta_seen_vol
     (setq _delta_seen_vol (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _image_brightness_utility
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _image_brightness_utility (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _image_brightness_utility i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _utility_sparse
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _utility_sparse (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _utility_sparse i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _utility_dense
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _utility_dense (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _utility_dense i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _utility_corridor
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _utility_corridor (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _utility_corridor i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _final_scores
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _final_scores (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _final_scores i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get planner_msgs::BehaviourPlannerLogger :md5sum-) "c3c9c34a8a3952fd0863b37239f93bdd")
(setf (get planner_msgs::BehaviourPlannerLogger :datatype-) "planner_msgs/BehaviourPlannerLogger")
(setf (get planner_msgs::BehaviourPlannerLogger :definition-)
      "Header header

float32 total_time
bool planner
float32 current_seen_ratio 
float32 exploration_cost
float32 coverage_cost 
float32 room_belief
float32 tunnel_belief
float32 perf_exp
float32 perf_cov
float32 delta_seen_surf
float32 delta_seen_vol

#Hypergame log
float32[] image_brightness_utility
float32[] utility_sparse
float32[] utility_dense
float32[] utility_corridor
float32[] final_scores
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :planner_msgs/BehaviourPlannerLogger "c3c9c34a8a3952fd0863b37239f93bdd")


