;; Auto-generated. Do not edit!


(when (boundp 'planner_semantic_msgs::SemanticPolygon)
  (if (not (find-package "PLANNER_SEMANTIC_MSGS"))
    (make-package "PLANNER_SEMANTIC_MSGS"))
  (shadow 'SemanticPolygon (find-package "PLANNER_SEMANTIC_MSGS")))
(unless (find-package "PLANNER_SEMANTIC_MSGS::SEMANTICPOLYGON")
  (make-package "PLANNER_SEMANTIC_MSGS::SEMANTICPOLYGON"))

(in-package "ROS")
;;//! \htmlinclude SemanticPolygon.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass planner_semantic_msgs::SemanticPolygon
  :super ros::object
  :slots (_header _type _description _polygon ))

(defmethod planner_semantic_msgs::SemanticPolygon
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:type __type) (instance planner_semantic_msgs::SemanticClass :init))
    ((:description __description) (instance std_msgs::String :init))
    ((:polygon __polygon) (instance geometry_msgs::Polygon :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _type __type)
   (setq _description __description)
   (setq _polygon __polygon)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:type
   (&rest __type)
   (if (keywordp (car __type))
       (send* _type __type)
     (progn
       (if __type (setq _type (car __type)))
       _type)))
  (:description
   (&rest __description)
   (if (keywordp (car __description))
       (send* _description __description)
     (progn
       (if __description (setq _description (car __description)))
       _description)))
  (:polygon
   (&rest __polygon)
   (if (keywordp (car __polygon))
       (send* _polygon __polygon)
     (progn
       (if __polygon (setq _polygon (car __polygon)))
       _polygon)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; planner_semantic_msgs/SemanticClass _type
    (send _type :serialization-length)
    ;; std_msgs/String _description
    (send _description :serialization-length)
    ;; geometry_msgs/Polygon _polygon
    (send _polygon :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; planner_semantic_msgs/SemanticClass _type
       (send _type :serialize s)
     ;; std_msgs/String _description
       (send _description :serialize s)
     ;; geometry_msgs/Polygon _polygon
       (send _polygon :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; planner_semantic_msgs/SemanticClass _type
     (send _type :deserialize buf ptr-) (incf ptr- (send _type :serialization-length))
   ;; std_msgs/String _description
     (send _description :deserialize buf ptr-) (incf ptr- (send _description :serialization-length))
   ;; geometry_msgs/Polygon _polygon
     (send _polygon :deserialize buf ptr-) (incf ptr- (send _polygon :serialization-length))
   ;;
   self)
  )

(setf (get planner_semantic_msgs::SemanticPolygon :md5sum-) "3e757e567e8c954d178e7a622f70ad73")
(setf (get planner_semantic_msgs::SemanticPolygon :datatype-) "planner_semantic_msgs/SemanticPolygon")
(setf (get planner_semantic_msgs::SemanticPolygon :definition-)
      "# Represent semantics as a flat 3D polygon
std_msgs/Header header

# Class of semantics
planner_semantic_msgs/SemanticClass type

# Further info if needed
std_msgs/String description

# Coordinate of 4 corners of the polygon listed in clockwise direction
geometry_msgs/Polygon polygon
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: planner_semantic_msgs/SemanticClass
# Semantic classes
int32 kNone = 0
int32 kStaircase = 1
int32 kDoor = 2

# Can only choose one of the above
int32 value

================================================================================
MSG: std_msgs/String
string data

================================================================================
MSG: geometry_msgs/Polygon
#A specification of a polygon where the first and last points are assumed to be connected
Point32[] points

================================================================================
MSG: geometry_msgs/Point32
# This contains the position of a point in free space(with 32 bits of precision).
# It is recommeded to use Point wherever possible instead of Point32.  
# 
# This recommendation is to promote interoperability.  
#
# This message is designed to take up less space when sending
# lots of points at once, as in the case of a PointCloud.  

float32 x
float32 y
float32 z
")



(provide :planner_semantic_msgs/SemanticPolygon "3e757e567e8c954d178e7a622f70ad73")


