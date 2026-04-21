;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_global)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_global (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_GLOBAL")
  (make-package "PLANNER_MSGS::PLANNER_GLOBAL"))
(unless (find-package "PLANNER_MSGS::PLANNER_GLOBALREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_GLOBALREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_GLOBALRESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_GLOBALRESPONSE"))

(in-package "ROS")



(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass planner_msgs::planner_globalRequest
  :super ros::object
  :slots (_id _not_check_frontier _ignore_time ))

(defmethod planner_msgs::planner_globalRequest
  (:init
   (&key
    ((:id __id) 0)
    ((:not_check_frontier __not_check_frontier) nil)
    ((:ignore_time __ignore_time) nil)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _not_check_frontier __not_check_frontier)
   (setq _ignore_time __ignore_time)
   self)
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
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _not_check_frontier
     (setq _not_check_frontier (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _ignore_time
     (setq _ignore_time (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass planner_msgs::planner_globalResponse
  :super ros::object
  :slots (_path ))

(defmethod planner_msgs::planner_globalResponse
  (:init
   (&key
    ((:path __path) ())
    )
   (send-super :init)
   (setq _path __path)
   self)
  (:path
   (&rest __path)
   (if (keywordp (car __path))
       (send* _path __path)
     (progn
       (if __path (setq _path (car __path)))
       _path)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose[] _path
    (apply #'+ (send-all _path :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose[] _path
     (write-long (length _path) s)
     (dolist (elem _path)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose[] _path
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _path (let (r) (dotimes (i n) (push (instance geometry_msgs::Pose :init) r)) r))
     (dolist (elem- _path)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass planner_msgs::planner_global
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_global :md5sum-) "3275d6e0291e4113fe8f0b4224d6de5a")
(setf (get planner_msgs::planner_global :datatype-) "planner_msgs/planner_global")
(setf (get planner_msgs::planner_global :request) planner_msgs::planner_globalRequest)
(setf (get planner_msgs::planner_global :response) planner_msgs::planner_globalResponse)

(defmethod planner_msgs::planner_globalRequest
  (:response () (instance planner_msgs::planner_globalResponse :init)))

(setf (get planner_msgs::planner_globalRequest :md5sum-) "3275d6e0291e4113fe8f0b4224d6de5a")
(setf (get planner_msgs::planner_globalRequest :datatype-) "planner_msgs/planner_globalRequest")
(setf (get planner_msgs::planner_globalRequest :definition-)
      "# Request the planner to run and return a path
# Since the global planner solution is almost deterministic,
# we could choose which frontier (using its id) from the best one to execute.
# By default, id 0 means selecting the best one.
int32 id
# Don't check for frontier properties (e.g. leaf vertex, gain, ...)
# This could be used to find a path to any vertex in the graph
bool not_check_frontier
# Force the planner to provide the path regardless the time budget.
bool ignore_time
---
# Return best path.
geometry_msgs/Pose[] path

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
")

(setf (get planner_msgs::planner_globalResponse :md5sum-) "3275d6e0291e4113fe8f0b4224d6de5a")
(setf (get planner_msgs::planner_globalResponse :datatype-) "planner_msgs/planner_globalResponse")
(setf (get planner_msgs::planner_globalResponse :definition-)
      "# Request the planner to run and return a path
# Since the global planner solution is almost deterministic,
# we could choose which frontier (using its id) from the best one to execute.
# By default, id 0 means selecting the best one.
int32 id
# Don't check for frontier properties (e.g. leaf vertex, gain, ...)
# This could be used to find a path to any vertex in the graph
bool not_check_frontier
# Force the planner to provide the path regardless the time budget.
bool ignore_time
---
# Return best path.
geometry_msgs/Pose[] path

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
")



(provide :planner_msgs/planner_global "3275d6e0291e4113fe8f0b4224d6de5a")


