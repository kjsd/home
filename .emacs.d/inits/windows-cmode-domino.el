;;; windows-cmode-domino.el --- cmode
;;; Commentary:
;;; Code:

(defun domino-c-mode-common-hook ()
  (setq c-basic-offset 3)
  (setq tab-width 3)
  (setq indent-tabs-mode nil)

  ;; switch文内のcaseのインデント
  (c-set-offset 'case-label '0)
  ;; namespace関係
  (c-set-offset 'namespace-open '0)
  (c-set-offset 'namespace-close '0)
  (c-set-offset 'innamespace '0)
  ;; case内のブロック
  (c-set-offset 'statement-case-open '0)
  ;; case内の処理一行目
  (c-set-offset 'statement-case-intro '+)
  ;; public/privateの位置
  (c-set-offset 'access-label '-)
  ;; ifなどの開き括弧
  (c-set-offset 'substatement-open '0)
  ;; 関数の開き括弧
  (c-set-offset 'defun-open '0)
  ;; class内のinline methodの開き括弧
  (c-set-offset 'inline-open '0)
  )

(add-hook 'c-mode-common-hook 'domino-c-mode-common-hook t)

;;; windows-cmode-domino.el ends here
