;;; init-lua.el --- Lua editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Enable and install Lua mode automatically (for highlighting)
(use-package lua-mode
  :ensure t
  :mode "\\.lua\\'"
  :custom
  (lua-indent-level 2)
  (indent-tabs-mode nil))

;; Use love-minor-mode-v2 for the LÖVE framework
;; Load it only after lua-mode
(add-to-list 'load-path (expand-file-name "love-minor-mode-v2" user-emacs-directory))
(use-package love-minor-mode-v2
  :after lua-mode)

(provide 'init-lua)
;;; init-lua.el ends here
