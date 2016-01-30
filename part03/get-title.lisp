(ql:quickload :ps-experiment)

(in-package :cl-user)
(defpackage get-title
  (:use :cl
        :parenscript
        :ps-experiment)
  (:export main
           *dependencies*
           *executor*))
(in-package :get-title)

#|
実行前にcasperjsのインストールが必要
$ sudo yum install -y freetype fontconfig
$ npm install -g phantomjs@1.9.17
$ npm install -g casperjs@1.1.0-beta3
|#

(defvar *dependencies* '()
  "Write dependent libralies of Node.js as string list")

(defvar *executor* "casperjs"
  "Rewrite this if you want to execute this script by another executor (Ex. casperjs)")

(defvar.ps *target-url* "http://kujirahand.com")
(defvar.ps *casper* (-- (require "casper") (create))) 

(defun main (&rest argv)
  (declare (ignorable argv))
  (with-use-ps-pack (:this)
    (*casper*.start *target-url*
                    (lambda ()
                      (this.echo (*casper*.get-title))))
    (*casper*.run)))
