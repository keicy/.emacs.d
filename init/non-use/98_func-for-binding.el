;;ウィンドウ切り替え
;;移動時にカーソルを1つ進める
;;分割していない時に押すと分割する
(defun keicy-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1)
  (forward-char 1))

;;末尾に移動して改行
(defun keicy-endline-newline-indent ()
  (interactive)
  (end-of-line)
  (newline-and-indent))
  
;;ruby-modeで、スクリプトを即実行するコマンド
;;モジュールとしてのファイルではなくスクリプトとして書かれたファイルを
;;頭から下まで実行する
;;主にプロコン用
;;;;;使い方
;;.rbスクリプトファイルを開いている状態で呼ぶと、初回起動ならirbを起動しつつ、ファイル内容を実行する
;(defun keicy-ruby-script-runner ()
;  (interactive)
;  (unless (get-buffer "*ruby*") ;REPLが起動していなければ起動
;    (inf-ruby)) 
;  (if (eq (current-buffer) (get-buffer "*ruby*"))
;    (previous-multiframe-window)) ;もしソースのウィンドウにいないならそれに戻る。(other-window 1)でも良い。
;  (setq bounds (bounds-of-thing-at-point 'page))
;  (ruby-send-region-and-go (car bounds) (cdr bounds))
;  (end-of-buffer))

;todo
;;;;自動でリージョン選択してカーソル移動
