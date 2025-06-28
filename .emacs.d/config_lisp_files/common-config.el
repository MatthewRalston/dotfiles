
;;(load-theme 'manoj-dark t)
;;(load-theme 'spacemacs-dark t)
;;(load-theme 'doom-theme t)
;;(load-theme 'doom-acario-dark t)
;;(load-theme 'doom-challenger-deep t)
;;(load-theme 'doom-dracula t)
;;(load-theme 'doom-dark+ t)
;;(load-theme 'doom-one t)
(load-theme 'doom-gruvbox t)
;;(load-theme 'doom-iovskem t)
;;(load-theme 'doom-manegarm t)


(setq max-lisp-eval-depth 5000)
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode)

;; Package.el
(require 'package)
;;(package-initialize)

;; Transparency
(setq default-frame-alist
       '((alpha . 85)))


;; Split windows on system startup
(load "startup_splitwindows.el")
(four-window-split-custom)

; IDO mode
(require 'ido)
(ido-mode t)
(setq ido-everywhere t)

(setq markdown-open-command "markdown")

;; Enable line-wrap in horizontally split windows
(setq truncate-partial-width-windows nil)


(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
(autoload 'tex-mode-flyspell-verify "flyspell" "" t)
(setq flyspell-issue-welcome-flag nil)
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(defun add-hover-image (linktext caption imagepath &optional link)
  "Generate a HTML5 hover feature over a link."
  (interactive "MLink text: \nMCaption: \nFImagepath:\nMlink:\n")
  (if (not (string= "" link))
      (url-copy-file link imagepath))
  (insert (concat (format "<span class=\"hover-image-container\"><a href=\"#\">%s</a><span class=\"hover-image-wrapper\"><img class=\"hover-image\" src=\"/assets/img/%s" linktext (file-name-nondirectory imagepath))
		  "\" alt=\"Hover image\"/><span class=\"image-caption\">"
		  caption
   "</span></span></span>")))



(defun add-hover-video (linktext caption videoid &optional startat)
  " Generate a hovering youtube video. Creates a card that will allow playback if the user clicks on the youtube play button. Will not autoplay on hover. This is more user friendly than previous iterations."
  (interactive "MLink text: \nMCaption: \nMYoutube query \?v=: \nMStart at (optional): \n")
  (insert (concat (format "<span class=\"hover-video-container\"><a href=\"#\">%s</a><span class=\"hover-video-wrapper\"><iframe class=\"youtube-frame\" width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/%s?autoplay=0&start=%s\" title=\"Youtube video player\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen></iframe><span class=\"video-caption\">" linktext videoid startat)
		  caption
		  "</span></span></span>"))
)
    



;;(use-package golden-ratio-mode)


;;Time @goapl/.emacs.d on Github
(use-package time
  :ensure nil
  ;; :hook (after-init . display-time-mode) ;; Usually just look at the OS time
  :custom
  (world-clock-time-format "%A %d %B %r %Z")
  (display-time-day-and-date t)
  (display-time-default-load-average nil)
  (display-time-mail-string "")
  (zoneinfo-style-world-list
  '(("America/Los_Angeles" "Seattle")
    ("America/New_York" "New York")
    ("America/Halifax" "Nova Scotia")
    ("Asia/Tokyo" "Tokyo"))))




;; Manual install of org-mode 9.8-pre
;;(add-to-list 'load-path "~/Projects/org-mode/lisp/")
;; Fonts
(add-to-list 'default-frame-alist
             '(font . "IosevkaTerm Nerd Font Mono 12"))

(set-frame-font "Inconsolata LGC Nerd Font Mono 12" nil t)

;; Use DejaVu Sans Mono as a fallback in fontset-startup
;; before resorting to fontset-default.
(set-fontset-font "fontset-startup" nil "DejaVu Sans Mono"
                  nil 'append)

;; Garbage Collection
(use-package gcmh
:ensure t
:hook (after-init . gcmh-mode)
:custom
(gc-cons-percentage .9))


;; 

