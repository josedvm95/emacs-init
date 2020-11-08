;;; init-python.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(setq python-shell-interpreter "python3")

;; Enable anaconda for code navegation, documentation lookup and code completion.
(use-package anaconda-mode
  :ensure t
  :after (python)
  :diminish anaconda-mode
  :hook ((python-mode . anaconda-mode)
         (python-mode . anaconda-eldoc-mode)))

;; Enable Black formatter
(use-package reformatter
  :ensure t
  :config
  (reformatter-define black
    :program "black"))

;; For company mode with anaconda
;(use-package company-anaconda
;  :ensure t
;  :after (anaconda-mode company)
;  :config
;  (add-to-list 'company-backends 'company-anaconda))

(provide 'init-python)
;;; init-python.el ends here
