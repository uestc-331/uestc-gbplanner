;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::pci_initialization)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'pci_initialization (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PCI_INITIALIZATION")
  (make-package "PLANNER_MSGS::PCI_INITIALIZATION"))
(unless (find-package "PLANNER_MSGS::PCI_INITIALIZATIONREQUEST")
  (make-package "PLANNER_MSGS::PCI_INITIALIZATIONREQUEST"))
(unless (find-package "PLANNER_MSGS::PCI_INITIALIZATIONRESPONSE")
  (make-package "PLANNER_MSGS::PCI_INITIALIZATIONRESPONSE"))

(in-package "ROS")





(defclass planner_msgs::pci_initializationRequest
  :super ros::object
  :slots ())

(defmethod planner_msgs::pci_initializationRequest
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

(defclass planner_msgs::pci_initializationResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::pci_initializationResponse
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

(defclass planner_msgs::pci_initialization
  :super ros::object
  :slots ())

(setf (get planner_msgs::pci_initialization :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get planner_msgs::pci_initialization :datatype-) "planner_msgs/pci_initialization")
(setf (get planner_msgs::pci_initialization :request) planner_msgs::pci_initializationRequest)
(setf (get planner_msgs::pci_initialization :response) planner_msgs::pci_initializationResponse)

(defmethod planner_msgs::pci_initializationRequest
  (:response () (instance planner_msgs::pci_initializationResponse :init)))

(setf (get planner_msgs::pci_initializationRequest :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get planner_msgs::pci_initializationRequest :datatype-) "planner_msgs/pci_initializationRequest")
(setf (get planner_msgs::pci_initializationRequest :definition-)
      "# Request the PCI perform initialization; for example, auto arm and take-off.
---
bool success

")

(setf (get planner_msgs::pci_initializationResponse :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get planner_msgs::pci_initializationResponse :datatype-) "planner_msgs/pci_initializationResponse")
(setf (get planner_msgs::pci_initializationResponse :definition-)
      "# Request the PCI perform initialization; for example, auto arm and take-off.
---
bool success

")



(provide :planner_msgs/pci_initialization "358e233cde0c8a8bcfea4ce193f8fc15")


