(ql:quickload :ps-experiment)

(in-package :cl-user)
(defpackage <% @var name %>
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main
           *dependencies*
           *executor*))
(in-package :<% @var name %>)

(defvar *dependencies* '()
  "Write dependent libralies of Node.js as string list")

(defvar *executor* "node"
  "Rewrite this if you want to execute this script by another executor (Ex. casperjs)")

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    ))
