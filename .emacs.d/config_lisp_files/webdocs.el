(require 'web-mode)
(require 'ac-html)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-hook 'web-mode-hook 'auto-complete-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.sass\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))

(defun add-popover-img (linktext caption imagepath &optional link)
  " Generate an html popover.
  -- Download an image file to the blog's image folder
  -- Generate a popover link at the current position
"
  (interactive "MLink text: \nMCaption: \nFImagepath:\nMlink:\n")
  (if (not (string= "" link))
      (url-copy-file link imagepath))
  (insert (concat (format "<a href=\"#\" title=\"%s\" data-toggle=\"popover\" data-placement=\"auto\" data-trigger=\"hover\" data-html=true data-content='<img src=\"img/%s\" " caption (file-name-nondirectory imagepath))
		  "height=\"100%\" width=\"100%\" />'>"
		  linktext
		  "</a>")))

(defun add-popover-video (linktext videoid)
  "Generate a popover youtube video
  -- Link a youtube video to your text
  -- Generate a popover video link at the current position
  -- Remember to add any additional url '?start=2' parameters to the link afterwards, I'm too lazy to code that right now.
"
  (interactive "MLink text: \nMhtttps://youtube.com/watch?v= (with start query param): \n")
  (insert (concat "<a href=\"#\" data-toggle=\"popover\" title=\"\" data-placement=\"auto\" data-trigger=\"hover\" data-html=true data-content='<iframe width=\"640\" height=\"480\" src=\"https://www.youtube.com/embed/"
		  videoid
		  (if (string-match-p (regexp-quote "?") videoid)
		      "&autoplay=1"
		    "?autoplay=1")
		  "\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>'>"
		  linktext
		  "</a>")))

;; (defun setup-ac-for-html ()
;;   ;; Require ac-haml since we are setup haml auto completion
;;   (require 'ac-html)
;;   ;; Require default data provider if you want to use
;;   (require 'ac-html-default-data-provider)
;;   ;; Enable data providers,
;;   ;; currently only default data provider available
;;   (ac-html-enable-data-provider 'ac-html-default-data-provider)
;;   ;; Let ac-haml do some setup
;;   (ac-html-setup)
;;   ;; Set your ac-source
;;   (setq ac-sources '(ac-source-html-tag
;; 		     ac-source-html-attr
;; 		     ac-source-html-attrv))
;;   ;; Enable auto complete mode
;;   (auto-complete-mode))

;; (add-hook 'html-mode-hook 'setup-ac-for-html)

;;(add-to-list 'web-mode-ac-sources-alist
;;	     '("html" . (ac-source-html-tag
;;			 ac-source-html-attr
;;			 ac-source-html-attrv)))
