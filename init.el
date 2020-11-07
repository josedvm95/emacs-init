;;; init.el --- Emacs init file with minimal configuration.

;; Copyright © 2020 Jose A. del Val

;; Author: Jose A. del Val
;; URL: https://github.com/josedvm95/emacs-init
;; Version: 0.1.0
;; Package-Requires: ((emacs "25.1"))
;; Created: 2020-11-06
;; Keywords: convenience

;;; Commentary:

;; This init file configures Emacs automatically, so that there is no
;; need to install packages manually.
;; It configures: Org mode, LaTeX and Markdown.
;; It uses 'Better Defaults' by Phil Hagelberg.

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

;; Make startup faster by reducing the frequency of garbage
;; collection.  The default is 800 kilobytes.  Measured in bytes.
;; Save the original value to restore it later.
(setq gc-cons-threshold-original gc-cons-threshold)
(setq gc-cons-threshold (* 50 1000 1000))

;; Make startup faster by avoiding to run the regexps inside file-name-handler-alist.
;; Save the original value to restore it later.
(setq file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Basic initialization, (require) non-ELPA packages, etc.
;; This must come before the repositories.
(require 'package)
(setq package-enable-at-startup nil)

;; Update package-archive lists.
;; Set Org and MELPA repositories.
;; Any add to list for package-archives (to add marmalade or melpa) goes here.
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))

;; This must come before configurations of
;; installed packages and after the package-archives.
;; Don't delete this line.
(package-initialize)

;; Use Better Defaults.
(add-to-list 'load-path "better-defaults")
(require 'better-defaults)

;; Install 'use-package' if necessary.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable use-package
(eval-and-compile
  (require 'use-package))

;; Make sure we load the Custom File
(load-file custom-file)

;; Enable Dark Theme.
(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

;; Hide all buffers starting with an asterisk when using Ibuffer (configured in Better Defaults)
(use-package ibuf-ext
  :config
  (add-to-list 'ibuffer-never-show-predicates "^\\*"))

;; Make the mouse scrolling smoother.
;; Three lines at a time, 1 when holding shift. 
;; Don't accelerate scrolling.
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)

;; Remap C-a to go to first non-whitespace character instead of first character.
(use-package crux
  :ensure t
  :bind (("C-a" . crux-move-beginning-of-line)))

;; Org mode configuration for better experience.
;; Get rid of the XML validation.
;; Support for exporting to Markdown in Org Mode.
;; Change the breadcrumb separator to '→'.
;; Define more TODO keywords.
(use-package org
  :mode (("\\.org$" . org-mode))
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

;; Support for exporting to Markdown in Org Mode.
;;(eval-after-load "org"
;;  '(require 'ox-md nil t))

;; LaTeX configuration.
;; Enable document parsing for LaTeX.
(use-package tex
  :ensure auctex
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t))

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

;; Enable Markdown highlighting
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :custom
  (markdown-command "multimarkdown"))

;; Enable recent files with Ido mode.
(use-package recentf
  ;; Loads after 1 second of idle time.
  :defer 1
  :init
  (defun ido-recentf-open ()
    "Use `ido-completing-read' to \\[find-file] a recent file"
    (interactive)
    (if (find-file (ido-completing-read "Find recent file: " recentf-list))
        (message "Opening file...")
      (message "Aborting")))
  ;; get rid of `find-file-read-only' and replace it with something
  ;; more useful.
  :bind (("C-x C-r" . ido-recentf-open))
  :config
  (recentf-mode t)
  :custom
  (recentf-max-saved-items 25))

;; Slightly shorten eldoc display delay.
;; And hide the minor mode in the modeline.
(use-package eldoc
  :diminish eldoc-mode
  :config
  (setq eldoc-idle-delay 0.4))

;; To be able to use the diminish keywork in use-package.
(use-package diminish
  :ensure t
  :demand t)

;; Enable Lua highlighting
(use-package lua-mode
  :ensure t
  :mode (("\\.lua$" . lua-mode)))

;; Use love-minor-mode-v2
(add-to-list 'load-path "/home/josedvm95/Documentos/emacs/love-minor-mode-v2")
(use-package love-minor-mode-v2)

;; Set deferred timer to reset the garbage colection and file-name-handler-alist.
(run-with-idle-timer
 5 nil
 (lambda ()
   (setq gc-cons-threshold gc-cons-threshold-original)
   (setq file-name-handler-alist file-name-handler-alist-original)
   (makunbound 'gc-cons-threshold-original)
   (makunbound 'file-name-handler-alist-original)
   ;; Optional message.
   ;;(message "gc-cons-threshold and file-name-handler-alist restored")
   ))

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))
;;; init.el ends here
