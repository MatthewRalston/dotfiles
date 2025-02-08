(use-package chatgpt-shell
  :ensure t
  :commands (chatgpt-shell--primary-buffer chatgpt-shell chatgpt-shell-prompt-compose)
  :bind (("C-x m" . chatgpt-shell)
         ("C-c C-e" . chatgpt-shell-prompt-compose))
  :hook (chatgpt-shell-mode . (lambda () (setq-local completion-at-point-functions nil)))
  :init
  (setq shell-maker-root-path (concat user-emacs-directory "var/"))
  (add-to-list 'display-buffer-alist
               '("\\*chatgpt\\*"
                 display-buffer-in-side-window
                 (side . right)
                 (slot . 0)
                 (window-parameters . ((no-delete-other-windows . t)))
                 (dedicated . t)))

  :bind (:map chatgpt-shell-mode-map
               (("RET" . newline)
               ("M-RET" . shell-maker-submit)
               ("M-." . dictionary-lookup-definition)))
  :custom
  (shell-maker-prompt-before-killing-buffer nil)
  (chatgpt-shell-openai-key
   (auth-source-pick-first-password :host "api.openai.com"))
  (chatgpt-shell-transmitted-context-length 5)
  (chatgpt-shell-model-versions '("gpt-4o")))
