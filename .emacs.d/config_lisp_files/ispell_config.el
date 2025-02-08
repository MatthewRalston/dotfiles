(use-package ispell
  :ensure nil
  :custom
  (ispell-program-name "aspell")
  (ispell-personal-dictionary (concat user-emacs-directory "etc/.aspell.lang.pws"))
  (ispell-dictionary nil)
  (ispell-local-dictionary nil)
  (ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"
                       "--run-together" "--run-together-limit=16"
                       "--camel-case"))
  :init
  (defun gopar/add-word-to-dictionary ()
    (interactive)
    (let ((word (word-at-point)))
      (append-to-file (concat word "\n") nil ispell-personal-dictionary)
      (message "Added '%s' to %s" word ispell-personal-dictionary))))

(use-package flyspell
  :ensure nil
  :defer
  :hook ((prog-mode . flyspell-prog-mode)
         (org-mode . flyspell-mode)
         (text-mode . flyspell-mode)
         (flyspell-mode . (lambda ()
                            (set-face-attribute 'flyspell-incorrect nil :underline '(:style wave :color "Red1"))
                            (set-face-attribute 'flyspell-duplicate nil :underline '(:style wave :color "DarkOrange")))))
  :bind (:map flyspell-mode-map
              ("C-;" . nil)
              ("C-," . flyspell-goto-next-error)
              ("C-." . flyspell-auto-correct-word)))
