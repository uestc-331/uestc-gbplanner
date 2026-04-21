;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::pci_stop)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'pci_stop (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PCI_STOP")
  (make-package "PLANNER_MSGS::PCI_STOP"))
(unless (find-package "PLANNER_MSGS::PCI_STOPREQUEST")
  (make-package "PLANNER_MSGS::PCI_STOPREQUEST"))
(unless (find-package "PLANNER_MSGS::PCI_STOPRESPONSE")
  (make-package "PLANNER_MSGS::PCI_STOPRESPONSE"))

(in-package "ROS")





(defclass planner_msgs::pci_stopRequest
  :super ros::object
  :slots ())

(defmethod planner_msgs::pci_stopRequest
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

(defclass planner_msgs::pci_stopResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::pci_stopResponse
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

(defclass planner_msgs::pci_stop
  :super ros::object
  :slots ())

(setf (get planner_msgs::pci_stop :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get planner_msgs::pci_stop :datatype-) "planner_msgs/pci_stop")
(setf (get planner_msgs::pci_stop :request) planner_msgs::pci_stopRequest)
(setf (get planner_msgs::pci_stop :response) planner_msgs::pci_stopResponse)

(defmethod planner_msgs::pci_stopRequest
  (:response () (instance planner_msgs::pci_stopResponse :init)))

(setf (get planner_msgs::pci_stopRequest :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get planner_msgs::pci_stopRequest :datatype-) "planner_msgs/pci_stopRequest")
(setf (get planner_msgs::pci_stopRequest :definition-)
      "---
bool success

")

(setf (get planner_msgs::pci_stopResponse :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get planner_msgs::pci_stopResponse :datatype-) "planner_msgs/pci_stopResponse")
(setf (get planner_msgs::pci_stopResponse :definition-)
      "---
bool success

")



(provide :planner_msgs/pci_stop "358e233cde0c8a8bcfea4ce193f8fc15")


