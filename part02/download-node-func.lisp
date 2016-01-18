(ql:quickload :ps-experiment)

(in-package :cl-user)
(defpackage download-node-func
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main))
(in-package :download-node-func)

(defun.ps download (url savepath callback)
  (let* ((http (require 'http))
         (fs (require 'fs))
         (outfile (fs.create-write-stream savepath)))
    (http.get url (lambda (res)
                    (res.pipe outfile)
                    (res.on "end" (lambda ()
                                    (outfile.close)
                                    (funcall callback)))))))

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    (download "http://www.aozora.gr.jp/index_pages/person81.html"
              "miyazawakenji.html"
              (lambda () (console.log "ok, kenji.")))
    (download "http://www.aozora.gr.jp/index_pages/person148.html"
              "natumesouseki.html"
              (lambda () (console.log "ok, soseki.")))))
