;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)



;; Transparency
;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))




(add-to-list 'load-path "~/.emacs.d/config_lisp_files")
(load "common-config.el")
;;(load "ruby-config.el")
(load "r-config.el")
;;(load "ssh-config.el")
(load "org-config.el")
;;(load "autocomplete.el")
(load "TeX-config.el")
(load "http-config.el")
(load "flyspell-config.el")
(load "webdocs.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9685cefcb4efd32520b899a34925c476e7920725c8d1f660e7336f37d6d95764" default)))
 '(org-agenda-files (quote ("/home/matt/tasks.org")))
 '(package-selected-packages
   (quote
    (idle-org-agenda org-superstar org-beautify-theme org-clock-reminder org-inline-anim org-inline-pdf org-tag-beautify scala-mode sbt-mode yaml-mode web-mode simple-httpd rspec-mode rsense org json-mode jekyll-modes jedi ess))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
