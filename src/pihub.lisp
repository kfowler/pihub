;;
;;
;;
(defpackage pihub
  (:use :cl)
  (:import-from :cl-markup
                :html5)
  (:import-from :ningle
                :*session*)
  (:import-from :lack.builder
                :builder)
  (:import-from :lack.middleware.session)
  (:import-from :hermetic
                :setup
                :login
                :logged-in-p
                :user-name
                :logout
                :auth)
  (:use :spinneret)
  (:export :stop))

(in-package pihub)

(defvar *app* (make-instance 'ningle:<app>))

;;
;;
;;

(defmacro with-layout ((&key title) &body body)
  `(with-html-string
       (:doctype)
     (:html
      (:head
       (:title ,title))
      (:body ,@body))))

;;
;;
;;
(setf (ningle:route *app* "/")
      (lambda (params)
        (with-layout (:title "PiHub")
          (:p "This is PiHub."))))

;;
;;

(defparameter *handler*
  (clack:clackup (builder :session  *app*) :port 2512))

(defun stop () (clack:stop *handler*))
