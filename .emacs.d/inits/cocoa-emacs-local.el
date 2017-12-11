;;; cocoa-emacs-local.el --- local setting
;;; Commentary:
;;; Code:

(if window-system
    (progn
      (create-fontset-from-ascii-font
       "Ricty Diminished-14:weight=normal:slant=normal" nil "default")
      (set-fontset-font "fontset-default"
                        'unicode
                        (font-spec :family "Ricty" :size 14)
                        nil
                        'append)
      (create-fontset-from-ascii-font
       "AppleGothic-14:weight=normal:slant=normal" nil "hangeul")
      (set-fontset-font "fontset-hangeul"
                        'unicode
                        (font-spec :family "AppleGothic" :size 14)
                        nil
                        'append)

      (set-scroll-bar-mode 'left)
      (setq default-frame-alist
            (append
             '(
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

(defun toggle-lang-hook ()
  (interactive)
  (cond
   ((string= current-language-environment "Japanese")
    (set-language-environment "Korean"))
   ((string= current-language-environment "Korean")
    (set-language-environment "Japanese")))
  )
(define-key ctl-x-map "\C-k" 'toggle-lang-hook)

(setq ns-option-modifier 'meta)
(setq ns-command-modifier 'meta)

;;; cocoa-emacs-local.el ends here
