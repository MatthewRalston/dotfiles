(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'reftex-mode-hook 'imenu-add-menubar-index)
(getenv "PATH")
 (setenv "PATH"
(concat
 "/usr/texbin" ":"
(getenv "PATH")))
(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook '(flyspell-mode t))

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;(add-hook 'latex-mode-hook 'flyspell-mode)
;(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)
