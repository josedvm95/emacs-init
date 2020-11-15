;;; init-json.el --- JSON editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Pretty print on save
(use-package json-mode
  :ensure t
  :mode "\\.json\\'"
  :bind (:map json-mode-map
              ("C-c b" . json-pretty-print-buffer))
  :hook (before-save . init/json-pretty-before-save)
  :preface
  (defun init/json-pretty-before-save ()
    (when (eq major-mode 'json-mode)
      (json-pretty-print-buffer)))
  )

(provide 'init-json)
;;; init-json.el ends here
