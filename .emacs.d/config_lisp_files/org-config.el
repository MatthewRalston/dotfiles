

;; https://stackoverflow.com/a/10091330/2178312
(use-package org
  :defer
  :custom
  (setq org-todo-keywords
     '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))
  (setq org-log-done 'time)
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate)

  (org-agenda-include-diary t)
  ;; Where the org files live
  (org-directory "~/Documents/orgs/")
  ;; Where archives should go
  (org-archive-location (concat (expand-file-name "~/.emacs.d/.archives.org") "::"))
  ;; Make sure we see syntax highlighting
  (org-src-fontify-natively t)
  ;; I dont use it for subs/super scripts
  (org-use-sub-superscripts nil)
  ;; Should everything be hidden?
  (org-startup-folded 'content)
  (org-M-RET-may-split-line '((default . nil)))
  ;; Don't hide stars
  (org-hide-leading-stars nil)
  (org-hide-emphasis-markers nil)
  ;; Show as utf-8 chars
  (org-pretty-entities t)
  ;; put timestamp when finished a todo
  (org-log-done 'time)
  ;; timestamp when we reschedule
  (org-log-reschedule t)
  ;; Don't indent the stars
  (org-startup-indented nil)
  (org-list-allow-alphabetical t)
  (org-image-actual-width nil)
  ;; Save notes into log drawer
  (org-log-into-drawer t)
  ;;
  (org-fontify-whole-heading-line t)
  (org-fontify-done-headline t)
  ;;
  (org-fontify-quote-and-verse-blocks t)
  ;; See down arrow instead of "..." when we have subtrees
  ;; (org-ellipsis "⤵")
  ;; catch invisible edit
  ( org-catch-invisible-edits 'show-and-error)
  ;; Only useful for property searching only but can slow down search
  (org-use-property-inheritance t)
  ;; Count all children TODO's not just direct ones
  (org-hierarchical-todo-statistics nil)
  ;; Unchecked boxes will block switching the parent to DONE
  (org-enforce-todo-checkbox-dependencies t)
  ;; Don't allow TODO's to close without their dependencies done
  (org-enforce-todo-dependencies t)
  (org-track-ordered-property-with-tag t)
  ;; Where should notes go to? Dont even use them tho
  (org-default-notes-file (concat org-directory "notes.org"))
  ;; The right side of | indicates the DONE states
  (org-todo-keywords
   '((sequence "TODO(t)" "NEXT(n)" "IN-PROGRESS(i!)" "WAITING(w!)" "FEEDBACK(f!)" "|" "DONE(d!)" "CANCELED(c!)" "DELEGATED(p!)")))
  ;; Needed to allow helm to compute all refile options in buffer
  (org-outline-path-complete-in-steps nil)
  (org-deadline-warning-days 2)
  (org-log-redeadline t)
  (org-log-reschedule t)
  ;; Repeat to previous todo state
  ;; If there was no todo state, then dont set a state
  (org-todo-repeat-to-state t)
  ;; Refile options
  (org-refile-use-outline-path 'file)
  (org-refile-allow-creating-parent-nodes 'confirm)
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((sql . t)
     (sqlite . t)
     (python . t)
     (java . t)
     ;; (cpp . t)
     (C . t)
     (emacs-lisp . t)
     (shell . t)))
  ;; Save history throughout sessions
  (org-clock-persistence-insinuate))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; t e h    O l d      C o n f i g

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-tree-slide-mode
;; (define-key org-mode-map (kbd "<f9>") 'org-tree-slide-mode)
;; (define-key org-mode-map (kbd "S-<f9>") 'org-tree-slide-skip-done-toggle)

;; Option 1: Per buffer
(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

;; Option 2: Globally
(with-eval-after-load 'org (global-org-modern-mode))

;; org-roam
(setq org-roam-v2-ack t)
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Documents/orgs/roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
	 ("C-M-i" . completion-at-point))
  :config
  (org-roam-db-autosync-mode)
  (org-roam-setup))

(add-hook 'org-roam-mode
	  (lambda() (setq org-roam-completion-everywhere t)))
;;(setq org-roam-completion-everywhere t)

;; org-roam-ui
;; (use-package org-roam-ui
;;     :config
;;     (setq org-roam-ui-sync-theme t
;;           org-roam-ui-follow t
;;           org-roam-ui-update-on-save t
;;           org-roam-ui-open-on-start nil))


;; org-calDav
;; (use-package org-caldav
;;   :config
;;   (setq org-caldav-oauth2-client-id ""
;; 	org-caldav-oauth2-client-secret ""
;; 	org-caldav-url 'google
;; 	org-caldav-calendar-id "vhbk922u116uc7sa45gil0r9fk@group.calendar.google.com"
;; 	org-caldav-inbox "~/Documents/orgs/org-caldav.org"
;; 	org-caldav-files '("~/tasks.org")
;; 	))

;; Org-agenda defaults
(setq org-agenda-files '("~/notes.org"
			 "~/tasks.org"
			 "~/Documents/orgs/roam/master.org"))
(setq org-deadline-warning-days 7)
;; Org-agenda on idle
(require 'idle-org-agenda)
(add-hook 'org-mode-hook
	  (lambda () (idle-org-agenda-mode t)))
(setq idle-org-agenda-interval 300)


;; Org-capture defaults
(setq org-directory "~/Documents/orgs/")
(setq org-default-notes-file "~/refile.org")

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/tasks.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/notes.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/Documents/orgs/journal.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/protocols.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))


;; org-capture Refile + IDO
; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)



;; Display preferences
;; (add-hook 'org-mode-hook
;; 	  (lambda ()
;; 	    (load-theme 'org-beautify)))
;; (add-hook 'org-mode-hook
;; 	  (lambda() (org-superstar-mode 1)))
(setq org-startup-with-inline-images t)
;; Automatic line wrap
;; (add-hook 'org-mode-hook
;; 	   (setq truncate-lines t))
;;         (lambda() (setq truncate-lines t)))
;; (set-default 'truncate-lines t)
;; 

;; Keybinding overrides
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(define-key org-mode-map "\M-l" 'toggle-truncate-lines)

