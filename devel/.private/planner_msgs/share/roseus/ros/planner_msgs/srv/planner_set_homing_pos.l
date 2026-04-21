;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_set_homing_pos)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_set_homing_pos (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_HOMING_POS")
  (make-package "PLANNER_MSGS::PLANNER_SET_HOMING_POS"))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_HOMING_POSREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_SET_HOMING_POSREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_SET_HOMING_POSRESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_SET_HOMING_POSRESPONSE"))

(in-package "ROS")





(defclass planner_msgs::planner_set_homing_posRequest
  :super ros::object
  :slots ())

(defmethod planner_msgs::planner_set_homing_posRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass planner_msgs::planner_set_homing_posResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::planner_set_homing_posResponse
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

(defclass planner_msgs::planner_set_homing_pos
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_set_homing_pos :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get planner_msgs::planner_set_homing_pos :datatype-) "planner_msgs/planner_set_homing_pos")
(setf (get planner_msgs::planner_set_homing_pos :request) planner_msgs::planner_set_homing_posRequest)
(setf (get planner_msgs::planner_set_homing_pos :response) planner_msgs::planner_set_homing_posResponse)

(defmethod planner_msgs::planner_set_homing_posRequest
  (:response () (instance planner_msgs::planner_set_homing_posResponse :init)))

(setf (get planner_msgs::planner_set_homing_posRequest :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get planner_msgs::planner_set_homing_posRequest :datatype-) "planner_msgs/planner_set_homing_posRequest")
(setf (get planner_msgs::planner_set_homing_posRequest :definition-)
      "# Set current position as homing position.
---
bool success

")

(setf (get planner_msgs::planner_set_homing_posResponse :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get planner_msgs::planner_set_homing_posResponse :datatype-) "planner_msgs/planner_set_homing_posResponse")
(setf (get planner_msgs::planner_set_homing_posResponse :definition-)
      "# Set current position as homing position.
---
bool success

")



(provide :planner_msgs/planner_set_homing_pos "358e233cde0c8a8bcfea4ce193f8fc15")


