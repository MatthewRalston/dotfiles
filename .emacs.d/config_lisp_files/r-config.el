

(setq load-path 
      (append (list "/home/matt/.emacs.d/elpa/" "/home/matt/pckges/polymode" "/home/matt/pckges/poly-markdown")
	      load-path))

(require 'ess-site)

;; Thank you  vitoshka/polymode
(require 'poly-R)
;; Thank you to the many contributors of polymode, it has become a really transformative project.
;; I can't believe how cool lisp is though maybe that's what i'll learn next.
(require 'poly-markdown)

(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))



;; Thanks to John Geddes for helping me see the light
;; http://johnstantongeddes.org/open%20science/2014/03/26/Rmd-polymode.html

;; Thank you to Stefan Avey for the lesson, most impressive...
;; Beautiful elisp, i'm still not a big fan of programming Python in Emacs until very recently.
;;  Thanks

;; Uh so here is Stefan's code defined with a kdb shortcut 'C-c r'
;; Wonder if he's a credence clearwater revival fan.

;; spa/rmd-render
;; Global history list allows Emacs to "remember" the last
;; render commands and propose as suggestions in the minibuffer.
(defvar rmd-render-history nil "History list for spa/rmd-render.")
(defun rmd-render (arg)
  "Render the current Rmd file to PDF output.
   With a prefix arg, edit the R command in the minibuffer"
  (interactive "P")
  ;; Build the default R render command
  (setq rcmd (concat "rmarkdown::render('" buffer-file-name "',"
                 "output_dir = '../reports',"
                 "output_format = 'pdf_document')"))
  ;; Check for prefix argument
  (if arg
      (progn
    ;; Use last command as the default (if non-nil)
    (setq prev-history (car rmd-render-history))
    (if prev-history
        (setq rcmd prev-history)
      nil)
    ;; Allow the user to modify rcmd
    (setq rcmd
          (read-from-minibuffer "Run: " rcmd nil nil 'rmd-render-history))
    )
    ;; With no prefix arg, add default rcmd to history
    (setq rmd-render-history (add-to-history 'rmd-render-history rcmd)))
  ;; Build and evaluate the shell command
  (setq command (concat "echo \"" rcmd "\" | R --vanilla"))
  (compile command))
(define-key polymode-mode-map (kbd "C-c r")  'spa/rmd-render)
