;;; init-onlinesearch.el --- Online searching -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Enable Google search.
(defun in-google ()
  "Google the selected region if any, display a query prompt otherwise."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?q="
    (url-hexify-string (if mark-active
         (buffer-substring (region-beginning) (region-end))
         (read-string "Google: "))))))

(global-set-key (kbd "C-c g") #'in-google)


;; Enable YouTube search.
(defun in-youtube ()
  "Search YouTube with a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.youtube.com/results?search_query="
    (url-hexify-string (if mark-active
         (buffer-substring (region-beginning) (region-end))
         (read-string "Search YouTube: "))))))

(global-set-key (kbd "C-c y") #'in-youtube)

(provide 'init-onlinesearch)
;;; init-onlinesearch.el ends here
