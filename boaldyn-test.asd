#|
  This file is a part of boaldyn project.
  Copyright (c) 2013 Sanel Zukan (karijes@users.sourceforge.net)
|#

(in-package :cl-user)
(defpackage boaldyn-test-asd
  (:use :cl :asdf))
(in-package :boaldyn-test-asd)

(defsystem boaldyn-test
  :author "Sanel Zukan"
  :license "MIT"
  :depends-on (:boaldyn
               :cl-test-more)
  :components ((:module "t"
                :components
                ((:file "boaldyn"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
