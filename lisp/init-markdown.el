;;; init-markdown.el --- Markdown editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Enable Markdown highlighting
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :custom
  (markdown-command "multimarkdown"))

(provide 'init-markdown)
;;; init-markdown.el ends here
