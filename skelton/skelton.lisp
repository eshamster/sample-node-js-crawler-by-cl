(ql:quickload :ps-experiment)

(in-package :cl-user)
(defpackage <% @var name %>
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main))
(in-package :<% @var name %>)

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    ))
