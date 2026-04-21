;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_string_trigger)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_string_trigger (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_STRING_TRIGGER")
  (make-package "PLANNER_MSGS::PLANNER_STRING_TRIGGER"))
(unless (find-package "PLANNER_MSGS::PLANNER_STRING_TRIGGERREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_STRING_TRIGGERREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_STRING_TRIGGERRESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_STRING_TRIGGERRESPONSE"))

(in-package "ROS")





(defclass planner_msgs::planner_string_triggerRequest
  :super ros::object
  :slots (_message ))

(defmethod planner_msgs::planner_string_triggerRequest
  (:init
   (&key
    ((:message __message) "")
    )
   (send-super :init)
   (setq _message (string __message))
   self)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass planner_msgs::planner_string_triggerResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::planner_string_triggerResponse
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

(defclass planner_msgs::planner_string_trigger
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_string_trigger :md5sum-) "8b7095eb8dcd517ba7c37a0a06dcc50b")
(setf (get planner_msgs::planner_string_trigger :datatype-) "planner_msgs/planner_string_trigger")
(setf (get planner_msgs::planner_string_trigger :request) planner_msgs::planner_string_triggerRequest)
(setf (get planner_msgs::planner_string_trigger :response) planner_msgs::planner_string_triggerResponse)

(defmethod planner_msgs::planner_string_triggerRequest
  (:response () (instance planner_msgs::planner_string_triggerResponse :init)))

(setf (get planner_msgs::planner_string_triggerRequest :md5sum-) "8b7095eb8dcd517ba7c37a0a06dcc50b")
(setf (get planner_msgs::planner_string_triggerRequest :datatype-) "planner_msgs/planner_string_triggerRequest")
(setf (get planner_msgs::planner_string_triggerRequest :definition-)
      "string message
---
bool success
")

(setf (get planner_msgs::planner_string_triggerResponse :md5sum-) "8b7095eb8dcd517ba7c37a0a06dcc50b")
(setf (get planner_msgs::planner_string_triggerResponse :datatype-) "planner_msgs/planner_string_triggerResponse")
(setf (get planner_msgs::planner_string_triggerResponse :definition-)
      "string message
---
bool success
")



(provide :planner_msgs/planner_string_trigger "8b7095eb8dcd517ba7c37a0a06dcc50b")


