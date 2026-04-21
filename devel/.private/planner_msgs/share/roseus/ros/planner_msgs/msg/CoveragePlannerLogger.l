;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::CoveragePlannerLogger)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'CoveragePlannerLogger (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::COVERAGEPLANNERLOGGER")
  (make-package "PLANNER_MSGS::COVERAGEPLANNERLOGGER"))

(in-package "ROS")
;;//! \htmlinclude CoveragePlannerLogger.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass planner_msgs::CoveragePlannerLogger
  :super ros::object
  :slots (_header _graph_build_time _total_time _path_length _tsp_path_time ))

(defmethod planner_msgs::CoveragePlannerLogger
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:graph_build_time __graph_build_time) 0.0)
    ((:total_time __total_time) 0.0)
    ((:path_length __path_length) 0.0)
    ((:tsp_path_time __tsp_path_time) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _graph_build_time (float __graph_build_time))
   (setq _total_time (float __total_time))
   (setq _path_length (float __path_length))
   (setq _tsp_path_time (float __tsp_path_time))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:graph_build_time
   (&optional __graph_build_time)
   (if __graph_build_time (setq _graph_build_time __graph_build_time)) _graph_build_time)
  (:total_time
   (&optional __total_time)
   (if __total_time (setq _total_time __total_time)) _total_time)
  (:path_length
   (&optional __path_length)
   (if __path_length (setq _path_length __path_length)) _path_length)
  (:tsp_path_time
   (&optional __tsp_path_time)
   (if __tsp_path_time (setq _tsp_path_time __tsp_path_time)) _tsp_path_time)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _graph_build_time
    4
    ;; float32 _total_time
    4
    ;; float32 _path_length
    4
    ;; float32 _tsp_path_time
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _graph_build_time
       (sys::poke _graph_build_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _total_time
       (sys::poke _total_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _path_length
       (sys::poke _path_length (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _tsp_path_time
       (sys::poke _tsp_path_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _graph_build_time
     (setq _graph_build_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _total_time
     (setq _total_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _path_length
     (setq _path_length (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _tsp_path_time
     (setq _tsp_path_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get planner_msgs::CoveragePlannerLogger :md5sum-) "4af5c001f0e3078a457323f300d3ce22")
(setf (get planner_msgs::CoveragePlannerLogger :datatype-) "planner_msgs/CoveragePlannerLogger")
(setf (get planner_msgs::CoveragePlannerLogger :definition-)
      "Header header

float32 graph_build_time
float32 total_time
float32 path_length
float32 tsp_path_time
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



(provide :planner_msgs/CoveragePlannerLogger "4af5c001f0e3078a457323f300d3ce22")


