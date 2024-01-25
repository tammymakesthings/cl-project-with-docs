;; -*- Lisp; lexical-binding: t; fill-column: 90; encoding: utf-8; -*-
;;;;
;;;; File       : <% @var name %>-test.asd
;;;; Description: ASDF system definition for <% @var name %> unit tests
;;;; Created    :
;;;; Last Update:
;;;;

(asdf:defsystem <% @var name %>-test
  :author "<% @var author %>"
  :license "<% @var license %>"
  :class :package-inferred-system
  :pathname "t"
  :depends-on (:<% @var name %>
               "<% @var name %>-test/core")
  :description "Test system for <% @var name %>"

  :perform (test-op :after (op c)
                    (symbol-call :rove :run c)
                    (clear-system c)))


(use-package #:<% @var name %>/core)

(uiop:add-package-local-nickname :core #:<% @var name %>/core )

;;;;
;;;; vim: set ft=lisp ts=2 sw=2 ai tw=90
