(setq org-todo-keywords
     '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))
(setq org-log-done 'time)
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; Automatic line wrap
(add-hook 'org-mode-hook
	  (lambda() (setq truncate-lines t)))
;;(set-default 'truncate-lines t)


;; org-roam
(setq org-roam-v2-ack t)
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Documents/orgs"))
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
(use-package org-roam-ui
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start nil))


;; Org-agenda defaults
(setq org-agenda-files '("~/notes.org"
			 "~/tasks.org"))
(setq org-deadline-warning-days 7)
;; Org-agenda on idle
(require 'idle-org-agenda)
(add-hook 'org-mode-hook
	  (lambda () (idle-org-agenda-mode t)))
(setq idle-org-agenda-interval 300)


;; Org-capture defaults
(setq org-directory "~/Documents/org/")
(setq org-default-notes-file "~/refile.org")

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/tasks.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/Documents/journal.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/refile.org")
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

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)


;; Display preferences
;; (add-hook 'org-mode-hook
;; 	  (lambda ()
;; 	    (load-theme 'org-beautify)))
(add-hook 'org-mode-hook
	  (lambda() (org-superstar-mode 1)))
(setq org-startup-with-inline-images t)



;; Keybinding overrides
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
