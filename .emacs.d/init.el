;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(setq package-enable-at-startup nil
      package-archives '(("org" . "https://orgmode.org/elpa/")
			 ("melpa" .  "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa3" . "http://www.mirrorservice.org/sites/stable.melpa.org/packages/")
			 ;;("marmalade" . "https://marmalade-repo.org/packages/")
			 ))

;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;; Transparency
;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))




(add-to-list 'load-path "~/.emacs.d/config_lisp_files")

;; EMACS configs
(load "common-config.el")
(load "doom-modeline-config.el")
(load "treemacs-config.el")
(load "vertico-config-with-posframe-and-marginalia.el")
;;(load "ispell_config.el")
;;(load "completion_config.el")


;; Lanuage configs
;;(load "ruby-config.el")
;;(load "r-config.el")
;;(load "ssh-config.el")
(load "org-config.el")
;;(load "autocomplete.el")
;;(load "TeX-config.el")
;;(load "http-config.el")
;;(load "flyspell-config.el")

;;(load "webdocs.el")








;; EXTRA functions

;; Just some stuff I guess...

(use-package dockerfile-mode
  :ensure t
  :defer)


(use-package yaml-mode
  :ensure t
  :defer)


(use-package highlight-indentation
  :ensure t
  :defer
  :hook ((prog-mode . highlight-indentation-mode)
         (prog-mode . highlight-indentation-current-column-mode)))

(use-package hl-todo
  :ensure t
  :defer t
  :hook (prog-mode . hl-todo-mode))

(use-package mwheel
  :ensure nil
  :custom
  (mouse-wheel-tilt-scroll t)
  (mouse-wheel-scroll-amount-horizontal 2)
  (mouse-wheel-flip-direction t))

;; (use-package spacious-padding
;;   :ensure t
;;   :defer
;;   :hook (after-init . spacious-padding-mode)
;;   )


;; Taken shamelessly from Gopar/.emacs.d on Github.

;; Thx



  (defun gopar/copy-filename-to-kill-ring ()
    (interactive)
    (kill-new (buffer-file-name))
    (message "Copied to file name kill ring"))

  (defun gopar/easy-underscore (arg)
    "Convert all inputs of semicolon to an underscore.
If given ARG, then it will insert an acutal semicolon."
    (interactive "P")
    (if arg
        (insert ";")
      (insert "_")))

  (defun easy-camelcase (arg)
    (interactive "c")
    ;; arg is between a-z
    (cond ((and (>= arg 97) (<= arg 122))
           (insert (capitalize (char-to-string arg))))
          ;; If it's a new line
          ((= arg 13)
           (newline-and-indent))
          ((= arg 59)
           (insert ";"))
          ;; We probably meant a key command, so lets execute that
          (t (call-interactively
              (lookup-key (current-global-map) (char-to-string arg))))))

  (defun sudo-edit (&optional arg)
    "Edit currently visited file as root.
With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
    (interactive "P")
    (if (or arg (not buffer-file-name))
        (find-file (concat "/sudo:root@localhost:"
                           (completing-read "Find file(as root): ")))
      (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

  ;; Stolen from https://emacs.stackexchange.com/a/13096/8964
  (defun gopar/reload-dir-locals-for-current-buffer ()
    "Reload dir locals for the current buffer"
    (interactive)
    (let ((enable-local-variables :all))
      (hack-dir-local-variables-non-file-buffer)))

  (defun gopar/delete-word (arg)
    "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
    (interactive "p")
    (delete-region
     (point)
     (progn
       (forward-word arg)
       (point))))

  (defun gopar/backward-delete-word (arg)
    "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
    (interactive "p")
    (gopar/delete-word (- arg)))

  (defun gopar/delete-line ()
    "Delete text from current position to end of line char.
This command does not push text to `kill-ring'."
    (interactive)
    (delete-region
     (point)
     (progn (end-of-line 1) (point)))
    (delete-char 1))

  (defadvice gopar/delete-line (before kill-line-autoreindent activate)
    "Kill excess whitespace when joining lines.
If the next line is joined to the current line, kill the extra indent whitespace in front of the next line."
    (when (and (eolp) (not (bolp)))
      (save-excursion
        (forward-char 1)
        (just-one-space 1))))

  (defun gopar/delete-line-backward ()
    "Delete text between the beginning of the line to the cursor position.
This command does not push text to `kill-ring'."
    (interactive)
    (let (p1 p2)
      (setq p1 (point))
      (beginning-of-line 1)
      (setq p2 (point))
      (delete-region p1 p2)))

  (defun gopar/next-sentence ()
    "Move point forward to the next sentence.
Start by moving to the next period, question mark or exclamation.
If this punctuation is followed by one or more whitespace
characters followed by a capital letter, or a '\', stop there. If
not, assume we're at an abbreviation of some sort and move to the
next potential sentence end"
    (interactive)
    (re-search-forward "[.?!]")
    (if (looking-at "[    \n]+[A-Z]\\|\\\\")
        nil
      (gopar/next-sentence)))

  (defun gopar/list-git-authors-for-file ()
    "Display all the authors for a given file.
If file is not in a git repo or file is not a real file (aka buffer), then do nothing."
    (interactive)
    (let* ((file (buffer-file-name))
           (root (when (vc-root-dir) (expand-file-name (vc-root-dir))))
           (file (when (and file root) (s-chop-prefix root file))))
      (when (and root file)
        (message (format "Contributors for %s:\n%s" file (shell-command-to-string
          (format "git shortlog HEAD -s -n %s" file)))))))

  (defun gopar/last-sentence ()
    "Does the same as 'gopar/next-sentence' except it goes in reverse"
    (interactive)
    (re-search-backward "[.?!][   \n]+[A-Z]\\|\\.\\\\" nil t)
    (forward-char))

  (defvar gopar-ansi-escape-re
    (rx (or ?\233 (and ?\e ?\[))
        (zero-or-more (char (?0 . ?\?)))
        (zero-or-more (char ?\s ?- ?\/))
        (char (?@ . ?~))))

  (defun gopar/nuke-ansi-escapes (beg end)
    (save-excursion
      (goto-char beg)
      (while (re-search-forward gopar-ansi-escape-re end t)
        (replace-match ""))))

  (defun gopar/toggle-window-dedication ()
    "Toggles window dedication in the selected window."
    (interactive)
    (set-window-dedicated-p (selected-window)
                            (not (window-dedicated-p (selected-window)))))













(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6f1f6a1a3cff62cc860ad6e787151b9b8599f4471d40ed746ea2819fcd184e1a" "eca44f32ae038d7a50ce9c00693b8986f4ab625d5f2b4485e20f22c47f2634ae" "2e05569868dc11a52b08926b4c1a27da77580daa9321773d92822f7a639956ce" "680f62b751481cc5b5b44aeab824e5683cf13792c006aeba1c25ce2d89826426" "9685cefcb4efd32520b899a34925c476e7920725c8d1f660e7336f37d6d95764" default))
 '(org-agenda-files nil)
 '(org-fold-catch-invisible-edits 'show-and-error nil nil "Customized with use-package org")
 '(package-selected-packages
   '(django-mode all-the-icons markdown-mode markdown-preview-mode rust-mode rustic quarto-mode org-modern golden-ratio spacious-padding embark-consult all-the-icons-dired all-the-icons-gnus all-the-icons-nerd-fonts nerd-icons marginalia vertico vertico-posframe treemacs treemacs-all-the-icons treemacs-icons-dired treemacs-magit treemacs-projectile org-roam org-roam-bibtex doom-modeline doom-modeline-now-playing doom-themes org-roam-ui idle-org-agenda org-superstar org-beautify-theme org-clock-reminder org-inline-anim org-inline-pdf org-tag-beautify scala-mode sbt-mode yaml-mode web-mode simple-httpd rspec-mode rsense org json-mode jekyll-modes jedi ess))
 '(smtpmail-smtp-server "smtp.gmail.com"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
