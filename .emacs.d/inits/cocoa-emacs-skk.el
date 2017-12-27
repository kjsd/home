(setq default-input-method "japanese-skk")
(setq skk-server-prog "/usr/local/bin/google-ime-skk")
(setq skk-server-inhibit-startup-server nil)
(setq skk-server-host "localhost")
(setq skk-server-portnum 55100)
(setq skk-share-private-jisyo t)

;; 標準の skk-kutouten-type
(setq-default skk-kutouten-type 'en) ;; `jp' or `en'
(setq skk-rom-kana-rule-list
      '(("?" nil "？")
        ("!" nil "！")))

;; C-x C-. で句読点の種類をトグル
(define-key ctl-x-map [?\C-.] 'skk-toggle-kutouten)

(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)

(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "open")

(add-hook 'isearch-mode-hook
          (function (lambda ()
                      (and (boundp 'skk-mode) skk-mode
                           (skk-isearch-mode-setup)))))

(load-theme 'dark-laptop t)
