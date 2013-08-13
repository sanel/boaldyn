;;
;; This file is a part of boaldyn project.
;; Copyright (c) 2013 Sanel Zukan (karijes@users.sourceforge.net)
;;

(in-package :boaldyn)

(defun i18n-reader (stream char)
  "Intended for underscore reader (like _\"sample\") for marking strings as targets
for future internationalization."
  (declare (ignore char stream))
  (list 'cl:string (read stream t nil t)))

(set-macro-character #\_ #'i18n-reader)

(defmacro html (&body body)
  "A macro to make generating html convenient."
  (let ((sym (gensym)))
	`(with-html-output-to-string (,sym)
       ,@body)))								 

(defun boaldyn-version ()
  "Return version number defined inside boaldyn.asd."
  (asdf:component-version (asdf:find-system :boaldyn)))

(defun boaldyn-license ()
  "Return license defined inside boaldyn.asd."
  (asdf:system-license (asdf:find-system :boaldyn)))

(defun boaldyn-memusage ()
  "Return current memory usage."
  (with-output-to-string (*standard-output*)
    (room)))

(defmacro -> (x form &body body)
  "Clojure thread macro."
  (if (consp body)
    `(-> (-> ,x ,form) ,@body)
	(if (listp form)
	  `(,(car form) ,x ,@(cdr form))
	  (list form x))))

(defmacro ->> (x form &body body)
  "Clojure thread macro."
  (if (consp body)
    `(->> (->> ,x ,form) ,@body)
	(if (listp form)
	  `(,(car form) ,@(cdr form) ,x)
	  (list form x))))
