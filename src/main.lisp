;;
;; This file is a part of boaldyn project.
;; Copyright (c) 2013 Sanel Zukan (karijes@users.sourceforge.net)
;;

(in-package :boaldyn)

;;; some globals

(defvar *app*     (make-instance 'ningle:<app>))
(defvar *server*  nil)
(defvar *app-url* "http://github.com/sanel/boaldyn")

(defmacro route (path method &rest body)
  `(setf (ningle:route *app* ,path :method ,method) ,@body))

;;; web routes

;; default route with
(route "*" :GET
  #'(lambda (params)
	  (declare (ignore params))
	  (setf (clack.response:headers ningle:*response* :content-type) "text/html")
	  (or (ningle:next-route)
		  #p"html/404.html")))

(route "/" :GET
  (with-standard-page "Dashboard" :dashboard
    (:table :class "table"
	  (:thead
	    (:tr
		  (:th "Build id")
		  (:th "Name")
		  (:th "Description")
		  (:th "Status")
		  (:th "Completion")))
	  (:tbody
	    (:tr
		  (:td (:a :href "/id/132" "#132"))
		  (:td (:a :href "#" "edelib x86"))
		  (:td "edelib on x86 platform")
		  (:td (:span :class "label" "Idle"))
		  (:td "-"))
		(:tr
		  (:td (:a :href "/id/2" "#2"))
		  (:td (:a :href "#" "edelib x86_64"))
		  (:td "edelib on x86 platform")
		  (:td 
		   (:span :class "label label-warning" "Running")
		   (:img :src "/media/img/spin.gif" :alt ""))
		  (:td (:span :class "pie" "60/100")))
		(:tr
		  (:td "n/a")
		  (:td (:a :href "#" "edelib x86_64 Fedora"))
		  (:td "edelib on x86 platform")
		  (:td (:span :class "label label-important" "Failed"))
		  (:td "-"))
		(:tr
		  (:td (:a :href "/id/5" "#5"))
		  (:td (:a :href "#" "edelib SPARC"))
		  (:td "edelib on SPARC platform")
		  (:td
		   (:span :class "label label-warning" "Running")
		   (:img :src "/media/img/spin.gif" :alt ""))
		  (:td (:span :class "pie" "10/100")))))))

(route "/recent" :GET
  (with-standard-page "Recent Builds" :recent
    (:b "TODO")))

(route "/slaves" :GET
  (with-standard-page "Build Slaves" :slaves
    (:table :class "table"
	  (:thead
	    (:tr
		  (:th "Name")
		  (:th "Client version")
		  (:th "Last heard from")
		  (:th "Status")))
	  (:tbody
	    (:tr
		  (:td (:a :href "/slaves/machine_1" "Machine #1"))
		  (:td "0.1")
		  (:td "about 3 minutes ago (2013-Jun-25 02:59:01)")
		  (:td "Idle"))
	    (:tr
		  (:td (:a :href "/slaves/machine_1" "Machine #2"))
		  (:td "0.1")
		  (:td "2 days ago")
		  (:td :style "background: #b94a48; foreground: #ffffff;" "Not connected"))
	    (:tr
		  (:td (:a :href "#" "Machine #3"))
		  (:td "0.1")
		  (:td "1 hour ago (2013-Jun-25 02:59:01)")
		  (:td :style "background: #f89406;" "Running 1 build"))))))

(route "/slaves/:name" :GET
  #'(lambda (params)
	  (let ((slave (getf params :name)))
		(with-standard-page slave :slaves
		  (:p "bla")))))

(route "/about" :GET
  (with-standard-page "About" :about
    (:h4 "Version Information")
	(:ul
	  (:li (fmt "Boaldyn: ~A" (boaldyn-version)))
	  (:li (fmt "Running on: ~A ~A" (lisp-implementation-type) (lisp-implementation-version)))
	  (:li (fmt "Master on: ~A ~A" (software-type) (software-version))))
	(:h4 "Memory usage")
	(:pre (fmt (boaldyn-memusage)))
	(:p (fmt "This program is free software project, released under ~A license." (boaldyn-license)))
	(:p "Please visit "
		(:a :href *app-url* (fmt *app-url*))
		" for more information, documentation and bug reports.")))

;(route "/hello/:user" :GET
;  #'(lambda (params)
;	  (format nil "---> ~A" (getf params :user))))

;;; TODO: client api

;;; server related code

(defun server-start ()
  "Start server at localhost:5000."
  (setf *server* (clack:clackup 
				   (clack.builder:builder
					 (clack.middleware.static:<clack-middleware-static>
					   :path   "/media/"
					   :root #p"media/")
					 *app*))))

(defun server-stop ()
  "Stop server."
  (clack:stop *server*))

(defun server-restart ()
  (server-stop)
  (server-start))
