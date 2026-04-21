;; Auto-generated. Do not edit!


(when (boundp 'planner_msgs::planner_request_path)
  (if (not (find-package "PLANNER_MSGS"))
    (make-package "PLANNER_MSGS"))
  (shadow 'planner_request_path (find-package "PLANNER_MSGS")))
(unless (find-package "PLANNER_MSGS::PLANNER_REQUEST_PATH")
  (make-package "PLANNER_MSGS::PLANNER_REQUEST_PATH"))
(unless (find-package "PLANNER_MSGS::PLANNER_REQUEST_PATHREQUEST")
  (make-package "PLANNER_MSGS::PLANNER_REQUEST_PATHREQUEST"))
(unless (find-package "PLANNER_MSGS::PLANNER_REQUEST_PATHRESPONSE")
  (make-package "PLANNER_MSGS::PLANNER_REQUEST_PATHRESPONSE"))

(in-package "ROS")



(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass planner_msgs::planner_request_pathRequest
  :super ros::object
  :slots ())

(defmethod planner_msgs::planner_request_pathRequest
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

(defclass planner_msgs::planner_request_pathResponse
  :super ros::object
  :slots (_bound _path ))

(defmethod planner_msgs::planner_request_pathResponse
  (:init
   (&key
    ((:bound __bound) (instance planner_msgs::BoundMode :init))
    ((:path __path) ())
    )
   (send-super :init)
   (setq _bound __bound)
   (setq _path __path)
   self)
  (:bound
   (&rest __bound)
   (if (keywordp (car __bound))
       (send* _bound __bound)
     (progn
       (if __bound (setq _bound (car __bound)))
       _bound)))
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
    ;; planner_msgs/BoundMode _bound
    (send _bound :serialization-length)
    ;; geometry_msgs/Pose[] _path
    (apply #'+ (send-all _path :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; planner_msgs/BoundMode _bound
       (send _bound :serialize s)
     ;; geometry_msgs/Pose[] _path
     (write-long (length _path) s)
     (dolist (elem _path)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; planner_msgs/BoundMode _bound
     (send _bound :deserialize buf ptr-) (incf ptr- (send _bound :serialization-length))
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

(defclass planner_msgs::planner_request_path
  :super ros::object
  :slots ())

(setf (get planner_msgs::planner_request_path :md5sum-) "1dad867088c8c204d2077d3355d04150")
(setf (get planner_msgs::planner_request_path :datatype-) "planner_msgs/planner_request_path")
(setf (get planner_msgs::planner_request_path :request) planner_msgs::planner_request_pathRequest)
(setf (get planner_msgs::planner_request_path :response) planner_msgs::planner_request_pathResponse)

(defmethod planner_msgs::planner_request_pathRequest
  (:response () (instance planner_msgs::planner_request_pathResponse :init)))

(setf (get planner_msgs::planner_request_pathRequest :md5sum-) "1dad867088c8c204d2077d3355d04150")
(setf (get planner_msgs::planner_request_pathRequest :datatype-) "planner_msgs/planner_request_pathRequest")
(setf (get planner_msgs::planner_request_pathRequest :definition-)
      "# A generic service to request a path from gbplanner

---
# Return actual bound mode used in planner.
BoundMode bound

# Return path.
geometry_msgs/Pose[] path

================================================================================
MSG: planner_msgs/BoundMode
# Bound mode of the robot for collision checking, defined in Params/BoundModeType.
int32 kExtendedBound = 0
int32 kRelaxedBound = 1
int32 kMinBound = 2
int32 kExactBound = 3
int32 kNoBound = 4

# Set one of above values.
int32 mode
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

(setf (get planner_msgs::planner_request_pathResponse :md5sum-) "1dad867088c8c204d2077d3355d04150")
(setf (get planner_msgs::planner_request_pathResponse :datatype-) "planner_msgs/planner_request_pathResponse")
(setf (get planner_msgs::planner_request_pathResponse :definition-)
      "# A generic service to request a path from gbplanner

---
# Return actual bound mode used in planner.
BoundMode bound

# Return path.
geometry_msgs/Pose[] path

================================================================================
MSG: planner_msgs/BoundMode
# Bound mode of the robot for collision checking, defined in Params/BoundModeType.
int32 kExtendedBound = 0
int32 kRelaxedBound = 1
int32 kMinBound = 2
int32 kExactBound = 3
int32 kNoBound = 4

# Set one of above values.
int32 mode
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



(provide :planner_msgs/planner_request_path "1dad867088c8c204d2077d3355d04150")


