(use-package treemacs
  :ensure t
  :custom (treemacs-is-never-other-window t)
  :hook (treemacs-mode . treemacs-project-follow-mode))
