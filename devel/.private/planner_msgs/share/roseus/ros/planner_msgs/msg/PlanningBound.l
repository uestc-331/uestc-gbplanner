;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::PlanningBound)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'PlanningBound (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNINGBOUND")
  (make-package "PLANNER_MSGS::PLANNINGBOUND"))

(in-package "ROS")
;;//! \htmlinclude PlanningBound.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass planner_msgs::PlanningBound
  :super ros::object
  :slots (_use_z_val _min_val _max_val ))

(defmethod planner_msgs::PlanningBound
  (:init
   (&key
    ((:use_z_val __use_z_val) nil)
    ((:min_val __min_val) (instance geometry_msgs::Point :init))
    ((:max_val __max_val) (instance geometry_msgs::Point :init))
    )
   (send-super :init)
   (setq _use_z_val __use_z_val)
   (setq _min_val __min_val)
   (setq _max_val __max_val)
   self)
  (:use_z_val
   (&optional (__use_z_val :null))
   (if (not (eq __use_z_val :null)) (setq _use_z_val __use_z_val)) _use_z_val)
  (:min_val
   (&rest __min_val)
   (if (keywordp (car __min_val))
       (send* _min_val __min_val)
     (progn
       (if __min_val (setq _min_val (car __min_val)))
       _min_val)))
  (:max_val
   (&rest __max_val)
   (if (keywordp (car __max_val))
       (send* _max_val __max_val)
     (progn
       (if __max_val (setq _max_val (car __max_val)))
       _max_val)))
  (:serialization-length
   ()
   (+
    ;; bool _use_z_val
    1
    ;; geometry_msgs/Point _min_val
    (send _min_val :serialization-length)
    ;; geometry_msgs/Point _max_val
    (send _max_val :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _use_z_val
       (if _use_z_val (write-byte -1 s) (write-byte 0 s))
     ;; geometry_msgs/Point _min_val
       (send _min_val :serialize s)
     ;; geometry_msgs/Point _max_val
       (send _max_val :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _use_z_val
     (setq _use_z_val (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; geometry_msgs/Point _min_val
     (send _min_val :deserialize buf ptr-) (incf ptr- (send _min_val :serialization-length))
   ;; geometry_msgs/Point _max_val
     (send _max_val :deserialize buf ptr-) (incf ptr- (send _max_val :serialization-length))
   ;;
   self)
  )

(setf (get planner_msgs::PlanningBound :md5sum-) "9946f675c617611331fb20682325fff7")
(setf (get planner_msgs::PlanningBound :datatype-) "planner_msgs/PlanningBound")
(setf (get planner_msgs::PlanningBound :definition-)
      "# use_z_val
#    true:  all x, y, z coordinate
#    false: change only x, y coodinates
bool use_z_val

# Bottom left corner
geometry_msgs/Point min_val

# Top right corner
geometry_msgs/Point max_val
================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :planner_msgs/PlanningBound "9946f675c617611331fb20682325fff7")


