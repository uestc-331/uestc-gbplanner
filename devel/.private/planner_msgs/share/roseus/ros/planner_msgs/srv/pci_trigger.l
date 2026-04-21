;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::pci_trigger)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'pci_trigger (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PCI_TRIGGER")
  (make-package "PLANNER_MSGS::PCI_TRIGGER"))
(unless (find-package "PLANNER_MSGS::PCI_TRIGGERREQUEST")
  (make-package "PLANNER_MSGS::PCI_TRIGGERREQUEST"))
(unless (find-package "PLANNER_MSGS::PCI_TRIGGERRESPONSE")
  (make-package "PLANNER_MSGS::PCI_TRIGGERRESPONSE"))

(in-package "ROS")





(defclass planner_msgs::pci_triggerRequest
  :super ros::object
  :slots (_not_exe_path _set_auto _bound_mode _vel_max ))

(defmethod planner_msgs::pci_triggerRequest
  (:init
   (&key
    ((:not_exe_path __not_exe_path) nil)
    ((:set_auto __set_auto) nil)
    ((:bound_mode __bound_mode) 0)
    ((:vel_max __vel_max) 0.0)
    )
   (send-super :init)
   (setq _not_exe_path __not_exe_path)
   (setq _set_auto __set_auto)
   (setq _bound_mode (round __bound_mode))
   (setq _vel_max (float __vel_max))
   self)
  (:not_exe_path
   (&optional (__not_exe_path :null))
   (if (not (eq __not_exe_path :null)) (setq _not_exe_path __not_exe_path)) _not_exe_path)
  (:set_auto
   (&optional (__set_auto :null))
   (if (not (eq __set_auto :null)) (setq _set_auto __set_auto)) _set_auto)
  (:bound_mode
   (&optional __bound_mode)
   (if __bound_mode (setq _bound_mode __bound_mode)) _bound_mode)
  (:vel_max
   (&optional __vel_max)
   (if __vel_max (setq _vel_max __vel_max)) _vel_max)
  (:serialization-length
   ()
   (+
    ;; bool _not_exe_path
    1
    ;; bool _set_auto
    1
    ;; uint8 _bound_mode
    1
    ;; float32 _vel_max
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _not_exe_path
       (if _not_exe_path (write-byte -1 s) (write-byte 0 s))
     ;; bool _set_auto
       (if _set_auto (write-byte -1 s) (write-byte 0 s))
     ;; uint8 _bound_mode
       (write-byte _bound_mode s)
     ;; float32 _vel_max
       (sys::poke _vel_max (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _not_exe_path
     (setq _not_exe_path (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _set_auto
     (setq _set_auto (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint8 _bound_mode
     (setq _bound_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _vel_max
     (setq _vel_max (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass planner_msgs::pci_triggerResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::pci_triggerResponse
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

(defclass planner_msgs::pci_trigger
  :super ros::object
  :slots ())

(setf (get planner_msgs::pci_trigger :md5sum-) "0fd8cc9320dacbac91111ce9de934668")
(setf (get planner_msgs::pci_trigger :datatype-) "planner_msgs/pci_trigger")
(setf (get planner_msgs::pci_trigger :request) planner_msgs::pci_triggerRequest)
(setf (get planner_msgs::pci_trigger :response) planner_msgs::pci_triggerResponse)

(defmethod planner_msgs::pci_triggerRequest
  (:response () (instance planner_msgs::pci_triggerResponse :init)))

(setf (get planner_msgs::pci_triggerRequest :md5sum-) "0fd8cc9320dacbac91111ce9de934668")
(setf (get planner_msgs::pci_triggerRequest :datatype-) "planner_msgs/pci_triggerRequest")
(setf (get planner_msgs::pci_triggerRequest :definition-)
      "# Request the planning through the planner control interface node.

# Set not_exe_path to true if don't want the robot to execute the path.
bool not_exe_path
# Set set_auto to true to change to auto mode and vice versa.
bool set_auto
uint8 bound_mode

# Max velocity allowed.
float32 vel_max
---
bool success
")

(setf (get planner_msgs::pci_triggerResponse :md5sum-) "0fd8cc9320dacbac91111ce9de934668")
(setf (get planner_msgs::pci_triggerResponse :datatype-) "planner_msgs/pci_triggerResponse")
(setf (get planner_msgs::pci_triggerResponse :definition-)
      "# Request the planning through the planner control interface node.

# Set not_exe_path to true if don't want the robot to execute the path.
bool not_exe_path
# Set set_auto to true to change to auto mode and vice versa.
bool set_auto
uint8 bound_mode

# Max velocity allowed.
float32 vel_max
---
bool success
")



(provide :planner_msgs/pci_trigger "0fd8cc9320dacbac91111ce9de934668")


