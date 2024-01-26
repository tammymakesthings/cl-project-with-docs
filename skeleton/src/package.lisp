;; -*- Lisp; lexical-binding: t; fill-column: 90; encoding: utf-8; -*-
;;;;
;;;; File       : src/package.lisp
;;;; Description: Package configuration and initialization code.
;;;;

#+quicklisp
(progn
  (ql:quickload '(:clingon :log4cl :envy :uiop :alexandria)))

(in-package #:cl-user)

(defpackage #:<% @var name %>
  (:use #:cl #:uiop #:alexandria #:clingon #:log4cl #:envy)
  (:export "envy-get" "envy-set" "initialize-app")
  (:local-nicknames (:cg :clingon))
  )

(:in-package #:<% @var name %>)

;; Envy (environment-specific configuration) helpers.
(defun envy-app-config ()
  "Get the envy configuration for the application."
  (envy:config :<% @var name %>))
(defun envy-get (var-name)
  "Get a variable value from the current envy configuration."
  (getf (envy-app-config) var-name))
(defun envy-set (var-name var-value)
  "Set a variable value in the current envy configuration."
  (setf (getf (envy-app-config) var-name)))

; Initialize the log4cl framework
(defun initialize-log4cl (envy-var-name)
  "Initialize log4cl and set the log level correctly."
  (if (envy-get :logging)
      (log:config
        (envy-get :log-level) :CONSOLE :PRETTY :TIME :IMMEDIATE-FLUSH)))

(defun initialize-app (&optional (env-var-name "APP_ENVIRONMENT"))
  "Initialize per-environment configurations and set up log4cl."
  (setf (envy:config-env-var) env-var-name)
  (envy:defconfig :common       '(:logger t :log-level :INFO))
  (envy:defconfig |development| '(:log-level :DEBUG))
  (envy:defconfig |production|  '(:log-level :INFO))

  (initialize-log4cl))

(use-package #:<% @var name %>/core)

(uiop:add-package-local-nickname :core #:<% @var name %>/core )
(initialize-app)

;;;;
;;;; vim: set ft=lisp ts=2 sw=2 ai tw=90
