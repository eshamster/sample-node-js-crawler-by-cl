(ql:quickload :ps-experiment)

(in-package :cl-user)
(defpackage getall
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main
           *dependencies*))
(in-package :getall)

(defvar *dependencies* '("cheerio-httpcli" "request")
  "Write dependent libralies of Node.js as string list")

(defvar.ps *client* (require "cheerio-httpcli"))
(defvar.ps *request* (require "request"))
(defvar.ps *fs* (require "fs"))
(defvar.ps *url* (require "url")) 
(defvar.ps *path* (require "path")) 

(defvar.ps *target-url* "http://nodejs.jp/nodejs.org_ja/docs/v0.10/api/")
(defvar.ps *max-level* 3)

(defun.ps is-base-url (target url)
  (let ((us (target.split "/")))
    (us.pop)
    (>= (url.index-of (us.join "/")) 0)))

(defun.ps format-url (url href)
  (-- (*URL*.resolve url href)
      (replace (regex "/\\#.+$/") "")))

(defun.ps ensure-dir (path)
  (let* ((dirs (*path*.dirname path))
         (dir-list (dirs.split "/"))
         (p ""))
    (dolist (dir dir-list)
      (incf p (+ dir "/"))
      (unless (*fs*.exists-sync p)
        (*fs*.mkdir-sync p)))))

(defun.ps save-html (url html)
  (let ((savepath (-- (url.replace (regex "/\\/$/") "/index.html")
                      (split "/")
                      (slice 2)
                      (join "/"))))
    (ensure-dir savepath)
    (console.log savepath)
    (*fs*.write-file-sync savepath html)))

(defun.ps download-rec (url max-level)
  (let ((downloaded-list '()))
    (labels ((rec (url rest-level)
               (when (and (> rest-level 0)
                          (is-base-url *target-url* url)
                          (not (find url downloaded-list)))
                 (console.log rest-level)
                 (push url downloaded-list)
                 (*client*.fetch
                  url {}
                  (lambda (err $ res)
                    (-- ($ "a")
                        (each (lambda (idx)
                                (let ((href (-- ($ this) (attr "href"))))
                                  (when href
                                    (rec (format-url url href) (1- rest-level)))))))
                    (save-html url ($.html)))))))
      (rec url max-level))))

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    (download-rec *target-url* *max-level*)))
