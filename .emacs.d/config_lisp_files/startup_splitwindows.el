;; Function 1. Grid layout

;; Split the current frame into a grid of X columns and Y rows
;; (split-window-multiple-ways 3 4) ;; will show 3 colummns, 4 rows

;; Function 2. Specific buffer setting

;;  "Set Xth horizontal and Yth vertical window to BUFFER from top-left of FRAME."
;;  set-window-buffer-in-frame x y buffer

(defun split-window-multiple-ways (x y)
  "Split the current frame into a grid of X columns and Y rows."
  (interactive "nColumns: \nnRows: ")
  ;; one window
  (delete-other-windows)
  (dotimes (i (1- x))
      (split-window-horizontally)
      (dotimes (j (1- y))
	(split-window-vertically))
      (other-window y))
  (dotimes (j (1- y))
    (split-window-vertically))
  (balance-windows))

(autoload 'windmove-find-other-window "windmove"
"Return the window object in direction DIR.

\(fn dir &optional arg window)")

(declare-function windmove-find-other-window "windmove" (dir &optional arg window))

(defun get-window-in-frame (x y &optional frame)
  "Find Xth horizontal and Yth vertical window from top-left of FRAME."
  (let ((orig-x x) (orig-y y)
        (w (frame-first-window frame)))
    (while (and (windowp w) (> x 0))
      (setq w (windmove-find-other-window 'right 1 w)
            x (1- x)))
    (while (and (windowp w) (> y 0))
      (setq w (windmove-find-other-window 'down 1 w)
            y (1- y)))
    (unless (windowp w)
      (error "No window at (%d, %d)" orig-x orig-y))
    w))

(defun set-window-buffer-in-frame (x y buffer &optional frame)
  "Set Xth horizontal and Yth vertical window to BUFFER from top-left of FRAME."
  (set-window-buffer (get-window-in-frame x y frame) buffer))


;; ;; Start these buffers automatically
(info)
;;(calendar)
;;(org-capture)
(defun four-window-split-custom ()
  "Bring back 3x3 window configuration with my favorite buffers."
  (interactive)
  (split-window-multiple-ways 2 2)
  (set-window-buffer-in-frame 0 0 (find-file (file-truename "/ffast/Documents/orgs/journal/current.md")))
  (set-window-buffer-in-frame 1 0 (find-file-noselect "/ffast/Documents/orgs/workflow.org"))
  (set-window-buffer-in-frame 0 1 (get-buffer "*info*"))
  (set-window-buffer-in-frame 1 1 (get-buffer "*scratch*"))
  
  )

