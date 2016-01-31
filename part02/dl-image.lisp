(ql:quickload :ps-experiment)
(ql:quickload :quri)

(in-package :cl-user)
(defpackage dl-image
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main
           *dependencies*))
(in-package :dl-image)

(defvar *dependencies* '("cheerio-httpcli" "request")
  "Write dependent libralies of Node.js as string list")

(defvar.ps *client* (require "cheerio-httpcli"))
(defvar.ps *request* (require "request"))
(defvar.ps *fs* (require "fs"))
(defvar.ps *url* (require "url")) 

(defvar.ps *save-dir* (+ __dirname "/img"))

(defun.ps ensure-savedir ()
  (unless (*fs*.exists-sync *save-dir*)
    (*fs*.mkdir-sync *save-dir*)))

(defmacro.ps url-encode (str)
  (quri:url-encode str))

(defun.ps download-images ()
  (let ((url (+ "https://ja.wikipedia.org/wiki/" (url-encode "ハムスター")))
        (param (make-hash-table)))
    (*client*.fetch
     url param
     (lambda (err $ res)
       (when err
         (console.log "error")
         (console.log err)
         (return))
       (-- ($ "img")
           (each (lambda (idx)
                   (let* ((src (*url*.resolve url
                                              (-- ($ this) (attr "src"))))
                          (file-name (-- (*url*.parse src) pathname))
                          (file-path (+ *save-dir* "/"
                                        (file-name.replace (regex "/[^a-zA-Z0-9\\.]+/g") "_"))))
                     (-- (*request* src)
                         (pipe (*fs*.create-write-stream file-path)))))))))))

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    (ensure-savedir)
    (download-images)))
