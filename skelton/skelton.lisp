(ql:quickload :ps-experiment)

(in-package :cl-user)
(defpackage <% @var name %>
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main
           *dependencies*))
(in-package :<% @var name %>)


(defvar *dependencies* '()
  "Write dependent libralies of Node.js as string list")

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    ))
