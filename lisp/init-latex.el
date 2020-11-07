;;; init-latex.el --- LaTeX editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; LaTeX configuration.
;; Enable document parsing for LaTeX.
(use-package tex
  :ensure auctex
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t))

(provide 'init-latex)
;;; init-latex.el ends here
