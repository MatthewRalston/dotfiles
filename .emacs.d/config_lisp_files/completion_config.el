;; Taken with courtesy from Gopar/.emacs.d

(use-package vertico
  :ensure t
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy)
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t))

(use-package vertico-multiform
  :ensure nil
  :hook (after-init . vertico-multiform-mode)
  :init
  (setq vertico-multiform-commands
        '((consult-line (:not posframe))
          (gopar/consult-line (:not posframe))
          (consult-ag (:not posframe))
          (consult-grep (:not posframe))
          (consult-imenu (:not posframe))
          (xref-find-definitions (:not posframe))
          (t posframe))))

;; just for looks

(use-package dabbrev
  :custom
  (dabbrev-upcase-means-case-search t)
  (dabbrev-check-all-buffers nil)
  (dabbrev-check-other-buffers t)
  (dabbrev-friend-buffer-function 'dabbrev--same-major-mode-p)
  (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'")))

;;(use-package corfu
;;  :ensure t
;;  ;; Optional customizations
;;  :custom
;;  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
;;  (corfu-auto t)                 ;; Enable auto completion
;;  (corfu-on-exact-match 'insert) ;; Insert when there's only one match
;;  (corfu-quit-no-match t)        ;; Quit when ther is no match
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary

  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-excluded-modes'.
;;  :init
;;  (setq corfu-exclude-modes '(eshell-mode))
;;  (global-corfu-mode)

;;  (defun corfu-enable-always-in-minibuffer ()
;;    "Enable Corfu in the minibuffer if Vertico/Mct are not active."
;;    (unless (or (bound-and-true-p mct--active)
;;                (bound-and-true-p vertico--input)
;;                (eq (current-local-map) read-passwd-map))
;;      ;; (setq-local corfu-auto nil) ;; Enable/disable auto completion
;;      (setq-local corfu-echo-delay nil ;; Disable automatic echo and popup
;;                  corfu-popupinfo-delay nil)
;;      (corfu-mode 1)))

;;  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1))

(use-package cape
  :ensure t
  :bind ("C-c SPC" . cape-dabbrev)
  :custom
  (cape-dict-case-replace nil)
  :init
  (setq cape-dabbrev-min-length 2)
  (setq cape-dabbrev-check-other-buffers 'cape--buffers-major-mode)

  (defun gopar/cape-dict-only-in-comments ()
    (cape-wrap-inside-comment 'cape-dict))
  (defun gopar/cape-dict-only-in-strings ()
    (cape-wrap-inside-string 'cape-dict))

  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'gopar/cape-dict-only-in-strings)
  (add-to-list 'completion-at-point-functions #'gopar/cape-dict-only-in-comments)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  )

(use-package orderless
  :ensure t
  :after consult
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :ensure
  :after projectile
  :bind (("C-s" . consult-line)
         ("C-c M-x" . consult-mode-command)
         ("C-x b" . consult-buffer)
         ("C-x r b" . consult-bookmark)
         ("M-y" . consult-yank-pop)
         ;; M-g bindings (goto-map)
         ("M-g M-g" . consult-goto-line)
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("C-z" . consult-theme)
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history)
         :map projectile-command-map
         ("b" . consult-project-buffer)
         :map prog-mode-map
         ("M-g o" . consult-imenu))

  :init
  (defun remove-items (x y)
    (setq y (cl-remove-if (lambda (item) (memq item x)) y))
    y)

  ;; Any themes that are incomplete/lacking don't work with centaur tabs/solair mode
  (setq gopar/themes-blacklisted '(
                                   ;; doom-tomorrow-night
                                   ayu-dark
                                   ayu-light
                                   doom-acario-dark
                                   doom-acario-light
                                   doom-homage-black
                                   doom-lantern
                                   doom-manegarm
                                   doom-meltbus
                                   doom-rougue
                                   light-blue
                                   manoj-black
                                   tao
                                   ))
  (setq consult-themes (remove-items gopar/themes-blacklisted (custom-available-themes)))
  (setq consult-project-function (lambda (_) (projectile-project-root)))
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  (setq consult-narrow-key "<")
  (setq consult-line-start-from-top nil)

  (defun gopar/consult-line (&optional arg)
    "Start consult search with selected region if any.
If used with a prefix, it will search all buffers as well."
    (interactive "p")
    (let ((cmd (if current-prefix-arg '(lambda (arg) (consult-line-multi t arg)) 'consult-line)))
      (if (use-region-p)
          (let ((regionp (buffer-substring-no-properties (region-beginning) (region-end))))
            (deactivate-mark)
            (funcall cmd regionp))
        (funcall cmd "")))))

(use-package consult-ag
  :ensure
  :defer
  :bind (:map projectile-command-map
              ("s s" . consult-ag)
              ("s g" . consult-grep)))

(use-package consult-org-roam
  :ensure t
  :after org-roam
  :init
  (require 'consult-org-roam)
  ;; Activate the minor mode
  (consult-org-roam-mode 1)
  :custom
  (consult-org-roam-grep-func #'consult-ag)
  ;; Configure a custom narrow key for `consult-buffer'
  (consult-org-roam-buffer-narrow-key ?r)
  ;; Display org-roam buffers right after non-org-roam buffers
  ;; in consult-buffer (and not down at the bottom)
  (consult-org-roam-buffer-after-buffers nil)
  :config
  ;; Eventually suppress previewing for certain functions
  (consult-customize
   consult-org-roam-forward-links
   :preview-key (kbd "M-.")))

(use-package marginalia
  :ensure
  :init
  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

(use-package embark
  :ensure t
  :defer
  :bind (("C-." . embark-act)))

(use-package embark-consult
  :ensure t
  :after embark)
