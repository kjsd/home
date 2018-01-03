;;; linux-local.el --- local setting
;;; Commentary:
;;; Code:

(setq default-frame-alist
      (append
       '(
         (font . "ricty diminished-18")
         (alpha . 80)
         (height . 38)
         (width . 80)
         (cursor-color . "white")
         (set-frame-parameter (selected-frame)  'alpha  '(nil 70 50))
         (line-spacing . 0)
         )
       default-frame-alist))

;;; linux-local.el ends here
