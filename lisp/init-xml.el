;;; init-xml.el --- XML editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Enable XML pretty print
(use-package nxml-mode
  :mode ("\\.xml\\'"
         "\\.xsd\\'"
         "\\.svg\\'"
         "\\.wsdl\\'")
  :magic ("<\\?xml " . nxml-mode)
  :bind (:map nxml-mode-map
              ("C-c b" . pretty-xml-buffer))
  :custom
  (nxml-child-indent 4)
  (nxml-attribute-indent 4)
  (nxml-slash-auto-complete-flag t))

(defun pretty-xml-buffer ()
  "Pretty print XML on buffer"
  (interactive)
  (sgml-pretty-print (point-min) (point-max)))

(provide 'init-xml)
;;; init-xml.el ends here
