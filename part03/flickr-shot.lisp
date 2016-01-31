(ql:quickload :ps-experiment)
(ql:quickload :quri)

(in-package :cl-user)
(defpackage flickr-shot
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main
           *dependencies*
           *executor*))
(in-package :flickr-shot)

(defvar *dependencies* '()
  "Write dependent libralies of Node.js as string list")

(defvar *executor* "casperjs"
  "Rewrite this if you want to execute this script by another executor (Ex. casperjs)")

(defmacro.ps url-encode (str)
  (quri:url-encode str))

(defvar.ps casper (-- (require "casper") (create)))

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    (casper.start)
    (casper.viewport 1400 800)
    (casper.user-agent "User-Agent: Chrome/37.0.2062.120")
    (casper.open (+ "https://www.flickr.com/search/?text=" (url-encode "ハムスター")))
    (casper.then (lambda ()
                   (let ((params (make-hash-table)))
                     (setf (gethash :top params) 0)
                     (setf (gethash :left params) 0)
                     (setf (gethash :width params) 1400)
                     (setf (gethash :height params) 800)
                     (this.capture "flickr-hamster.png" params))))
    (casper.run)))
