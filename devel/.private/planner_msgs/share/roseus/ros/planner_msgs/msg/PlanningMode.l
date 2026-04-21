;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::PlanningMode)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'PlanningMode (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNINGMODE")
  (make-package "PLANNER_MSGS::PLANNINGMODE"))

(in-package "ROS")
;;//! \htmlinclude PlanningMode.msg.html


(intern "*KBASICEXPLORATION*" (find-package "PLANNER_MSGS::PLANNINGMODE"))
(shadow '*KBASICEXPLORATION* (find-package "PLANNER_MSGS::PLANNINGMODE"))
(defconstant planner_msgs::PlanningMode::*KBASICEXPLORATION* 0)
(intern "*KNARROWENVEXPLORATION*" (find-package "PLANNER_MSGS::PLANNINGMODE"))
(shadow '*KNARROWENVEXPLORATION* (find-package "PLANNER_MSGS::PLANNINGMODE"))
(defconstant planner_msgs::PlanningMode::*KNARROWENVEXPLORATION* 1)
(intern "*KADAPTIVEEXPLORATION*" (find-package "PLANNER_MSGS::PLANNINGMODE"))
(shadow '*KADAPTIVEEXPLORATION* (find-package "PLANNER_MSGS::PLANNINGMODE"))
(defconstant planner_msgs::PlanningMode::*KADAPTIVEEXPLORATION* 2)

(defun planner_msgs::PlanningMode-to-symbol (const)
  (cond
        ((= const 0) 'planner_msgs::PlanningMode::*kBasicExploration*)
        ((= const 1) 'planner_msgs::PlanningMode::*kNarrowEnvExploration*)
        ((= const 2) 'planner_msgs::PlanningMode::*kAdaptiveExploration*)
        (t nil)))

(defclass planner_msgs::PlanningMode
  :super ros::object
  :slots (_mode ))

(defmethod planner_msgs::PlanningMode
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

(setf (get planner_msgs::PlanningMode :md5sum-) "565e7cf808eefb4996657b401755699b")
(setf (get planner_msgs::PlanningMode :datatype-) "planner_msgs/PlanningMode")
(setf (get planner_msgs::PlanningMode :definition-)
      "# Planning mode for exploration, defined in Params/PlanningModeType.
int32 kBasicExploration = 0
int32 kNarrowEnvExploration = 1
int32 kAdaptiveExploration = 2

# Set one of above values.
int32 mode
")



(provide :planner_msgs/PlanningMode "565e7cf808eefb4996657b401755699b")


