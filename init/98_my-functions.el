;; init.el リロード
(defun i ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))


;;ウィンドウ切り替え
;;移動時にカーソルを1つ進める
;;分割していない時に押すと分割する
(defun keicy-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1)
  (forward-char 1))
  
;;;;ruby-modeで、スクリプトを即実行するコマンド
;;;;モジュールとしてのファイルではなくスクリプトとして書かれたファイルを
;;;;頭から下まで実行する
;;;;主にプロコン用
;;;;;;;;;使い方
;;;;.rbスクリプトファイルを開いている状態で呼ぶと、初回起動ならirbを起動しつつ、ファイル内容を実行する
(defun keicy-ruby-script-runner ()
  (interactive)
  (unless (get-buffer "*ruby*") ;REPLが起動していなければ起動
    (inf-ruby)) 
  (if (eq (current-buffer) (get-buffer "*ruby*"))
    (previous-multiframe-window)) ;もしソースのウィンドウにいないならそれに戻る。(other-window 1)でも良い。
  (setq bounds (bounds-of-thing-at-point 'page))
  (ruby-send-region-and-go (car bounds) (cdr bounds))
  (end-of-buffer))

;;末尾に移動して改行
(defun keicy-endline-newline-indent ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

;;行削除 (キルリングに登録しない)
(defun keicy-delete-line-nokillring ()
  (interactive)
  (setq bounds (bounds-of-thing-at-point 'line))
  (delete-region (car bounds) (cdr bounds)))

(defun my-forward-list (&optional arg)
  "Do `forward-list' and `backward-sexp'."
  (interactive "p")
  (or arg (setq arg 1))
  (let ((start (point))
        end)
    (if (and (= arg 1)
             (= start (scan-sexps (scan-lists start 1 0) -1)))
        (setq end (scan-lists start 2 0))
      (setq end (scan-lists start arg 0)))
    (goto-char (or (and end (scan-sexps end -1))
                   (buffer-end arg)))))


;todo
;;;;自動でリージョン選択してカーソル移動


;;;;-----------------------;
;; for Lisp
;;;;-----------------------;

;;一文字進んで改行し"()"を挿入
(defun keicy-cl-newline ()
  (interactive)
  (forward-char)
  (newline-and-indent)
  (insert "()")
  (backward-char))
