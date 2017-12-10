;;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Plamo Linux ユーザ設定ファイルサンプル for emacs(mule)
;;            adjusted by M.KOJIMA, Chisato Yamauchi
;;                            Time-stamp: <2017-12-04 18:55:54 minoru>
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Plamo Linux の Emacs 21 (Mule) を利用するために必要な設定です。
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;; マクロサーチパスの追加
;;; ~/.emacs.d/lisp 以下にユーザ用の *.el, *.elc を置くことができます

(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

(setq load-path
      (append '("/usr/local/share/emacs/site-lisp")
              '("/opt/local/share/emacs/site-lisp")
              load-path))

(eval-when-compile
  (require 'use-package))

(use-package init-loader
  :config
  (setq init-loader-show-log-after-init nil)
  (init-loader-load "~/.emacs.d/inits")
  )

(use-package auto-async-byte-compile
  :config
  (add-hook 'emacs-lisp-mode-hook
            'enable-auto-async-byte-compile-mode)
  )

;;; 日本語環境 for Emacs21
;(require 'un-define)
;(require 'jisx0213)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)

(defun x->bool (elt) (not (not elt)))

;;; C-h と Del の入れ替え
;;; Help が Shift + Ctrl + h および Del に割当てられ、
;;; 前一文字削除が Ctrl + h に割当てられます
;(load-library "term/keyswap")
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)
(global-set-key "\C-H" 'help-command)

;;; 日本語メニューの文字コード
(setq menu-coding-system 'utf-8)

;;; プリンタ出力設定
(setq ps-multibyte-buffer 'non-latin-printer)
(require 'ps-mule)
;; Emacs-21のバグ(?)対策
;(defalias 'ps-mule-header-string-charsets 'ignore)
;; タイムスタンプ表示の調整など
(add-hook 'ps-print-hook
	  '(lambda ()
	     ;; プリンタ出力のコマンドを定義
;	     (setq ps-lpr-command "lpr")
;	     (setq ps-printer-name-option "-P")
	     ;; プリンタ名
;	     (setq ps-printer-name "lp")
;	     (setq ps-line-number t)
	     (load "time-stamp")
	     (setq ps-right-header
		   (list "/pagenumberstring load"
			 'time-stamp-yyyy/mm/dd
			 'time-stamp-hh:mm:ss))))

;;; メニューバーを日本語にします
;(if (equal (substring (concat (getenv "LANG") "__") 0 2) "ja")
;    (load "menu-tree"))

;;; 最終更新日の自動挿入
;;;   ファイルの先頭から 8 行以内に Time-stamp: <> または
;;;   Time-stamp: " " と書いてあれば、セーブ時に自動的に日付が挿入されます
(add-hook 'write-file-hooks 'time-stamp)

;;; マーク領域を色付け
(setq transient-mark-mode t)

;;; 最下行で「↓」を押したときスムーズなスクロールにする
(setq scroll-step 1)
(setq scroll-conservatively 4)
;;; PageUp,PageDown の時にカーソル位置を保持
(setq scroll-preserve-screen-position t)

;;; マウスの真ん中ボタンでペーストする時にカーソル位置を変更しない
;(setq mouse-yank-at-point t)

;;; カーソルの位置が何行何桁目かを表示する
(line-number-mode t)
;(column-number-mode t)

;;; カーソルが行頭にあるときに，C-k 1回で その行全体を削除
;(setq kill-whole-line t)

;;; 長い行を折り返して表示しない
;(set-default 'truncate-lines t)

;;; yes,no を答えるかわりに，y,n にする
;(fset 'yes-or-no-p 'y-or-n-p)

;;; ~つきのバックアップファイルを作らない
(setq make-backup-files nil)
;(setq auto-save-default nil)
(setq delete-auto-save-files t)

;;; visible-bell
(setq visible-bell nil)

;;; 起動直後の *scratch* buffer に入る文字列をなくす
;(setq initial-scratch-message nil)

;;; startup message を消す
;(setq inhibit-startup-message t)

;;; gzipされた日本語のinfoを見る
(auto-compression-mode t)

;;; shell-mode で ^M を出さなくする．
(add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)

;;; ステータスラインに時間を表示する
;(setq display-time-24hr-format t)
;(setq display-time-format "%m/%d(%a) %R")
;(setq display-time-day-and-date t)
;(setq display-time-interval 30)
;(display-time)

(setq-default tramp-default-method "sshx")

(setq-default fill-column 80)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ddskk
;;   Mule 上の仮名漢字変換システム SKK の設定
;;   C-x t でチュートリアルが起動します
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'skk-autoloads)
(setq default-input-method "japanese-skk")

;;; SKK-JISYO.L をメモリ上に読み込んで利用する場合
;(setq skk-large-jisyo "~/Library/Application Support/AquaSKK/SKK-JISYO.L")

;;; skkserv
(setq skk-server-host "localhost")
(setq skk-server-portnum 1178)
;(setq skk-server-prog "/usr/sbin/skkserv")
;(setq skk-server-jisyo "/usr/share/skk/SKK-JISYO.L")

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; YaTeX
;;   [La]TeX 入力モード
;;   M-x yatex とするか、.tex で終わるファイルを読み込むと起動します
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)

;; ;; *.tex *.html の拡張子を持つファイルを開いた場合，
;; ;; それぞれ yatex-mode, yahtml-mode にする．
(setq auto-mode-alist
       (cons (cons "\\.tex$" 'yatex-mode)
 	    auto-mode-alist))
; (setq auto-mode-alist
;       (cons (cons "\\.html$" 'yahtml-mode)
; 	    auto-mode-alist))

(setq YaTeX-kanji-code nil)
; (setq YaTeX-kanji-code 3)	; EUCにする
;; (setq yahtml-kanji-code 1)	; SJISにする
;(setq YaTeX-kanji-code 4)	; UTF-8
;(setq yahtml-kanji-code 4)	; UTF-8
;(setq yahtml-www-browser "firefox")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TiMidity interface for Emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(autoload 'timidity "timidity" "TiMidity Interface" t)
;(setq timidity-prog-path "/usr/bin/timidity")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; その他の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; abbrev key
(global-set-key "\C-x'" 'just-one-space)
(global-set-key "\M-o" 'dabbrev-expand)
(global-set-key "\M-/" 'expand-abbrev)
(eval-after-load "abbrev" '(global-set-key "\M-/" 'expand-abbrev))

;; アスキーテーブルの表示
(defun ascii-table ()
  "Print the ascii table. Based on a defun by Alex Schroeder <asc@bsiag.com>"
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))
  (let ((i 0))
    (while (< i 254)
      (setq i (+ i 1))
      (insert (format "%4d  0x%02x  %c\n" i i i))))
  (goto-char (point-min)))

;; バッファの DOS の改行文字を UNIX に変更
(defun dos2unix ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; バッファの UNIX の改行文字を DOS に変更
(defun unix2dos ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

;メニューバーを消す
(menu-bar-mode -1)

;ツールバーを消す
(tool-bar-mode -1)

;; 同一名の buffer があったとき、開いているファイルのパスの一部を表示して
;; 区別する
(when (locate-library "uniquify")
  (require 'uniquify)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;; 括弧の色づけ
(show-paren-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; モード別設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default auto-fill-function 'do-auto-fill)

(add-hook 'switch-buffer-functions
          '(lambda (prev cur)
             (if (window-system)
                 (if (/= (frame-width) fill-column)
                     (set-frame-width (selected-frame) fill-column)))
             )
          )

;;; my-c-mode
;(setq cpp-known-face 'invisible)
(setq cpp-known-face 'default)
(setq cpp-unknown-face 'highlight)
(setq cpp-face-type 'dark)
(setq cpp-known-writable 't)
(setq cpp-unknown-writable 't)
(setq cpp-edit-list
      '(("1" nil
         (background-color . "dim gray")
         both nil)
        ("0"
         (background-color . "dim gray")
         nil both nil)))

(defun my-c-mode-common-hook ()
  ;; (c-set-style "gnu")
  ;; (c-set-style "k&r")
  ;; (c-set-style "bsd")
  ;; (c-set-style "stroustrup")
  ;; (c-set-style "whitesmith")
  ;; (c-set-style "ellemtel")
  ;; (c-set-style "java")
  (c-set-style "linux")

  (c-set-offset 'case-label '0)
  (c-set-offset 'namespace-open '0)
  (c-set-offset 'namespace-close '0)
  (c-set-offset 'innamespace '0)
  (c-set-offset 'statement-case-open '0)
  (c-set-offset 'statement-case-intro '+)
  (c-set-offset 'access-label '-)
  (c-set-offset 'substatement-open '0)
  (c-set-offset 'defun-open '0)
  (c-set-offset 'inline-open '0)
  (c-set-offset 'inexpr-class '0)

  (setq c-basic-offset 4)
  (setq c-tab-always-indent t)
  ;;(setq c-comment-only-line-offset 0)
  (setq c-echo-syntactic-infomation-p t)
  (setq c-hungry-delete-key t)

  ;(gtags-mode 1)
  (helm-gtags-mode 1)
  (cpp-highlight-buffer t)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(setq auto-mode-alist
      (append
       '(("\\.h$" . c-mode))
       '(("\\.hpp$" . c++-mode))
       '(("\\.cs$" . csharp-mode))
       '(("\\.js$" . js2-mode))
       '(("\\.json$" . js-mode))
       '(("\\.gs$" . js2-mode))
       '(("\\.d[i]?$'" . d-mode))
       '(("\\.go$" . go-mode))
       '(("\\.phtml$'" . web-mode))
       '(("\\.tpl$" . web-mode))
       '(("\\.php$" . web-mode))
       '(("\\.[gj]sp$" . web-mode))
       '(("\\.as[cp]x$" . web-mode))
       '(("\\.erb$" . web-mode))
       '(("\\.mustache$" . web-mode))
       '(("\\.djhtml$" . web-mode))
       '(("\\.html?$" . web-mode))
       '(("\\.ejs$" . web-mode))
       '(("\\.twig$" . web-mode))
       auto-mode-alist))

;; java-mode
(add-hook 'java-mode-hook
          '(lambda ()
             (set-fill-column 100))
          )

;; js2-mode
(defun indent-and-back-to-indentation ()
  (interactive)
  (indent-for-tab-command)
  (let ((point-of-indentation
         (save-excursion
           (back-to-indentation)
           (point))))
    (skip-chars-forward "%s " point-of-indentation)))
(add-hook 'js2-mode-hook
          '(lambda ()
             (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)
             (setq js2-auto-indent-flag      nil
                   js2-basic-offset 2
                   js2-indent-tabs-mode nil
                   js2-cleanup-whitespace    nil
                   js2-enter-indents-newline nil
                   js2-mirror-mode           nil
                   js2-mode-escape-quotes    nil
                   js2-mode-squeeze-spaces   nil
                   js2-rebind-eol-bol-keys   nil)))

;; d-mode
(autoload 'd-mode "d-mode" "Major mode for editing D code." t)
(add-hook 'd-mode-hook
	  '(lambda ()
	     (c-toggle-auto-state)))

;; c#-mode
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)

;; go-mode
(autoload 'go-mode "go-mode" "Go language mode" t)
(add-hook 'go-mode-hook
	  '(lambda ()
         (setq c-basic-offset 2)
         (setq c-tab-always-indent t)
         ))

;; js-mode
(add-hook 'js-mode-hook
	  '(lambda ()
         (setq c-basic-offset 2)
         (setq c-tab-always-indent t)
         ))

;(setq load-path (cons "/usr/local/opt/erlang/lib/erlang/lib/tools-2.8.3/emacs"
;                      load-path))
;(setq erlang-root-dir "/usr/local/opt/erlang")
;(require 'erlang-start)

;; web-mode (obsolated mmm-mode)
(require 'web-mode)
(defun my-web-mode-hook ()
  (setq web-mode-enable-auto-indentation nil)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-engines-alist
        '(("php"    . "\\.phtml$")
          ("blade"  . "\\.blade$")))
  )

(add-hook 'web-mode-hook 'my-web-mode-hook)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-html-tag-face ((t (:foreground "#00bfff")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package yasnippet
  :config
  ;; companyと競合するのでyasnippetのフィールド移動は "C-i" のみにする
  (define-key yas-keymap (kbd "<tab>") nil)
  (yas-global-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; company-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package company
  :config
  (global-company-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; irony
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package irony
  :config
  (progn
    (custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
    (add-to-list 'company-backends 'company-irony)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
    (add-hook 'c-mode-hook 'irony-mode t)
    (add-hook 'c++-mode-hook 'irony-mode t)
    (add-hook 'objc-mode-hook 'irony-mode t)
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flycheck
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck
  :config
  (global-flycheck-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; w3m
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-find-file "w3m" "interface function for local file." t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "Search QUERY using SEARCH-ENGINE." t)
(autoload 'w3m-weather "w3m-weather" "Display weather report." t)
(autoload 'w3m-antenna "w3m-antenna" "Report chenge of WEB sites." t)

;; カーソル位置のリンクを標準のブラウザで開く
(defun w3m-view-this-url-with-external-browser ()
  (interactive)
  (w3m-print-this-url t)
  (w3m-view-url-with-external-browser (car kill-ring)))
(add-hook 'w3m-display-hook
          '(lambda ()
             (define-key w3m-minor-mode-map "\C-c\C-e" 'w3m-view-this-url-with-external-browser)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ChangeLogモードの設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq user-full-name "Kenji MINOURA")
(setq user-mail-address "kenji@kandj.org")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 拡張yank-pop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'yank-pop-forward "yank-pop-summary" nil t)
(autoload 'yank-pop-backward "yank-pop-summary" nil t)
(global-set-key "\M-y" 'yank-pop-forward)
(global-set-key "\C-\M-y" 'yank-pop-backward)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mic-paren
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(show-paren-mode 1) ; 対応する括弧に色をつける
(when (locate-library "mic-paren")
  (require 'mic-paren)
  (paren-activate)     ; activating
  (setq paren-face 'bold)
  (setq paren-match-face 'bold)
  (setq paren-sexp-mode t)
)
(setq parse-sexp-ignore-comments t) ;; コメント内のカッコは無視。

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; buffer-list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key [?\C-,] 'bs-cycle-next)
(global-set-key [?\C-.] 'bs-cycle-previous)
(global-set-key "\C-x\C-b" 'bs-show)

;(global-set-key "\C-x\C-b" 'buffer-menu-other-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; elscreen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(elscreen-start)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; vc-svn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'vc-handled-backends 'SVN)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sdic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
(global-set-key "\C-cw" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調
べる" t nil)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)
(setq sdic-default-coding-system 'utf-8)
(setq sdic-eiwa-dictionary-list
      '((sdicf-client "~/lib/dict/gene.sdic")))
(setq sdic-waei-dictionary-list
      '((sdicf-client "~/lib/dict/jedict.sdic")))

;; start server
(require 'server)
(unless (server-running-p)
  (server-start))

(cd "~")
;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(irony-additional-clang-options (quote ("-std=c++11")))
 '(package-selected-packages
   (quote
    (lua-mode flycheck-irony cmake-mode flycheck irony yasnippet company yatex web-mode w3m packed mic-paren js2-mode fuzzy erlang elscreen ddskk d-mode csharp-mode color-theme-modern auto-install))))
