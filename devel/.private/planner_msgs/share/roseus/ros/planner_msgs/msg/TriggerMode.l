;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::TriggerMode)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'TriggerMode (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::TRIGGERMODE")
  (make-package "PLANNER_MSGS::TRIGGERMODE"))

(in-package "ROS")
;;//! \htmlinclude TriggerMode.msg.html


(intern "*KMANUAL*" (find-package "PLANNER_MSGS::TRIGGERMODE"))
(shadow '*KMANUAL* (find-package "PLANNER_MSGS::TRIGGERMODE"))
(defconstant planner_msgs::TriggerMode::*KMANUAL* 0)
(intern "*KAUTO*" (find-package "PLANNER_MSGS::TRIGGERMODE"))
(shadow '*KAUTO* (find-package "PLANNER_MSGS::TRIGGERMODE"))
(defconstant planner_msgs::TriggerMode::*KAUTO* 1)

(defun planner_msgs::TriggerMode-to-symbol (const)
  (cond
        ((= const 0) 'planner_msgs::TriggerMode::*kManual*)
        ((= const 1) 'planner_msgs::TriggerMode::*kAuto*)
        (t nil)))

(defclass planner_msgs::TriggerMode
  :super ros::object
  :slots (_mode ))

(defmethod planner_msgs::TriggerMode
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

(setf (get planner_msgs::TriggerMode :md5sum-) "e015c2f806de584b22f4c9d1a829c5b8")
(setf (get planner_msgs::TriggerMode :datatype-) "planner_msgs/TriggerMode")
(setf (get planner_msgs::TriggerMode :definition-)
      "# Trigger mode of planner control interface, defined in PlannerTriggerModeType.
int32 kManual = 0
int32 kAuto = 1

# Set one of above values.
int32 mode
")



(provide :planner_msgs/TriggerMode "e015c2f806de584b22f4c9d1a829c5b8")


