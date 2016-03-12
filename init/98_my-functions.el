;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Utils.

;; init.el リロード
(defun i ()
  (interactive)
  (byte-recompile-directory "~/.emacs.d/init")
  (load-file "~/.emacs.d/init.el"))

;; ansi-term 起動コマンド
(defun s ()
  (interactive)
  (ansi-term "/bin/bash"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ウィンドウ操作.

;;ウィンドウ切替
;;分割していない時に押すと分割する
;;移動後、そのバッファにslime-replが表示されていた場合にはカーソルを1つ進める
(defun keicy-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1)
  (when (string= (buffer-name) "*slime-repl sbcl*")
    (forward-char 1)))

;ウィンドウ左右入替(カーソルハイライト変更なし)
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))

;ウィンドウ左右入替(カーソルハイライト変更)
(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 改行.

;;末尾に移動して改行
(defun keicy-endline-newline-indent ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

;;末尾に移動し";"を挿入して改行
(defun keicy-endline-semicolon-newline-indent ()
  (interactive)
  (end-of-line)
  (insert ";")
  (newline-and-indent))

;;末尾に移動し"{}"を挿入して改行
(defun keicy-endline-namikakko-newline-indent ()
  (interactive)
  (end-of-line)
  (insert "{}")
  (backward-char)
  (newline-and-indent))

;;一文字進んで改行し"()"を挿入
;; for Lisp.
(defun keicy-cl-newline ()
  (interactive)
  (forward-char)
  (newline-and-indent)
  (insert "()")
  (backward-char))

;;一文字進んで改行
;; for Lisp.
(defun keicy-forward-char-newline ()
  (interactive)
  (forward-char)
  (newline-and-indent))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; その他編集.

; 前の単語を削除(copyではなく)
(defun keicy-backward-delete-word (arg)
  (interactive "p")
  (keicy-delete-word (- arg)))

; 後の単語を削除(copyではなく)
(defun keicy-delete-word (arg)
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

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
;; for Ruby
;;;;-----------------------;

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

