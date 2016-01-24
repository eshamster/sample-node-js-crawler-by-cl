(ql:quickload :ps-experiment)

(in-package :cl-user)
(defpackage tenki
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main
           *dependencies*))
(in-package :tenki)

(defvar *dependencies* '("xml2js")
  "Write dependent libralies of Node.js as string list")

(defvar.ps parse-string (-- (require "xml2js") parse-string))
(defvar.ps *request* (require "request"))

"Yahoo天気予報のRSS（神戸）"
(defvar.ps *rss-url* "http://rss.weather.yahoo.co.jp/rss/days/6310.xml")

(defun.ps analyze-rss (xml)
  (parse-string xml
                (lambda (err obj)
                  (when err
                    (console.log err)
                    (return))
                  (maphash (lambda (key item)
                             (console.log (-- item title 0)))
                           (-- obj rss
                               channel 0
                               item)))))

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    (*request* *rss-url*
               (lambda (err response body)
                 (when (and (not err)
                            (= response.status-code 200))
                   (analyze-rss body))))))
