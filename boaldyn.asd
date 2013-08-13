;;
;; This file is a part of boaldyn project.
;; Copyright (c) 2013 Sanel Zukan (karijes@users.sourceforge.net)
;;

(asdf:defsystem #:boaldyn
  :version "0.1"
  :author "Sanel Zukan"
  :license "MIT"
  :depends-on (:ningle :cl-who)
  :description "Continuous Integration Server"
  :components ((:module src
				:serial t
                :components ((:file "package")
							 (:file "helpers")
							 (:module templates
							  :serial t
							  :components ((:file "base")))
							 (:file "main")))))

