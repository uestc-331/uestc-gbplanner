
(cl:in-package :asdf)

(defsystem "quadrotor_msgs-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "SetTakeoffLand" :depends-on ("_package_SetTakeoffLand"))
    (:file "_package_SetTakeoffLand" :depends-on ("_package"))
  ))