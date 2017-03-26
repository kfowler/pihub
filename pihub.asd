(in-package :cl-user)
(defpackage pihub-asd
  (:use :cl :asdf))
(in-package :pihub-asd)

(defsystem pihub
  :version "0.1"
  :author "Kevin Fowler"
  :license "MIT"
  :homepage "https://github.com/kfowler/pihub"
  :depends-on (:ningle
               :lack-middleware-session
               :hermetic
               :cl-markup
               :cl-mustache
               :spinneret
               :clsql
               :clsql-sqlite3)
  :components ((:module "src"
                :components
                ((:file "pihub"))))
  :description "See the danger\nAlways danger\nEndless talking\nLife rebuilding\nDon't walk away."
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.md"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (load-op hermetic-test))))
