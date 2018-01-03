(use-package golden-ratio
             :config
             (golden-ratio-mode 1)

             ;;; 条件に応じてウィンドウの大きさを変更しない
             ;; ウィンドウの大きさを変更しないメジャーモード
             (setq golden-ratio-exclude-modes '(calendar-mode))
             ;; ウィンドウの大きさを変更しないバッファ名
             (setq golden-ratio-exclude-buffer-names
                   '(" *Org tags*" " *Org todo*"))
             ;; ウィンドウの大きさを変更しないバッファ名の正規表現
             (setq golden-ratio-exclude-buffer-regexp
                   '("\\*anything" "\\*helm"))
             ;; ウィンドウ選択系のコマンドで作用させる
             (setq golden-ratio-extra-commands
                   '(windmove-left windmove-right windmove-down windmove-up))
             )             
 
