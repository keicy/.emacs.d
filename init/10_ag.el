(bundle ag
  (with-eval-after-load-feature 'ag
    (setq ag-highlight-search t)     ; 検索キーワードをハイライト
    (setq ag-reuse-buffers t)   ; 検索用バッファを使い回す
    ;(setq ag-reuse-window 'nil)      ; 現在のウィンドウを検索結果表示に使う
    ;(setq ag-reuse-buffers 'nil)    ; 現在のバッファを検索結果表示に使う
  )
)

;;; Util Functions

;; ag開いたらagのバッファに移動する
;;@export
(defun ag-at-hand ()
  (interactive)
  (call-interactively 'ag)
  (select-window ; select ag buffer
    (car (my/get-buffer-window-list-regexp "^\\*ag "))))

;;; Helpers

;; ag開いたらagのバッファに移動するための補助関数
(defun my/filter (condp lst)
  (delq nil
        (mapcar (lambda (x) (and (funcall condp x) x)) lst)))
(defun my/get-buffer-window-list-regexp (regexp)
  "Return list of windows whose buffer name matches regexp."
  (my/filter #'(lambda (window)
              (string-match regexp
               (buffer-name (window-buffer window))))
          (window-list)))
