;;
;; This file is a part of boaldyn project.
;; Copyright (c) 2013 Sanel Zukan (karijes@users.sourceforge.net)
;;

(in-package :boaldyn)

;; This code is highly SBCL specific and is only implementation dependant. After reading
;; some Clozure examples (http://trac.clozure.com/ccl/attachment/ticket/993/lock-free-hash-table-test.lisp)
;; porting to Clozure should not be hard. For other implementation, things like Bordeaux Threads could be used.
(defvar *db* 
  #+sbcl (make-hash-table :synchronized t :size 1000 :rehash-size 1.25)
  #-sbcl (error "TODO: add (make-hash-table) specific to your CL implementation."))

(defvar *db-lock*
  #+sbcl (make-mutex :name "db lock")
  #-sbcl (error "(make-mutex) not implemented for your CL implementation."))

(defvar *db-id-counter-lock*
  #+sbcl (make-mutex :name "db lock counter")
  #-sbcl (error "(make-mutex) not implemented for your CL implementation."))

(defvar *db-id-counter* 0)

(defun db-insert (item)
  "Insert item inside database"
  (let ((id (with-mutex (*db-id-counter-lock*) (incf *db-id-counter-lock*))))
	(with-mutex (*db-lock*)
				)))
