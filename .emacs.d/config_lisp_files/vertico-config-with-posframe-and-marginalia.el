;; Taken with courtesy from Protesilaos, found on YouTube. Emacs configuration for Vertico with Marginalia,
;; adapted for vertico-posframe, 404 unavailable on Melpa currently.


;; Further reading: https://protesilaos.com/emacs/dotemacs

(use-package vertico
  :ensure t
  :config
  (setq vertico-cycle t)
  (setq vertico-resize nil)
  (vertico-mode 1))


(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))

;;(use-package 'vertico-posframe)
(load "/home/matt/.emacs.d/config_lisp_files/vertico-posframe.el")
(vertico-posframe-mode 1)
;; (vertico-posframe-parameters
;;  '((left-fringe . 8)
;;    (right-fringe . 8)))


;; Also from Protesilaos
(savehist-mode 1)

