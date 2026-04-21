;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_set_global_bound)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_set_global_bound (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_GLOBAL_BOUND")
  (make-package "PLANNER_MSGS::PLANNER_SET_GLOBAL_BOUND"))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_GLOBAL_BOUNDREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_SET_GLOBAL_BOUNDREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_GLOBAL_BOUNDRESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_SET_GLOBAL_BOUNDRESPONSE"))

(in-package "ROS")





(defclass planner_msgs::planner_set_global_boundRequest
  :super ros::object
  :slots (_get_current_bound _reset_to_default _bound ))

(defmethod planner_msgs::planner_set_global_boundRequest
  (:init
   (&key
    ((:get_current_bound __get_current_bound) nil)
    ((:reset_to_default __reset_to_default) nil)
    ((:bound __bound) (instance planner_msgs::PlanningBound :init))
    )
   (send-super :init)
   (setq _get_current_bound __get_current_bound)
   (setq _reset_to_default __reset_to_default)
   (setq _bound __bound)
   self)
  (:get_current_bound
   (&optional (__get_current_bound :null))
   (if (not (eq __get_current_bound :null)) (setq _get_current_bound __get_current_bound)) _get_current_bound)
  (:reset_to_default
   (&optional (__reset_to_default :null))
   (if (not (eq __reset_to_default :null)) (setq _reset_to_default __reset_to_default)) _reset_to_default)
  (:bound
   (&rest __bound)
   (if (keywordp (car __bound))
       (send* _bound __bound)
     (progn
       (if __bound (setq _bound (car __bound)))
       _bound)))
  (:serialization-length
   ()
   (+
    ;; bool _get_current_bound
    1
    ;; bool _reset_to_default
    1
    ;; planner_msgs/PlanningBound _bound
    (send _bound :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _get_current_bound
       (if _get_current_bound (write-byte -1 s) (write-byte 0 s))
     ;; bool _reset_to_default
       (if _reset_to_default (write-byte -1 s) (write-byte 0 s))
     ;; planner_msgs/PlanningBound _bound
       (send _bound :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _get_current_bound
     (setq _get_current_bound (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _reset_to_default
     (setq _reset_to_default (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; planner_msgs/PlanningBound _bound
     (send _bound :deserialize buf ptr-) (incf ptr- (send _bound :serialization-length))
   ;;
   self)
  )

(defclass planner_msgs::planner_set_global_boundResponse
  :super ros::object
  :slots (_success _bound_ret ))

(defmethod planner_msgs::planner_set_global_boundResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:bound_ret __bound_ret) (instance planner_msgs::PlanningBound :init))
    )
   (send-super :init)
   (setq _success __success)
   (setq _bound_ret __bound_ret)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:bound_ret
   (&rest __bound_ret)
   (if (keywordp (car __bound_ret))
       (send* _bound_ret __bound_ret)
     (progn
       (if __bound_ret (setq _bound_ret (car __bound_ret)))
       _bound_ret)))
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; planner_msgs/PlanningBound _bound_ret
    (send _bound_ret :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; planner_msgs/PlanningBound _bound_ret
       (send _bound_ret :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; planner_msgs/PlanningBound _bound_ret
     (send _bound_ret :deserialize buf ptr-) (incf ptr- (send _bound_ret :serialization-length))
   ;;
   self)
  )

(defclass planner_msgs::planner_set_global_bound
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_set_global_bound :md5sum-) "1aed38fc3ce6d17635872f522b7dea8f")
(setf (get planner_msgs::planner_set_global_bound :datatype-) "planner_msgs/planner_set_global_bound")
(setf (get planner_msgs::planner_set_global_bound :request) planner_msgs::planner_set_global_boundRequest)
(setf (get planner_msgs::planner_set_global_bound :response) planner_msgs::planner_set_global_boundResponse)

(defmethod planner_msgs::planner_set_global_boundRequest
  (:response () (instance planner_msgs::planner_set_global_boundResponse :init)))

(setf (get planner_msgs::planner_set_global_boundRequest :md5sum-) "1aed38fc3ce6d17635872f522b7dea8f")
(setf (get planner_msgs::planner_set_global_boundRequest :datatype-) "planner_msgs/planner_set_global_boundRequest")
(setf (get planner_msgs::planner_set_global_boundRequest :definition-)
      "# get_current_bound:
#   true: get current bound, nothing to set
#   false: set bound then returns the latest bound
bool get_current_bound

# reset_to_default:
#   true:  reset to the default bounding box
#   false: set new bounding box
bool reset_to_default

planner_msgs/PlanningBound bound

================================================================================
MSG: planner_msgs/PlanningBound
# use_z_val
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
---
bool success

# Return the actual value inside planner after calling this service
planner_msgs/PlanningBound bound_ret

================================================================================
MSG: planner_msgs/PlanningBound
# use_z_val
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

(setf (get planner_msgs::planner_set_global_boundResponse :md5sum-) "1aed38fc3ce6d17635872f522b7dea8f")
(setf (get planner_msgs::planner_set_global_boundResponse :datatype-) "planner_msgs/planner_set_global_boundResponse")
(setf (get planner_msgs::planner_set_global_boundResponse :definition-)
      "# get_current_bound:
#   true: get current bound, nothing to set
#   false: set bound then returns the latest bound
bool get_current_bound

# reset_to_default:
#   true:  reset to the default bounding box
#   false: set new bounding box
bool reset_to_default

planner_msgs/PlanningBound bound

================================================================================
MSG: planner_msgs/PlanningBound
# use_z_val
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
---
bool success

# Return the actual value inside planner after calling this service
planner_msgs/PlanningBound bound_ret

================================================================================
MSG: planner_msgs/PlanningBound
# use_z_val
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



(provide :planner_msgs/planner_set_global_bound "1aed38fc3ce6d17635872f522b7dea8f")


