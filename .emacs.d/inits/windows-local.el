;;; windows-local.el --- local setting
;;; Commentary:

;;; Code:
(if window-system
    (progn
      (create-fontset-from-ascii-font
       "Ricty-12:weight=normal:slant=normal" nil "default")
      (set-fontset-font "fontset-default"
                        'unicode
                        (font-spec :family "Ricty" :size 14)
                        nil
                        'append)
      (set-scroll-bar-mode 'left)
      (setq default-frame-alist
            (append
              '(;(foreground-color . "white")
                ;(background-color . "black")
                (font . "fontset-default")
                (alpha . 80)
                (height . 38)
                (width . 80)
                (cursor-color . "white")
                (set-frame-parameter (selected-frame)  'alpha  '(nil 70 50))
;                (line-spacing . 0)
              )
             default-frame-alist))
      ))

;;; windows-local.el ends here
