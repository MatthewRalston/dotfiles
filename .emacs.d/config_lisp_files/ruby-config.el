;;(setq enh-ruby-program "/Users/Matthew/.rvm/ruby-2.0.0-p247/bin/ruby")
;;(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
;;(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))


(setq rsense-home "/Users/Matthew/opt/rsense-0.3")
(add-to-list 'load-path (concat rsense-home "/etc"))
(add-to-list 'load-path "/Users/Matthew/.emacs.d/elpa/rsense-20100510.2105/")
(require 'rsense)
;;(add-hook 'ruby-mode-hook
;;          (lambda ()
;;            (local-set-key [tab] 'rsense-complete)))
(add-hook 'ruby-mode-hook 'auto-complete-mode)
(add-hook 'ruby-mode-hook
	  (lambda ()
            (local-set-key [C-tab] 'ac-complete-rsense)))


(add-to-list 'auto-mode-alist
               '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
