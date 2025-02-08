;; DOOM emacs dashboard

(use-package dashboard
  :ensure t
  :custom
  (dashboard-startup-banner 'logo)
  (dashboard-center-content t)
  (dashboard-show-shortcuts nil)
  (dashboard-set-heading-icons t)
  (dashboard-icon-type 'all-the-icons)
  (dashboard-set-file-icons t)
  (dashboard-projects-backend 'projectile)
  (dashboard-items '(
                     (vocabulary)
                     (recents . 5)
                     (bookmarks . 5)
                     ;; (monthly-balance)
                     ))
  (dashboard-item-generators '(;; (monthly-balance . gopar/dashboard-ledger-monthly-balances)
                              (vocabulary . gopar/dashboard-insert-vocabulary)
                              (recents . dashboard-insert-recents)
                              (bookmarks . dashboard-insert-bookmarks)
                              ))
  :init
  (defun gopar/dashboard-insert-vocabulary (list-size)
    (dashboard-insert-heading "Word of the Day:"
                              nil
                              (all-the-icons-faicon "newspaper-o"
                                                    :height 1.2
                                                    :v-adjust 0.0
                                                    :face 'dashboard-heading))
    (insert "\n")
    (let ((random-line nil)
          (lines nil))
      (with-temp-buffer
        (insert-file-contents (concat user-emacs-directory "words"))
        (goto-char (point-min))
        (setq lines (split-string (buffer-string) "\n" t))
        (setq random-line (nth (random (length lines)) lines))
        (setq random-line (string-join (split-string random-line) " ")))
      (insert "    " random-line)))

  (defun gopar/dashboard-ledger-monthly-balances (list-size)
    (interactive)
    (dashboard-insert-heading "Monthly Balance:"
                              nil
                              (all-the-icons-faicon "money"
                                                    :height 1.2
                                                    :v-adjust 0.0
                                                    :face 'dashboard-heading))
    (insert "\n")
    (let* ((categories '("Expenses:Food:Restaurants"
                         "Expenses:Food:Groceries"
                         "Expenses:Misc"))
           (current-month (format-time-string "%Y/%m"))
           (journal-file (expand-file-name "~/personal/finances/main.dat"))
           (cmd (format "ledger bal --flat --monthly --period %s %s -f %s"
                        current-month
                        (mapconcat 'identity categories " ")
                        journal-file)))

      (insert (shell-command-to-string cmd))))
  :config
  (dashboard-setup-startup-hook))
