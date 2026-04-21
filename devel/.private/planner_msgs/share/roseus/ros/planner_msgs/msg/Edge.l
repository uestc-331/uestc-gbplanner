;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::Edge)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'Edge (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::EDGE")
  (make-package "PLANNER_MSGS::EDGE"))

(in-package "ROS")
;;//! \htmlinclude Edge.msg.html


(defclass planner_msgs::Edge
  :super ros::object
  :slots (_source_id _target_id _weight ))

(defmethod planner_msgs::Edge
  (:init
   (&key
    ((:source_id __source_id) 0)
    ((:target_id __target_id) 0)
    ((:weight __weight) 0.0)
    )
   (send-super :init)
   (setq _source_id (round __source_id))
   (setq _target_id (round __target_id))
   (setq _weight (float __weight))
   self)
  (:source_id
   (&optional __source_id)
   (if __source_id (setq _source_id __source_id)) _source_id)
  (:target_id
   (&optional __target_id)
   (if __target_id (setq _target_id __target_id)) _target_id)
  (:weight
   (&optional __weight)
   (if __weight (setq _weight __weight)) _weight)
  (:serialization-length
   ()
   (+
    ;; int32 _source_id
    4
    ;; int32 _target_id
    4
    ;; float32 _weight
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _source_id
       (write-long _source_id s)
     ;; int32 _target_id
       (write-long _target_id s)
     ;; float32 _weight
       (sys::poke _weight (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _source_id
     (setq _source_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _target_id
     (setq _target_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _weight
     (setq _weight (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get planner_msgs::Edge :md5sum-) "4f0bbb1b628ed8cf4b65bbaa06d6225d")
(setf (get planner_msgs::Edge :datatype-) "planner_msgs/Edge")
(setf (get planner_msgs::Edge :definition-)
      "int32 source_id
int32 target_id
float32 weight
")



(provide :planner_msgs/Edge "4f0bbb1b628ed8cf4b65bbaa06d6225d")


