;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_set_planning_mode)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_set_planning_mode (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_PLANNING_MODE")
  (make-package "PLANNER_MSGS::PLANNER_SET_PLANNING_MODE"))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_PLANNING_MODEREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_SET_PLANNING_MODEREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_PLANNING_MODERESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_SET_PLANNING_MODERESPONSE"))

(in-package "ROS")





(intern "*KMANUAL*" (find-package "PLANNER_MSGS::PLANNER_SET_PLANNING_MODEREQUEST"))
(shadow '*KMANUAL* (find-package "PLANNER_MSGS::PLANNER_SET_PLANNING_MODEREQUEST"))
(defconstant planner_msgs::planner_set_planning_modeRequest::*KMANUAL* 0)
(intern "*KAUTO*" (find-package "PLANNER_MSGS::PLANNER_SET_PLANNING_MODEREQUEST"))
(shadow '*KAUTO* (find-package "PLANNER_MSGS::PLANNER_SET_PLANNING_MODEREQUEST"))
(defconstant planner_msgs::planner_set_planning_modeRequest::*KAUTO* 1)

(defun planner_msgs::planner_set_planning_modeRequest-to-symbol (const)
  (cond
        ((= const 0) 'planner_msgs::planner_set_planning_modeRequest::*kManual*)
        ((= const 1) 'planner_msgs::planner_set_planning_modeRequest::*kAuto*)
        (t nil)))

(defclass planner_msgs::planner_set_planning_modeRequest
  :super ros::object
  :slots (_planning_mode ))

(defmethod planner_msgs::planner_set_planning_modeRequest
  (:init
   (&key
    ((:planning_mode __planning_mode) 0)
    )
   (send-super :init)
   (setq _planning_mode (round __planning_mode))
   self)
  (:planning_mode
   (&optional __planning_mode)
   (if __planning_mode (setq _planning_mode __planning_mode)) _planning_mode)
  (:serialization-length
   ()
   (+
    ;; int32 _planning_mode
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _planning_mode
       (write-long _planning_mode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _planning_mode
     (setq _planning_mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass planner_msgs::planner_set_planning_modeResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::planner_set_planning_modeResponse
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

(defclass planner_msgs::planner_set_planning_mode
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_set_planning_mode :md5sum-) "f5c508faaff06b83ff7d994be5342caa")
(setf (get planner_msgs::planner_set_planning_mode :datatype-) "planner_msgs/planner_set_planning_mode")
(setf (get planner_msgs::planner_set_planning_mode :request) planner_msgs::planner_set_planning_modeRequest)
(setf (get planner_msgs::planner_set_planning_mode :response) planner_msgs::planner_set_planning_modeResponse)

(defmethod planner_msgs::planner_set_planning_modeRequest
  (:response () (instance planner_msgs::planner_set_planning_modeResponse :init)))

(setf (get planner_msgs::planner_set_planning_modeRequest :md5sum-) "f5c508faaff06b83ff7d994be5342caa")
(setf (get planner_msgs::planner_set_planning_modeRequest :datatype-) "planner_msgs/planner_set_planning_modeRequest")
(setf (get planner_msgs::planner_set_planning_modeRequest :definition-)
      "# Set the planning mode of the robot to use in planner.
int32 kManual = 0
int32 kAuto = 1
# Can only be used with one of above values. Check Params/BoundModeType for more details.
int32 planning_mode

---

bool success
")

(setf (get planner_msgs::planner_set_planning_modeResponse :md5sum-) "f5c508faaff06b83ff7d994be5342caa")
(setf (get planner_msgs::planner_set_planning_modeResponse :datatype-) "planner_msgs/planner_set_planning_modeResponse")
(setf (get planner_msgs::planner_set_planning_modeResponse :definition-)
      "# Set the planning mode of the robot to use in planner.
int32 kManual = 0
int32 kAuto = 1
# Can only be used with one of above values. Check Params/BoundModeType for more details.
int32 planning_mode

---

bool success
")



(provide :planner_msgs/planner_set_planning_mode "f5c508faaff06b83ff7d994be5342caa")


