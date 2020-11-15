;;; init-python.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(setq python-shell-interpreter "python3")

;; Enable anaconda for code navegation, documentation lookup and code completion.
(use-package anaconda-mode
  :ensure t
  :after python
  :diminish anaconda-mode
  :hook ((python-mode . anaconda-mode)
         (python-mode . anaconda-eldoc-mode)))

;; Enable blacken for code reformatting only in Python
(use-package blacken
  :ensure t
  :diminish
  :hook (python-mode . blacken-mode)
  :bind (:map python-mode-map
         ("C-c b" . blacken-buffer))
  :custom (blacken-line-length 79))

;; For company mode with anaconda
;(use-package company-anaconda
;  :ensure t
;  :after (anaconda-mode company)
;  :config
;  (add-to-list 'company-backends 'company-anaconda))

(provide 'init-python)
;;; init-python.el ends here
