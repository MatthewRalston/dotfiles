
;;(load-theme 'manoj-dark t)
(load-theme 'spacemacs-dark t)
;;(load-theme 'doom-theme t)

(setq max-lisp-eval-depth 5000)
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode)

;; Package.el
(require 'package)
;;(package-initialize)

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


;; Transparency
(setq default-frame-alist
       '((alpha . 95)))


(use-package golden-ratio-mode)


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
(add-to-list 'load-path "~/Projects/org-mode/lisp/")
;; Fonts
;;(add-to-list 'default-frame-alist
;;             '(font . "Iosevka Term-12"))


;; Use DejaVu Sans Mono as a fallback in fontset-startup
;; before resorting to fontset-default.
;;(set-fontset-font "fontset-startup" nil "DejaVu Sans Mono"
;;                  nil 'append)

;; Garbage Collection
(use-package gcmh
:ensure t
:hook (after-init . gcmh-mode)
:custom
(gc-cons-percentage .9))
