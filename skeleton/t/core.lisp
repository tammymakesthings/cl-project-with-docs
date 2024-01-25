;; -*- Lisp; lexical-binding: t; fill-column: 90; encoding: utf-8; -*-
;;;;
;;;; File       :
;;;; Description:
;;;; Created    :
;;;; Last Update:
;;;;

(defpackage #:<% @var name %>-test/core
  (:use #:cl
        #:<% @var name %>/core
        #:rove
        #:hamcrest/rove))

(in-package <% @var name %>-test/core)

(deftest test-some-staff
    (testing "Replace this test with real staff."
      (assert-that (foo 1 2)
                   (contains 1 2))))

;;;;
;;;; vim: set ft=lisp ts=2 sw=2 ai tw=90
