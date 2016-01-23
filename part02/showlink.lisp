(ql:quickload :ps-experiment)

(in-package :cl-user)
(defpackage showlink
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main
           *dependencies*))
(in-package :showlink)

(defvar *dependencies* '("cheerio-httpcli")
  "Write dependent libralies of Node.js as string list")

(defvar.ps client (require "cheerio-httpcli"))

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    (let ((url "http://www.aozora.gr.jp/index_pages/person81.html")
          (param (make-hash-table)))
      (client.fetch url param
                    (lambda (err $ res)
                      (when err
                        (console.log "Error: " err)
                        (return))
                      ((-- ($ "a")
                           (each (lambda ()
                                   (console.log (+ (-- ($ this) (text))
                                                   ":"
                                                   (-- ($ this) (attr "href")))))))))))))
