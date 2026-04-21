;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_set_vel)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_set_vel (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_VEL")
  (make-package "PLANNER_MSGS::PLANNER_SET_VEL"))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_VELREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_SET_VELREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_VELRESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_SET_VELRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass planner_msgs::planner_set_velRequest
  :super ros::object
  :slots (_root_vel _set ))

(defmethod planner_msgs::planner_set_velRequest
  (:init
   (&key
    ((:root_vel __root_vel) (instance geometry_msgs::Twist :init))
    ((:set __set) nil)
    )
   (send-super :init)
   (setq _root_vel __root_vel)
   (setq _set __set)
   self)
  (:root_vel
   (&rest __root_vel)
   (if (keywordp (car __root_vel))
       (send* _root_vel __root_vel)
     (progn
       (if __root_vel (setq _root_vel (car __root_vel)))
       _root_vel)))
  (:set
   (&optional (__set :null))
   (if (not (eq __set :null)) (setq _set __set)) _set)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Twist _root_vel
    (send _root_vel :serialization-length)
    ;; bool _set
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Twist _root_vel
       (send _root_vel :serialize s)
     ;; bool _set
       (if _set (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Twist _root_vel
     (send _root_vel :deserialize buf ptr-) (incf ptr- (send _root_vel :serialization-length))
   ;; bool _set
     (setq _set (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass planner_msgs::planner_set_velResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::planner_set_velResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass planner_msgs::planner_set_vel
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_set_vel :md5sum-) "f45ed41d58956a227be4845c1fe6bd6d")
(setf (get planner_msgs::planner_set_vel :datatype-) "planner_msgs/planner_set_vel")
(setf (get planner_msgs::planner_set_vel :request) planner_msgs::planner_set_velRequest)
(setf (get planner_msgs::planner_set_vel :response) planner_msgs::planner_set_velResponse)

(defmethod planner_msgs::planner_set_velRequest
  (:response () (instance planner_msgs::planner_set_velResponse :init)))

(setf (get planner_msgs::planner_set_velRequest :md5sum-) "f45ed41d58956a227be4845c1fe6bd6d")
(setf (get planner_msgs::planner_set_velRequest :datatype-) "planner_msgs/planner_set_velRequest")
(setf (get planner_msgs::planner_set_velRequest :definition-)
      "geometry_msgs/Twist root_vel
bool set

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3 linear
Vector3 angular

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
---
bool success
")

(setf (get planner_msgs::planner_set_velResponse :md5sum-) "f45ed41d58956a227be4845c1fe6bd6d")
(setf (get planner_msgs::planner_set_velResponse :datatype-) "planner_msgs/planner_set_velResponse")
(setf (get planner_msgs::planner_set_velResponse :definition-)
      "geometry_msgs/Twist root_vel
bool set

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3 linear
Vector3 angular

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
---
bool success
")



(provide :planner_msgs/planner_set_vel "f45ed41d58956a227be4845c1fe6bd6d")


