;; Auto-generated. Do not edit!


(when (boundp 'planner_semantic_msgs::SemanticClass)
  (if (not (find-package "PLANNER_SEMANTIC_MSGS"))
    (make-package "PLANNER_SEMANTIC_MSGS"))
  (shadow 'SemanticClass (find-package "PLANNER_SEMANTIC_MSGS")))
(unless (find-package "PLANNER_SEMANTIC_MSGS::SEMANTICCLASS")
  (make-package "PLANNER_SEMANTIC_MSGS::SEMANTICCLASS"))

(in-package "ROS")
;;//! \htmlinclude SemanticClass.msg.html


(intern "*KNONE*" (find-package "PLANNER_SEMANTIC_MSGS::SEMANTICCLASS"))
(shadow '*KNONE* (find-package "PLANNER_SEMANTIC_MSGS::SEMANTICCLASS"))
(defconstant planner_semantic_msgs::SemanticClass::*KNONE* 0)
(intern "*KSTAIRCASE*" (find-package "PLANNER_SEMANTIC_MSGS::SEMANTICCLASS"))
(shadow '*KSTAIRCASE* (find-package "PLANNER_SEMANTIC_MSGS::SEMANTICCLASS"))
(defconstant planner_semantic_msgs::SemanticClass::*KSTAIRCASE* 1)
(intern "*KDOOR*" (find-package "PLANNER_SEMANTIC_MSGS::SEMANTICCLASS"))
(shadow '*KDOOR* (find-package "PLANNER_SEMANTIC_MSGS::SEMANTICCLASS"))
(defconstant planner_semantic_msgs::SemanticClass::*KDOOR* 2)

(defun planner_semantic_msgs::SemanticClass-to-symbol (const)
  (cond
        ((= const 0) 'planner_semantic_msgs::SemanticClass::*kNone*)
        ((= const 1) 'planner_semantic_msgs::SemanticClass::*kStaircase*)
        ((= const 2) 'planner_semantic_msgs::SemanticClass::*kDoor*)
        (t nil)))

(defclass planner_semantic_msgs::SemanticClass
  :super ros::object
  :slots (_value ))

(defmethod planner_semantic_msgs::SemanticClass
  (:init
   (&key
    ((:value __value) 0)
    )
   (send-super :init)
   (setq _value (round __value))
   self)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; int32 _value
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _value
       (write-long _value s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _value
     (setq _value (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get planner_semantic_msgs::SemanticClass :md5sum-) "9ed3cb55cfdae37517f1354dd57dbaba")
(setf (get planner_semantic_msgs::SemanticClass :datatype-) "planner_semantic_msgs/SemanticClass")
(setf (get planner_semantic_msgs::SemanticClass :definition-)
      "# Semantic classes
int32 kNone = 0
int32 kStaircase = 1
int32 kDoor = 2

# Can only choose one of the above
int32 value

")



(provide :planner_semantic_msgs/SemanticClass "9ed3cb55cfdae37517f1354dd57dbaba")


