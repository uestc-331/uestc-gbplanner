;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::ExecutionPathMode)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'ExecutionPathMode (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::EXECUTIONPATHMODE")
  (make-package "PLANNER_MSGS::EXECUTIONPATHMODE"))

(in-package "ROS")
;;//! \htmlinclude ExecutionPathMode.msg.html


(intern "*KLOCALPATH*" (find-package "PLANNER_MSGS::EXECUTIONPATHMODE"))
(shadow '*KLOCALPATH* (find-package "PLANNER_MSGS::EXECUTIONPATHMODE"))
(defconstant planner_msgs::ExecutionPathMode::*KLOCALPATH* 0)
(intern "*KHOMINGPATH*" (find-package "PLANNER_MSGS::EXECUTIONPATHMODE"))
(shadow '*KHOMINGPATH* (find-package "PLANNER_MSGS::EXECUTIONPATHMODE"))
(defconstant planner_msgs::ExecutionPathMode::*KHOMINGPATH* 1)
(intern "*KGLOBALPATH*" (find-package "PLANNER_MSGS::EXECUTIONPATHMODE"))
(shadow '*KGLOBALPATH* (find-package "PLANNER_MSGS::EXECUTIONPATHMODE"))
(defconstant planner_msgs::ExecutionPathMode::*KGLOBALPATH* 2)

(defun planner_msgs::ExecutionPathMode-to-symbol (const)
  (cond
        ((= const 0) 'planner_msgs::ExecutionPathMode::*kLocalPath*)
        ((= const 1) 'planner_msgs::ExecutionPathMode::*kHomingPath*)
        ((= const 2) 'planner_msgs::ExecutionPathMode::*kGlobalPath*)
        (t nil)))

(defclass planner_msgs::ExecutionPathMode
  :super ros::object
  :slots (_mode _is_forward ))

(defmethod planner_msgs::ExecutionPathMode
  (:init
   (&key
    ((:mode __mode) 0)
    ((:is_forward __is_forward) nil)
    )
   (send-super :init)
   (setq _mode (round __mode))
   (setq _is_forward __is_forward)
   self)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:is_forward
   (&optional (__is_forward :null))
   (if (not (eq __is_forward :null)) (setq _is_forward __is_forward)) _is_forward)
  (:serialization-length
   ()
   (+
    ;; int32 _mode
    4
    ;; bool _is_forward
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _mode
       (write-long _mode s)
     ;; bool _is_forward
       (if _is_forward (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _mode
     (setq _mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _is_forward
     (setq _is_forward (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get planner_msgs::ExecutionPathMode :md5sum-) "9e0ca27c7cff652c41de65686e5ccf7d")
(setf (get planner_msgs::ExecutionPathMode :datatype-) "planner_msgs/ExecutionPathMode")
(setf (get planner_msgs::ExecutionPathMode :definition-)
      "# Execution path mode, defined in ExecutionPathType.
int32 kLocalPath = 0
int32 kHomingPath = 1
int32 kGlobalPath = 2

# Set one of above values.
int32 mode

# The path is in forward direction compared to current exploration direction or not
bool is_forward
")



(provide :planner_msgs/ExecutionPathMode "9e0ca27c7cff652c41de65686e5ccf7d")


