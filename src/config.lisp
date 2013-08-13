;;
;; This file is a part of boaldyn project.
;; Copyright (c) 2013 Sanel Zukan (karijes@users.sourceforge.net)
;;

;;; config tokens are put in separate package
(in-package :cl-user)
(defpackage :boaldyn-config
  (:use :cl)
  (:export :version
		   :steps
		   :defprocess))

(in-package :boaldyn-config)

(defun version (n)
  "Check configuration file version. In future, depending on different versions
we could apply different strategies."
  (if (> n 0.1)
	(error "For now only 0.1 version is supported")))

(defmacro defprocess (name (&key description) &body body)
  `(progn
	 (print ',name)
	 (print ,description)
	 ,@body))

(in-package :boaldyn)

(defun read-config (file)
  "Read configuration from file. Boaldyn standard configuration is in
sexp form (lisp code)."
  ;; TODO: any better way to do this???
  (in-package :boaldyn-config)
  (load file)
  (in-package :boaldyn)
  t)
