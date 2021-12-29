
;;(load-theme 'manoj-dark t)
(load-theme 'spacemacs-dark t)

(setq inhibit-startup-screen t)
(global-display-line-numbers-mode)

;; Package.el
(require 'package)
;;(package-initialize)

; IDO mode
(require 'ido)
(ido-mode t)
(setq ido-everywhere t)

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

;; Fonts
(add-to-list 'default-frame-alist
             '(font . "Iosevka Term-12"))


;; Use DejaVu Sans Mono as a fallback in fontset-startup
;; before resorting to fontset-default.
(set-fontset-font "fontset-startup" nil "DejaVu Sans Mono"
                  nil 'append)
