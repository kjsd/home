(use-package helm-gtags
  :config
  (setq helm-gtags-auto-update t)
  (add-hook 'helm-gtags-mode-hook
            '(lambda ()
               (local-set-key (kbd "M-.") 'helm-gtags-find-tag)
               (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)  
               (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
               (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)
               ))
  (add-hook 'helm-gtags-select-mode-hook
            '(lambda ()
               (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)
               (local-set-key (kbd <return>) 'helm-gtags-select-tag)
               ))

  (add-hook 'php-mode-hook 'helm-gtags-mode)
  (add-hook 'ruby-mode-hook 'helm-gtags-mode)
  )

