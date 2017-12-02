(use-package helm-gtags
  :config
  (setq helm-gtags-auto-update t)
  (add-hook 'helm-gtags-mode-hook
            '(lambda ()
               ;;入力されたタグの定義元へジャンプ
               (local-set-key (kbd "M-.") 'helm-gtags-find-tag)

               ;;入力タグを参照する場所へジャンプ
               (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)  

               ;;入力したシンボルを参照する場所へジャンプ
               (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)

               ;;タグ一覧からタグを選択し, その定義元にジャンプする
               (local-set-key (kbd "<return>") 'helm-gtags-select)

               ;;ジャンプ前の場所に戻る
               (global-set-key (kbd "C-t") 'helm-gtags-pop-stack)
               ))

  (add-hook 'php-mode-hook 'helm-gtags-mode)
  (add-hook 'ruby-mode-hook 'helm-gtags-mode)
  )
