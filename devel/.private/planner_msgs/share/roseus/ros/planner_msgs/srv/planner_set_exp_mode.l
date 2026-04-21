;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_set_exp_mode)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_set_exp_mode (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_EXP_MODE")
  (make-package "PLANNER_MSGS::PLANNER_SET_EXP_MODE"))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_EXP_MODEREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_SET_EXP_MODEREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_EXP_MODERESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_SET_EXP_MODERESPONSE"))

(in-package "ROS")





(defclass planner_msgs::planner_set_exp_modeRequest
  :super ros::object
  :slots (_exp_mode ))

(defmethod planner_msgs::planner_set_exp_modeRequest
  (:init
   (&key
    ((:exp_mode __exp_mode) (instance planner_msgs::PlanningMode :init))
    )
   (send-super :init)
   (setq _exp_mode __exp_mode)
   self)
  (:exp_mode
   (&rest __exp_mode)
   (if (keywordp (car __exp_mode))
       (send* _exp_mode __exp_mode)
     (progn
       (if __exp_mode (setq _exp_mode (car __exp_mode)))
       _exp_mode)))
  (:serialization-length
   ()
   (+
    ;; planner_msgs/PlanningMode _exp_mode
    (send _exp_mode :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; planner_msgs/PlanningMode _exp_mode
       (send _exp_mode :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; planner_msgs/PlanningMode _exp_mode
     (send _exp_mode :deserialize buf ptr-) (incf ptr- (send _exp_mode :serialization-length))
   ;;
   self)
  )

(defclass planner_msgs::planner_set_exp_modeResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::planner_set_exp_modeResponse
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

(defclass planner_msgs::planner_set_exp_mode
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_set_exp_mode :md5sum-) "77df73f792ae041f34f0514a2cf99738")
(setf (get planner_msgs::planner_set_exp_mode :datatype-) "planner_msgs/planner_set_exp_mode")
(setf (get planner_msgs::planner_set_exp_mode :request) planner_msgs::planner_set_exp_modeRequest)
(setf (get planner_msgs::planner_set_exp_mode :response) planner_msgs::planner_set_exp_modeResponse)

(defmethod planner_msgs::planner_set_exp_modeRequest
  (:response () (instance planner_msgs::planner_set_exp_modeResponse :init)))

(setf (get planner_msgs::planner_set_exp_modeRequest :md5sum-) "77df73f792ae041f34f0514a2cf99738")
(setf (get planner_msgs::planner_set_exp_modeRequest :datatype-) "planner_msgs/planner_set_exp_modeRequest")
(setf (get planner_msgs::planner_set_exp_modeRequest :definition-)
      "planner_msgs/PlanningMode exp_mode

================================================================================
MSG: planner_msgs/PlanningMode
# Planning mode for exploration, defined in Params/PlanningModeType.
int32 kBasicExploration = 0
int32 kNarrowEnvExploration = 1
int32 kAdaptiveExploration = 2

# Set one of above values.
---
bool success
")

(setf (get planner_msgs::planner_set_exp_modeResponse :md5sum-) "77df73f792ae041f34f0514a2cf99738")
(setf (get planner_msgs::planner_set_exp_modeResponse :datatype-) "planner_msgs/planner_set_exp_modeResponse")
(setf (get planner_msgs::planner_set_exp_modeResponse :definition-)
      "planner_msgs/PlanningMode exp_mode

================================================================================
MSG: planner_msgs/PlanningMode
# Planning mode for exploration, defined in Params/PlanningModeType.
int32 kBasicExploration = 0
int32 kNarrowEnvExploration = 1
int32 kAdaptiveExploration = 2

# Set one of above values.
---
bool success
")



(provide :planner_msgs/planner_set_exp_mode "77df73f792ae041f34f0514a2cf99738")


