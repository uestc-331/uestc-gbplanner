;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::BoundMode)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'BoundMode (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::BOUNDMODE")
  (make-package "PLANNER_MSGS::BOUNDMODE"))

(in-package "ROS")
;;//! \htmlinclude BoundMode.msg.html


(intern "*KEXTENDEDBOUND*" (find-package "PLANNER_MSGS::BOUNDMODE"))
(shadow '*KEXTENDEDBOUND* (find-package "PLANNER_MSGS::BOUNDMODE"))
(defconstant planner_msgs::BoundMode::*KEXTENDEDBOUND* 0)
(intern "*KRELAXEDBOUND*" (find-package "PLANNER_MSGS::BOUNDMODE"))
(shadow '*KRELAXEDBOUND* (find-package "PLANNER_MSGS::BOUNDMODE"))
(defconstant planner_msgs::BoundMode::*KRELAXEDBOUND* 1)
(intern "*KMINBOUND*" (find-package "PLANNER_MSGS::BOUNDMODE"))
(shadow '*KMINBOUND* (find-package "PLANNER_MSGS::BOUNDMODE"))
(defconstant planner_msgs::BoundMode::*KMINBOUND* 2)
(intern "*KEXACTBOUND*" (find-package "PLANNER_MSGS::BOUNDMODE"))
(shadow '*KEXACTBOUND* (find-package "PLANNER_MSGS::BOUNDMODE"))
(defconstant planner_msgs::BoundMode::*KEXACTBOUND* 3)
(intern "*KNOBOUND*" (find-package "PLANNER_MSGS::BOUNDMODE"))
(shadow '*KNOBOUND* (find-package "PLANNER_MSGS::BOUNDMODE"))
(defconstant planner_msgs::BoundMode::*KNOBOUND* 4)

(defun planner_msgs::BoundMode-to-symbol (const)
  (cond
        ((= const 0) 'planner_msgs::BoundMode::*kExtendedBound*)
        ((= const 1) 'planner_msgs::BoundMode::*kRelaxedBound*)
        ((= const 2) 'planner_msgs::BoundMode::*kMinBound*)
        ((= const 3) 'planner_msgs::BoundMode::*kExactBound*)
        ((= const 4) 'planner_msgs::BoundMode::*kNoBound*)
        (t nil)))

(defclass planner_msgs::BoundMode
  :super ros::object
  :slots (_mode ))

(defmethod planner_msgs::BoundMode
  (:init
   (&key
    ((:mode __mode) 0)
    )
   (send-super :init)
   (setq _mode (round __mode))
   self)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:serialization-length
   ()
   (+
    ;; int32 _mode
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _mode
       (write-long _mode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _mode
     (setq _mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get planner_msgs::BoundMode :md5sum-) "f460d6fbd196a4aff993d7d1dbede7d9")
(setf (get planner_msgs::BoundMode :datatype-) "planner_msgs/BoundMode")
(setf (get planner_msgs::BoundMode :definition-)
      "# Bound mode of the robot for collision checking, defined in Params/BoundModeType.
int32 kExtendedBound = 0
int32 kRelaxedBound = 1
int32 kMinBound = 2
int32 kExactBound = 3
int32 kNoBound = 4

# Set one of above values.
int32 mode
")



(provide :planner_msgs/BoundMode "f460d6fbd196a4aff993d7d1dbede7d9")


