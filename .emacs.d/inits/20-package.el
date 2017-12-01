(use-package package
  :config
  (progn
    (package-initialize)
    (add-to-list 'package-archives
                 '("marmalade" . "http://marmalade-repo.org/packages/"))
    (add-to-list 'package-archives
                 '("melpa" . "http://melpa.milkbox.net/packages/") t)
    ))
(use-package auto-install
  :config
  (auto-install-compatibility-setup)
  (load-theme 'dark-laptop t t)
  (enable-theme 'dark-laptop)
  )
