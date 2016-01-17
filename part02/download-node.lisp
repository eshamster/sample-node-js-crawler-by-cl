(ql:quickload :ps-experiment)

(in-package :cl-user)
(defpackage download-node
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main))
(in-package :download-node)

(defvar.ps url "http://kujirahand.com/")
(defvar.ps savepath "test.html")

(defvar.ps http (require "http"))
(defvar.ps fs (require "fs"))

(defvar.ps outfile (fs.create-write-stream savepath))

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    (http.get url
              (lambda (res)
                (res.pipe outfile)
                (res.on 'end
                        (lambda ()
                          (outfile.close)
                          (console.log "ok")))))))
