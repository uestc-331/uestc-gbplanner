;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::RectangleShape)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'RectangleShape (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::RECTANGLESHAPE")
  (make-package "PLANNER_MSGS::RECTANGLESHAPE"))

(in-package "ROS")
;;//! \htmlinclude RectangleShape.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass planner_msgs::RectangleShape
  :super ros::object
  :slots (_center _size ))

(defmethod planner_msgs::RectangleShape
  (:init
   (&key
    ((:center __center) (instance geometry_msgs::Vector3 :init))
    ((:size __size) (instance geometry_msgs::Vector3 :init))
    )
   (send-super :init)
   (setq _center __center)
   (setq _size __size)
   self)
  (:center
   (&rest __center)
   (if (keywordp (car __center))
       (send* _center __center)
     (progn
       (if __center (setq _center (car __center)))
       _center)))
  (:size
   (&rest __size)
   (if (keywordp (car __size))
       (send* _size __size)
     (progn
       (if __size (setq _size (car __size)))
       _size)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Vector3 _center
    (send _center :serialization-length)
    ;; geometry_msgs/Vector3 _size
    (send _size :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Vector3 _center
       (send _center :serialize s)
     ;; geometry_msgs/Vector3 _size
       (send _size :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Vector3 _center
     (send _center :deserialize buf ptr-) (incf ptr- (send _center :serialization-length))
   ;; geometry_msgs/Vector3 _size
     (send _size :deserialize buf ptr-) (incf ptr- (send _size :serialization-length))
   ;;
   self)
  )

(setf (get planner_msgs::RectangleShape :md5sum-) "17746d0996c54d9b8b0dfe6f3cd0b588")
(setf (get planner_msgs::RectangleShape :datatype-) "planner_msgs/RectangleShape")
(setf (get planner_msgs::RectangleShape :definition-)
      "geometry_msgs/Vector3 center
geometry_msgs/Vector3 size
================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :planner_msgs/RectangleShape "17746d0996c54d9b8b0dfe6f3cd0b588")


