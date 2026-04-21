;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::pci_homing_trigger)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'pci_homing_trigger (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PCI_HOMING_TRIGGER")
  (make-package "PLANNER_MSGS::PCI_HOMING_TRIGGER"))
(unless (find-package "PLANNER_MSGS::PCI_HOMING_TRIGGERREQUEST")
  (make-package "PLANNER_MSGS::PCI_HOMING_TRIGGERREQUEST"))
(unless (find-package "PLANNER_MSGS::PCI_HOMING_TRIGGERRESPONSE")
  (make-package "PLANNER_MSGS::PCI_HOMING_TRIGGERRESPONSE"))

(in-package "ROS")





(defclass planner_msgs::pci_homing_triggerRequest
  :super ros::object
  :slots (_not_exe_path ))

(defmethod planner_msgs::pci_homing_triggerRequest
  (:init
   (&key
    ((:not_exe_path __not_exe_path) nil)
    )
   (send-super :init)
   (setq _not_exe_path __not_exe_path)
   self)
  (:not_exe_path
   (&optional (__not_exe_path :null))
   (if (not (eq __not_exe_path :null)) (setq _not_exe_path __not_exe_path)) _not_exe_path)
  (:serialization-length
   ()
   (+
    ;; bool _not_exe_path
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _not_exe_path
       (if _not_exe_path (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _not_exe_path
     (setq _not_exe_path (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass planner_msgs::pci_homing_triggerResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::pci_homing_triggerResponse
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

(defclass planner_msgs::pci_homing_trigger
  :super ros::object
  :slots ())

(setf (get planner_msgs::pci_homing_trigger :md5sum-) "9ac7156ead9cf693072fe52aad9e8e2c")
(setf (get planner_msgs::pci_homing_trigger :datatype-) "planner_msgs/pci_homing_trigger")
(setf (get planner_msgs::pci_homing_trigger :request) planner_msgs::pci_homing_triggerRequest)
(setf (get planner_msgs::pci_homing_trigger :response) planner_msgs::pci_homing_triggerResponse)

(defmethod planner_msgs::pci_homing_triggerRequest
  (:response () (instance planner_msgs::pci_homing_triggerResponse :init)))

(setf (get planner_msgs::pci_homing_triggerRequest :md5sum-) "9ac7156ead9cf693072fe52aad9e8e2c")
(setf (get planner_msgs::pci_homing_triggerRequest :datatype-) "planner_msgs/pci_homing_triggerRequest")
(setf (get planner_msgs::pci_homing_triggerRequest :definition-)
      "# Request the planner control interface to guide the robot go home.
# Set true if don't want to execute path.
bool not_exe_path
---
bool success

")

(setf (get planner_msgs::pci_homing_triggerResponse :md5sum-) "9ac7156ead9cf693072fe52aad9e8e2c")
(setf (get planner_msgs::pci_homing_triggerResponse :datatype-) "planner_msgs/pci_homing_triggerResponse")
(setf (get planner_msgs::pci_homing_triggerResponse :definition-)
      "# Request the planner control interface to guide the robot go home.
# Set true if don't want to execute path.
bool not_exe_path
---
bool success

")



(provide :planner_msgs/pci_homing_trigger "9ac7156ead9cf693072fe52aad9e8e2c")


