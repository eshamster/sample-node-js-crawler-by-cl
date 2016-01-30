(ql:quickload :ps-experiment)

(in-package :cl-user)
(defpackage screenshot
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main
           *dependencies*
           *executor*))
(in-package :screenshot)

(defvar *dependencies* '()
  "Write dependent libralies of Node.js as string list")

(defvar *executor* "casperjs"
  "Rewrite this if you want to execute this script by another executor (Ex. casperjs)")

(defvar.ps casper (-- (require "casper") (create)))

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    (casper.start)
    (casper.open "http://google.co.jp")
    (casper.then (lambda ()
                   (casper.capture "screenshot.png")))
    (casper.run)))
