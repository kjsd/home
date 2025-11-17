;;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Plamo Linux ユーザ設定ファイルサンプル for emacs(mule)
;;            adjusted by M.KOJIMA, Chisato Yamauchi
;;                            Time-stamp: <2024-05-26 10:20:13 minoru>
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Plamo Linux の Emacs 21 (Mule) を利用するために必要な設定です。
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("gnu" . "https://elpa.gnu.org/packages/")))
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
  (require 'use-package)
  (require 'bind-key))

(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")

(use-package auto-async-byte-compile
  :config
  (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode))

(defun x->bool (elt) (not (not elt)))

(set-language-environment "Japanese")

(prefer-coding-system 'utf-8-unix)      ; デフォルトの文字コード
(set-default-coding-systems 'utf-8)     ; デフォルトの文字コード
(set-keyboard-coding-system 'utf-8)     ; キーボード
(set-terminal-coding-system 'utf-8)     ; ターミナル
(set-file-name-coding-system 'utf-8-hfs) ; ファイル名(Mac日本語の濁音/半濁音対応)

(set-default 'buffer-file-coding-system 'utf-8-unix) ; バッファー

;;; C-h と Del の入れ替え
;;; Help が Shift + Ctrl + h および Del に割当てられ、
;;; 前一文字削除が Ctrl + h に割当てられます
;(load-library "term/keyswap")
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)
(global-set-key "\C-H" 'help-command)

;;; 最終更新日の自動挿入
;;;   ファイルの先頭から 8 行以内に Time-stamp: <> または
;;;   Time-stamp: " " と書いてあれば、セーブ時に自動的に日付が挿入されます
(add-hook 'write-file-functions 'time-stamp)

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
(setq auto-save-default nil)
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

(add-to-list 'tramp-connection-properties
             (list (regexp-quote "/sshx:minoru@darkstar.local:")
                   "~minoru" "/Volumes/exports/Users/minoru"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; その他の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default fill-column 90)

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

(set-scroll-bar-mode 'left)

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
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default auto-fill-function 'do-auto-fill)

(add-hook 'switch-buffer-functions
          '(lambda (prev cur)
             (if (window-system)
                 (if (/= (frame-width) (+ fill-column 3))
                     (set-frame-width (selected-frame) (+ fill-column 3))))
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
  ;; (c-set-style "linux")
  
  (subword-mode)
  (google-set-c-style)
  (google-make-newline-indent)

  (setq auto-fill-function 'do-auto-fill)
  (defvar c-basic-offset 4)
  (defvar c-tab-always-indent t)
  (defvar c-echo-syntactic-infomation-p t)
  (defvar c-hungry-delete-key t)

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

  ;(gtags-mode 1)
  (helm-gtags-mode 1)
  (cpp-highlight-buffer t)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c++-mode-common-hook 'my-c-mode-common-hook)

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
       '(("\\.asp$" . web-mode))
       '(("\\.asa$" . web-mode))
       '(("\\.[l]?eex$" . web-mode))
       '(("\\.jsx$" . web-mode))
       '(("\\.tsx$" . web-mode))
       '(("\\.ino$" . arduino-mode))
       '(("\\.puml$" . plantuml-mode))
       auto-mode-alist))

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
             (turn-on-auto-fill)
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

;; web-mode (obsolated mmm-mode)
(require 'web-mode)
(defun my-web-mode-hook ()
  (setq auto-fill-function 'do-auto-fill)
  (setq web-mode-enable-auto-indentation nil)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-engines-alist
        '(("php"    . "\\.phtml$")
          ("blade"  . "\\.blade$")
          ("jsx"  . "\\.jsx$")))
  )

(add-hook 'web-mode-hook 'my-web-mode-hook)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-html-tag-face ((t (:foreground "#00bfff")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ChangeLogモードの設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq user-full-name "Kenji MINOURA")
(setq user-mail-address "info@kandj.org")

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

;; twittering-mode
(setq twittering-use-master-password t)
(setq twittering-connection-type-order
      '(wget curl urllib-http native urllib-https))
(setq twittering-use-master-password t)
(setq twittering-icon-mode t)

;; for ipad
(let ((translations '( 229 [?\M-a]  nil [?\M-b]   231 [?\M-c]  8706 [?\M-d]   nil [?\M-e]
                      402 [?\M-f]  169 [?\M-g]   729 [?\M-h]   nil [?\M-i]  8710 [?\M-j]
                      730 [?\M-k]  172 [?\M-l]   181 [?\M-m]   nil [?\M-n]   248 [?\M-o]
                      960 [?\M-p]  339 [?\M-q]   174 [?\M-r]   223 [?\M-s]  8224 [?\M-t]
                      nil [?\M-u] 8730 [?\M-v]  8721 [?\M-w]  8776 [?\M-x]   165 [?\M-y]
                      937 [?\M-z]
                      96 [?\M-~]  161 [?\M-1]   162 [?\M-4]   163 [?\M-3]   167 [?\M-6]
                      170 [?\M-9]  171 [?\M-\\]  175 [?\M-<]   176 [?\M-*]   177 [?\M-+]
                      182 [?\M-7]  183 [?\M-\(]  186 [?\M-0]   187 [?\M-|]   191 [?\M-\?]
                      198 [?\M-\"] 230 [?\M-']   247 [?\M-/]   728 [?\M->]  8211 [?\M-\-]
                      8212 [?\M-_] 8216 [?\M-\]] 8217 [?\M-}]  8218 [?\M-\)] 8220 [?\M-\[]
                      8221 [?\M-{] 8225 [?\M-&]  8226 [\?M-8]  8249 [?\M-#]  8250 [?\M-$]
                      8260 [?\M-!] 8364 [\?M-@]  8482 [?\M-2]  8734 [\?M-5]  8800 [?\M-=]
                      8804 [?\M-,] 8805 [?\M-.] 64257 [?\M-%] 64258 [?\M-^])))
(while translations
  (let ((key (car translations)) (def (cadr translations)))
    (if key
        (define-key key-translation-map (make-string 1 key) def)))
  (setq translations (cddr translations))))

;; start server
(require 'server)
(unless (server-running-p)
  (server-start))

(load-theme 'dark-laptop t)

(defun toggle-lang-hook ()
  (interactive)
  (cond
   ((string= current-language-environment "Japanese")
    (set-language-environment "Korean"))
   ((string= current-language-environment "Korean")
    (set-language-environment "Japanese")))
  )
(define-key ctl-x-map "\C-k" 'toggle-lang-hook)

(setq default-frame-alist
      (append
       '(
         (font . "Ricty-16")
         (alpha . 80)
         (height . 38)
         (width . 80)
         (cursor-color . "white")
         (set-frame-parameter (selected-frame)  'alpha  '(nil 70 50))
         (line-spacing . 0)
         )
       default-frame-alist))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(cd "~")

;; .emacs ends here
