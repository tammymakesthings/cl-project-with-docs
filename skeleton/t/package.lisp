;; -*- Lisp; lexical-binding: t; fill-column: 90; encoding: utf-8; -*-
;;;;
;;;; File       :
;;;; Description:
;;;; Created    :
;;;; Last Update:
;;;;

#+quicklisp
(progn
  ;; Initialization forms
  (ql:quickload '(:rove :hamcrest :mockingbird :closer-common-lisp :uiop
                  :alexandria))
  )

(in-package #:cl-user)

(defpackage #:<% @var name %>-test
  (:use #:cl #:closer-common-lisp #:rove #:hamcrest/rove #:mockingbird)
  (:local-nicknames
    (:ccl :closer-common-lisp)
    (:hcr :hamcrest/rove)
    (:mock :mockingbird)))

(in-package <% @var name %>-test)

(use-package <% @var name %>-test/core)

(deftest
  sample-test
  (testing "success"
           (ok (= (length #(1 2 3)) 3))))

;;;;
;;;; vim: set ft=lisp ts=2 sw=2 ai tw=90
