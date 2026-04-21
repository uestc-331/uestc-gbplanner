
(cl:in-package :asdf)

(defsystem "planner_semantic_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "SemanticClass" :depends-on ("_package_SemanticClass"))
    (:file "_package_SemanticClass" :depends-on ("_package"))
    (:file "SemanticPoint" :depends-on ("_package_SemanticPoint"))
    (:file "_package_SemanticPoint" :depends-on ("_package"))
    (:file "SemanticPolygon" :depends-on ("_package_SemanticPolygon"))
    (:file "_package_SemanticPolygon" :depends-on ("_package"))
  ))