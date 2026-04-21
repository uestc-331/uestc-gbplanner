;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_set_search_mode)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_set_search_mode (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_SEARCH_MODE")
  (make-package "PLANNER_MSGS::PLANNER_SET_SEARCH_MODE"))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_SEARCH_MODEREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_SET_SEARCH_MODEREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_SEARCH_MODERESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_SET_SEARCH_MODERESPONSE"))

(in-package "ROS")





(defclass planner_msgs::planner_set_search_modeRequest
  :super ros::object
  :slots (_search_mode ))

(defmethod planner_msgs::planner_set_search_modeRequest
  (:init
   (&key
    ((:search_mode __search_mode) (instance planner_msgs::PlanningMode :init))
    )
   (send-super :init)
   (setq _search_mode __search_mode)
   self)
  (:search_mode
   (&rest __search_mode)
   (if (keywordp (car __search_mode))
       (send* _search_mode __search_mode)
     (progn
       (if __search_mode (setq _search_mode (car __search_mode)))
       _search_mode)))
  (:serialization-length
   ()
   (+
    ;; planner_msgs/PlanningMode _search_mode
    (send _search_mode :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; planner_msgs/PlanningMode _search_mode
       (send _search_mode :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; planner_msgs/PlanningMode _search_mode
     (send _search_mode :deserialize buf ptr-) (incf ptr- (send _search_mode :serialization-length))
   ;;
   self)
  )

(defclass planner_msgs::planner_set_search_modeResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::planner_set_search_modeResponse
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

(defclass planner_msgs::planner_set_search_mode
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_set_search_mode :md5sum-) "7dd8f9262ed5f0e5ecceeb616f68053b")
(setf (get planner_msgs::planner_set_search_mode :datatype-) "planner_msgs/planner_set_search_mode")
(setf (get planner_msgs::planner_set_search_mode :request) planner_msgs::planner_set_search_modeRequest)
(setf (get planner_msgs::planner_set_search_mode :response) planner_msgs::planner_set_search_modeResponse)

(defmethod planner_msgs::planner_set_search_modeRequest
  (:response () (instance planner_msgs::planner_set_search_modeResponse :init)))

(setf (get planner_msgs::planner_set_search_modeRequest :md5sum-) "7dd8f9262ed5f0e5ecceeb616f68053b")
(setf (get planner_msgs::planner_set_search_modeRequest :datatype-) "planner_msgs/planner_set_search_modeRequest")
(setf (get planner_msgs::planner_set_search_modeRequest :definition-)
      "planner_msgs/PlanningMode search_mode

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

(setf (get planner_msgs::planner_set_search_modeResponse :md5sum-) "7dd8f9262ed5f0e5ecceeb616f68053b")
(setf (get planner_msgs::planner_set_search_modeResponse :datatype-) "planner_msgs/planner_set_search_modeResponse")
(setf (get planner_msgs::planner_set_search_modeResponse :definition-)
      "planner_msgs/PlanningMode search_mode

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



(provide :planner_msgs/planner_set_search_mode "7dd8f9262ed5f0e5ecceeb616f68053b")


