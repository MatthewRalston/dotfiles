;; These are simple configurations for enabling flyspell mode in emacs


;; C-M-F8 : Spellcheck buffer
(global-set-key (kbd "C-M-<f10>") 'flyspell-buffer)
;; F8 : Spellcheck current word.
(global-set-key (kbd "<f10>") 'ispell-word)
;; M-F8 : Spellcheck previous highlighted word
(global-set-key (kbd "C-<f10>") 'flyspell-check-previous-highlighted-word)
;; C-F8 : Spellcheck next highlighted word
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "M-<f10>") 'flyspell-check-next-hightlighted-word)

;; C-Shift-F8 : Toggle flyspell mode
(global-set-key (kbd "C-S-<f10>") 'flyspell-mode)
