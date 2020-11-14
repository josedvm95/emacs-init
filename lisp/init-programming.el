;;; init-programming.el --- General programming config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Show the name of the current function in the modeline.
(use-package which-func
  :config
  (which-function-mode 1))

;; Highlight annotations like TODO, DONE and FIXME in source code.
(use-package hl-todo
  :ensure t
  :config
  (global-hl-todo-mode 1))

(provide 'init-programming)
;;; init-programming.el ends here
