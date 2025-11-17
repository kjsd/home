(setq default-input-method "japanese-skk")
(setq skk-large-jisyo "~/lib/dict/SKK-JISYO.L")
;(setq skk-server-prog "/usr/local/bin/google-ime-skk")
;(setq skk-server-inhibit-startup-server nil)
(setq skk-server-host "darkstar.local")
(setq skk-server-portnum 1178)
(setq skk-share-private-jisyo t)

;; 標準の skk-kutouten-type
(setq-default skk-kutouten-type 'en) ;; `jp' or `en'
(setq skk-rom-kana-rule-list '(("?" nil "？")
                               ("!" nil "！")))

;; C-x C-. で句読点の種類をトグル
(define-key ctl-x-map [?\C-.] 'skk-toggle-kutouten)

(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)

(defvar skk-isearch-mode-enable)
(add-hook 'isearch-mode-hook
          #'(lambda ()
              (when (and (boundp 'skk-mode)
                         skk-mode
                         skk-isearch-mode-enable)
                (skk-isearch-mode-setup))))
(add-hook 'isearch-mode-end-hook
          #'(lambda ()
              (when (and (featurep 'skk-isearch)
                         skk-isearch-mode-enable)
                (skk-isearch-mode-cleanup))))
