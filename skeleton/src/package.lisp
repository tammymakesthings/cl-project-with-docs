;; -*- Lisp; lexical-binding: t; fill-column: 90; encoding: utf-8; -*-
;;;;
;;;; File       :
;;;; Description:
;;;; Created    :
;;;; Last Update:
;;;;

#+quicklisp
(progn
  (ql:quickload '(:clingon :log4cl :envy :uiop :alexandria)))

(in-package #:cl-user)

(defpackage #:<% @var name %>
  (:use #:cl #:uiop #:alexandria #:clingon #:log4cl #:envy)
  (:local-nicknames (:cg :clingon))
  )

(:in-package #:<% @var name %>)

(progn
  (setf (envy:config-env-var "APP_ENV"))
  (envy:defconfig :common '(:logger t :log-level :INFO))
  (envy:defconfig |development| '(:log-level :DEBUG))
  (envy:defconfig |production| '(:log-level :INFO))

  (if (getf (envy:config :<% @var name %>))
      (log:config (getf (envy:config :<% @var name %>) :log-level)
                  :CONSOLE :PRETTY :TIME :FILE2 :IMMEDIATE-FLUSH)
      )
  )


(use-package #:<% @var name %>/core)

(uiop:add-package-local-nickname :core #:<% @var name %>/core )


;;;;
;;;; vim: set ft=lisp ts=2 sw=2 ai tw=90
