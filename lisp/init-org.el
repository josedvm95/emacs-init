;;; init-org.el --- Org mode config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Org mode configuration for better experience.
;; Get rid of the XML validation.
;; Support for exporting to Markdown in Org Mode.
;; Change the breadcrumb separator to '→'.
;; Define more TODO keywords.
(use-package org
  :mode (("\\.org\\'" . org-mode))
  :ensure org-plus-contrib
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :custom
  (org-html-validation-link nil)
  (org-eldoc-breadcrumb-separator " → ")
  (org-todo-keywords
   '((sequence "TODO(t)" "|" "DONE(d)") (sequence "[ ](T)" "[-](p)" "[?](m)" "|" "[X](D)")
     (sequence "NEXT(n)" "WAITING(w)" "LATER(l)" "|" "CANCELLED(c)")))
  (org-todo-keyword-faces
   '(("[-]" :inherit (font-lock-constant-face bold))
     ("[?]" :inherit (warning bold))
     ("WAITING" :inherit bold)
     ("LATER" :inherit (warning bold))))
  :config
  (use-package ox-md))

;; Enable LaTeX compiling in Org mode.
;; Can be used for example to export images (running code inside Org).
;; Avoid `org-babel-do-load-languages' since it does an eager require and loads many packages that are not needed.
(use-package ob-latex
  :defer t
  :ensure org-plus-contrib
  :commands (org-babel-execute:latex))

;; Enable Python language compiling in Org mode.
(use-package ob-python
  :defer t
  :ensure org-plus-contrib
  :commands (org-babel-execute:python))

;; Enable Shell scripts in Org mode.
(use-package ob-shell
  :defer t
  :ensure org-plus-contrib
  :commands
  (org-babel-execute:sh
   org-babel-expand-body:sh

   org-babel-execute:bash
   org-babel-expand-body:bash))

;; Enable C and C++ language compiling in Org mode.
(use-package ob-C
  :defer t
  :ensure org-plus-contrib
  :commands
  (org-babel-execute:cpp
   org-babel-expand-body:cpp

   org-babel-execute:C++
   org-babel-expand-body:C++

   org-babel-execute:C
   org-babel-expand-body:C))

;; Refresh inline images after executing src blocks
(add-hook 'org-babel-after-execute-hook #'org-redisplay-inline-images)

(provide 'init-org)
;;; init-org.el ends here
