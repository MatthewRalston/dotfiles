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


(defun add-hover-image (linktext caption imagepath &optional link)
  "Generate a HTML5 hover feature over a link."
  (interactive "MLink text: \nMCaption: \nFImagepath:\nMlink:\n")
  (if (not (string= "" link))
      (url-copy-file link imagepath))
  (insert (concat (format "<div class=\"hover-image-container\">
  <a href=\"#\">%s</a>
  <div class=\"hover-image-wrapper\">
    <img class=\"hover-image\" src=\"%s" linktext (file-name-nondirectory imagepath))
		  "\" alt=\"Hover image\"/>
    <div class=\"image-caption\">"
		  caption
		  "</div>
        </div>
    </div>")))



(defun add-hover-video (linktext caption videoid &optional startat)
  " Generate a hovering youtube video. Creates a card that will allow playback if the user clicks on the youtube play button. Will not autoplay on hover. This is more user friendly than previous iterations."
  (interactive "MLink text: \nMCaption: \nMYoutube video link: \nStart at (optional): \n")
  (insert (concat (format "<div class=\"hover-image-container\">
  <a href=\"#\">%s</a>
  <div class=\"hover-image-wrapper\">
  <iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/%s?autoplay=1&%s\" title=\"Youtube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen></iframe>
  <div class=\"image-caption\"" linktext videoid startat)
		  caption
		  "</div>
               </div>
            </div>"))
)
    


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
