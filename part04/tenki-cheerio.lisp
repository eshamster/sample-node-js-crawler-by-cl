(ql:quickload :ps-experiment)

(in-package :cl-user)
(defpackage tenki-cheerio
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main
           *dependencies*))
(in-package :tenki-cheerio)

(defvar *dependencies* '("cheerio-httpcli")
  "Write dependent libralies of Node.js as string list")

(defvar.ps *client* (require "cheerio-httpcli"))

"Yahoo天気予報のRSS（神戸）"
(defvar.ps *rss-url* "http://rss.weather.yahoo.co.jp/rss/days/6310.xml")

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    (*client*.fetch
     *rss-url* {}
     (lambda (err $ res)
       (when err
         (error err))
       (-- ($ "item > title")
           (each (lambda (idx)
                   (console.log (-- ($ this) (text))))))))))
