;;; init-flycheck.el --- Syntax checking -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Hide the flycheck mode
(use-package flycheck
  :ensure t
  :defer 2
  :diminish
  :hook ((python-mode . flycheck-mode))
  :custom
  (flycheck-display-errors-delay .3)
)

(provide 'init-flycheck)
;;; init-flycheck.el ends here
