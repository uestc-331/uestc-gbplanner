;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::pci_global)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'pci_global (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PCI_GLOBAL")
  (make-package "PLANNER_MSGS::PCI_GLOBAL"))
(unless (find-package "PLANNER_MSGS::PCI_GLOBALREQUEST")
  (make-package "PLANNER_MSGS::PCI_GLOBALREQUEST"))
(unless (find-package "PLANNER_MSGS::PCI_GLOBALRESPONSE")
  (make-package "PLANNER_MSGS::PCI_GLOBALRESPONSE"))

(in-package "ROS")





(defclass planner_msgs::pci_globalRequest
  :super ros::object
  :slots (_not_exe_path _set_auto _bound_mode _vel_max _id _not_check_frontier _ignore_time ))

(defmethod planner_msgs::pci_globalRequest
  (:init
   (&key
    ((:not_exe_path __not_exe_path) nil)
    ((:set_auto __set_auto) nil)
    ((:bound_mode __bound_mode) 0)
    ((:vel_max __vel_max) 0.0)
    ((:id __id) 0)
    ((:not_check_frontier __not_check_frontier) nil)
    ((:ignore_time __ignore_time) nil)
    )
   (send-super :init)
   (setq _not_exe_path __not_exe_path)
   (setq _set_auto __set_auto)
   (setq _bound_mode (round __bound_mode))
   (setq _vel_max (float __vel_max))
   (setq _id (round __id))
   (setq _not_check_frontier __not_check_frontier)
   (setq _ignore_time __ignore_time)
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
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:not_check_frontier
   (&optional (__not_check_frontier :null))
   (if (not (eq __not_check_frontier :null)) (setq _not_check_frontier __not_check_frontier)) _not_check_frontier)
  (:ignore_time
   (&optional (__ignore_time :null))
   (if (not (eq __ignore_time :null)) (setq _ignore_time __ignore_time)) _ignore_time)
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
    ;; int32 _id
    4
    ;; bool _not_check_frontier
    1
    ;; bool _ignore_time
    1
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
     ;; int32 _id
       (write-long _id s)
     ;; bool _not_check_frontier
       (if _not_check_frontier (write-byte -1 s) (write-byte 0 s))
     ;; bool _ignore_time
       (if _ignore_time (write-byte -1 s) (write-byte 0 s))
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
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _not_check_frontier
     (setq _not_check_frontier (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _ignore_time
     (setq _ignore_time (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass planner_msgs::pci_globalResponse
  :super ros::object
  :slots (_success ))

(defmethod planner_msgs::pci_globalResponse
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

(defclass planner_msgs::pci_global
  :super ros::object
  :slots ())

(setf (get planner_msgs::pci_global :md5sum-) "b813db86654aa005e1e7d2d2ea812561")
(setf (get planner_msgs::pci_global :datatype-) "planner_msgs/pci_global")
(setf (get planner_msgs::pci_global :request) planner_msgs::pci_globalRequest)
(setf (get planner_msgs::pci_global :response) planner_msgs::pci_globalResponse)

(defmethod planner_msgs::pci_globalRequest
  (:response () (instance planner_msgs::pci_globalResponse :init)))

(setf (get planner_msgs::pci_globalRequest :md5sum-) "b813db86654aa005e1e7d2d2ea812561")
(setf (get planner_msgs::pci_globalRequest :datatype-) "planner_msgs/pci_globalRequest")
(setf (get planner_msgs::pci_globalRequest :definition-)
      "# Request the planning through the planner control interface node.

## Params for planner-control-interface
# Set not_exe_path to true if don't want the robot to execute the path.
bool not_exe_path
# Set set_auto to true to change to auto mode and vice versa.
bool set_auto
uint8 bound_mode
# Max velocity allowed.
float32 vel_max

## Params for planner
# id of the frontier:
# --> default is 0: auto-select the best frontier.
# --> other than 0: manual select with feasibility check.
int32 id
# Don't check for frontier properties (e.g. leaf vertex, gain, ...).
# This could be used to find a path to any vertex in the graph.
bool not_check_frontier
# Force the planner to provide the path regardless the time budget.
bool ignore_time
---
bool success
")

(setf (get planner_msgs::pci_globalResponse :md5sum-) "b813db86654aa005e1e7d2d2ea812561")
(setf (get planner_msgs::pci_globalResponse :datatype-) "planner_msgs/pci_globalResponse")
(setf (get planner_msgs::pci_globalResponse :definition-)
      "# Request the planning through the planner control interface node.

## Params for planner-control-interface
# Set not_exe_path to true if don't want the robot to execute the path.
bool not_exe_path
# Set set_auto to true to change to auto mode and vice versa.
bool set_auto
uint8 bound_mode
# Max velocity allowed.
float32 vel_max

## Params for planner
# id of the frontier:
# --> default is 0: auto-select the best frontier.
# --> other than 0: manual select with feasibility check.
int32 id
# Don't check for frontier properties (e.g. leaf vertex, gain, ...).
# This could be used to find a path to any vertex in the graph.
bool not_check_frontier
# Force the planner to provide the path regardless the time budget.
bool ignore_time
---
bool success
")



(provide :planner_msgs/pci_global "b813db86654aa005e1e7d2d2ea812561")


