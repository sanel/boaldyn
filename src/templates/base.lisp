;;
;; This file is a part of boaldyn project.
;; Copyright (c) 2013 Sanel Zukan (karijes@users.sourceforge.net)
;;

(in-package :boaldyn)

(defvar *top-menu* '(("Dashboard"     "/"       :dashboard)
					 ("Recent Builds" "/recent" :recent)
					 ("Build Slaves"  "/slaves" :slaves)
					 ("About"         "/about"  :about)))

(defun gen-topbar (selected)
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (with-html-output-to-string (*standard-output* nil :indent t)
    (loop :for item :in *top-menu*
		  :do (htm 
			   (:li :class (if (equalp selected (caddr item))
							 "active")
				 (:a :href (cadr item) (fmt (car item))))))))

(defmacro with-standard-page (title selected &body body)
  "Generates master page bone. Given title will be used as part of main
title content and 'selected' should be an id from *top-menu*, so generator knows
which list item to select."
  `(with-html-output-to-string (*standard-output* nil :prologue t :indent t)
    "<!DOCTYPE html>"
	(:html
	  (:head
	    (:title (fmt "~A - Boaldyn CI" ,title))
		(:meta :name "viewport" :content "width=device-width, initial-scale=1.0")
		(:link :href "/media/css/bootstrap.min.css" :rel "stylesheet" :media "screen"))
	  (:body
	    (:div :class "container"
		  (:div :class "masthead"
		    (:h3 :class "muted" "Boaldyn CI server")
			(:div :class "navbar" 
			  (:div :class "navbar-inner"
			    (:div :class "container"
				  (:ul :class "nav"
					,(gen-topbar selected) )))))
		,@body)  
	   (:br)
	   (:footer :class "footer"
		 (:div :class "container"
		   (:p :class "text-center muted"
			 (:small (fmt "Boaldyn CI server v~A" (boaldyn-version)))
			 (:br)
			 (:small (fmt "Licensed under ~A license." (boaldyn-license)))
			 (:small "&copy; Sanel Zukan 2013"))))
	   (:script :src "/media/js/jquery.min.js")
	   (:script :src "/media/js/jquery.peity.min.js")
	   (:script :src "/media/js/bootstrap.min.js")
	   (:script "$(\"span.pie\").peity(\"pie\")") ))))
