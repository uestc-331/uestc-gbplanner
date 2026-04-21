;; Auto-generated. Do not edit!


(when (boundp 'quadrotor_msgs::SetTakeoffLand)
  (if (not (find-package "QUADROTOR_MSGS"))
    (make-package "QUADROTOR_MSGS"))
  (shadow 'SetTakeoffLand (find-package "QUADROTOR_MSGS")))
(unless (find-package "QUADROTOR_MSGS::SETTAKEOFFLAND")
  (make-package "QUADROTOR_MSGS::SETTAKEOFFLAND"))
(unless (find-package "QUADROTOR_MSGS::SETTAKEOFFLANDREQUEST")
  (make-package "QUADROTOR_MSGS::SETTAKEOFFLANDREQUEST"))
(unless (find-package "QUADROTOR_MSGS::SETTAKEOFFLANDRESPONSE")
  (make-package "QUADROTOR_MSGS::SETTAKEOFFLANDRESPONSE"))

(in-package "ROS")





(defclass quadrotor_msgs::SetTakeoffLandRequest
  :super ros::object
  :slots (_takeoff _takeoff_altitude ))

(defmethod quadrotor_msgs::SetTakeoffLandRequest
  (:init
   (&key
    ((:takeoff __takeoff) nil)
    ((:takeoff_altitude __takeoff_altitude) 0.0)
    )
   (send-super :init)
   (setq _takeoff __takeoff)
   (setq _takeoff_altitude (float __takeoff_altitude))
   self)
  (:takeoff
   (&optional (__takeoff :null))
   (if (not (eq __takeoff :null)) (setq _takeoff __takeoff)) _takeoff)
  (:takeoff_altitude
   (&optional __takeoff_altitude)
   (if __takeoff_altitude (setq _takeoff_altitude __takeoff_altitude)) _takeoff_altitude)
  (:serialization-length
   ()
   (+
    ;; bool _takeoff
    1
    ;; float32 _takeoff_altitude
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _takeoff
       (if _takeoff (write-byte -1 s) (write-byte 0 s))
     ;; float32 _takeoff_altitude
       (sys::poke _takeoff_altitude (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _takeoff
     (setq _takeoff (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _takeoff_altitude
     (setq _takeoff_altitude (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass quadrotor_msgs::SetTakeoffLandResponse
  :super ros::object
  :slots (_res ))

(defmethod quadrotor_msgs::SetTakeoffLandResponse
  (:init
   (&key
    ((:res __res) nil)
    )
   (send-super :init)
   (setq _res __res)
   self)
  (:res
   (&optional (__res :null))
   (if (not (eq __res :null)) (setq _res __res)) _res)
  (:serialization-length
   ()
   (+
    ;; bool _res
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _res
       (if _res (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _res
     (setq _res (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass quadrotor_msgs::SetTakeoffLand
  :super ros::object
  :slots ())

(setf (get quadrotor_msgs::SetTakeoffLand :md5sum-) "34300860f54be45144752987f014ec7e")
(setf (get quadrotor_msgs::SetTakeoffLand :datatype-) "quadrotor_msgs/SetTakeoffLand")
(setf (get quadrotor_msgs::SetTakeoffLand :request) quadrotor_msgs::SetTakeoffLandRequest)
(setf (get quadrotor_msgs::SetTakeoffLand :response) quadrotor_msgs::SetTakeoffLandResponse)

(defmethod quadrotor_msgs::SetTakeoffLandRequest
  (:response () (instance quadrotor_msgs::SetTakeoffLandResponse :init)))

(setf (get quadrotor_msgs::SetTakeoffLandRequest :md5sum-) "34300860f54be45144752987f014ec7e")
(setf (get quadrotor_msgs::SetTakeoffLandRequest :datatype-) "quadrotor_msgs/SetTakeoffLandRequest")
(setf (get quadrotor_msgs::SetTakeoffLandRequest :definition-)
      "bool takeoff 
float32 takeoff_altitude
---
bool res
")

(setf (get quadrotor_msgs::SetTakeoffLandResponse :md5sum-) "34300860f54be45144752987f014ec7e")
(setf (get quadrotor_msgs::SetTakeoffLandResponse :datatype-) "quadrotor_msgs/SetTakeoffLandResponse")
(setf (get quadrotor_msgs::SetTakeoffLandResponse :definition-)
      "bool takeoff 
float32 takeoff_altitude
---
bool res
")



(provide :quadrotor_msgs/SetTakeoffLand "34300860f54be45144752987f014ec7e")


