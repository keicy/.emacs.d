;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 前提条件＆方針.
  ;(左)無変換  -> Ctrl
  ;(右)変換    -> Alt
  ;編集関連はC、Mを用いる
  ;プレフィクス:[カタカナ~]キーは編集以外の機能



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 基本設定.

;; It looks bug.. NOT work with (bundle!).
(when (locate-library (symbol-name 'bind-key))
  (require 'bind-key))

;; <hiragana-katakana> をprefix keyとして使う.
  ; http://qiita.com/Fenril058/items/f66cb8c76cdff729826c
  ; http://yohshiy.blog.fc2.com/blog-entry-271.html
(defvar keicy-util-map (make-keymap))
(global-set-key (kbd "<hiragana-katakana>") keicy-util-map)

;; Dispatch Enter key from C-m.
  ;http://stackoverflow.com/questions/2298811/how-to-turn-off-alternative-enter-with-ctrlm-in-linux
  ;C-1からC-9には他愛もないコマンドが割り当てられているためC-m押下を例えばC-6と認識するようにパッチ
  ;そしてEnterキーをC-mと認識するようにパッチ
  ;※C-mにキーを割り当てる場合、C-6に割り当てる必要がある
(define-key input-decode-map (kbd "C-m") [?\C-6])
(define-key input-decode-map (kbd "<return>") [?\C-m])



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Utils.

;; キーバインド交換。
;; Easy syntax to "keyboard-translate" each other.
  ; http://homepage1.nifty.com/blankspace/emacs/keybind.html
  ; http://yohshiy.blog.fc2.com/blog-entry-271.html
  ; http://www.bookshelf.jp/texi/emacs-man/21-3/jp/faq_10.html#SEC142
(defmacro bind-exchange (bind1 bind2)
  `(progn
    (keyboard-translate ,bind1 ,bind2)
    (keyboard-translate ,bind2 ,bind1)))

;; 対象ライブラリがインスコされている場合に、そのライブラリの関数についての
;; 絶対バインドを定義する。
  ;http://rubikitch.com/2014/09/10/bind-key/
;;### 使い方 ###
;(absb helm
;  ("M-x" helm-M-x)
;  ("C-x C-r" helm-recentf))
;;#############
(defmacro absb (libsym &rest body)
  `(when (locate-library ,(symbol-name libsym))
    (bind-keys* 
      ,@(loop for e
              in body
              collect `(,(car e) . ,(cadr e))))))

;; 対象ライブラリがインスコされている場合に、そのライブラリの関数についての
;; キーバインドをkeicy-util-mapに定義する。
;;### Usage ###
;(keicy-util elscreen
;  ("n" elscreen-create)
;  ("k" elscreen-kill))
;;#############
(defmacro keicy-util (libsym &rest body)
  ""
  `(when (locate-library ,(symbol-name libsym))
    (progn
      ,@(loop for bind
              in body
              collect `(define-key keicy-util-map ,(car bind) ',(cadr bind))))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 実験的コマンド.

	;;;;;; testing
	;(define-key input-decode-map (kbd "C-;") [?\C-f])
	;(keyboard-translate ?\C-f ?\C-;) -> ng



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; バインド定義
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 基本コマンド.

;; 入力コマンドキャンセル(元C-g).
(bind-key "C-<return>" 'keyboard-quit)
(bind-key "C-<return>" 'abort-recursive-edit minibuffer-local-map)

;; 【絶対キー】編集.
(bind-keys*
  ("C-a" . seq-home) ;行頭/文頭/ファイル頭
  ("C-d" . delete-char) ;DEL
  ("M-d" . delete-char) ;DEL
  ("C-M-d" . keicy-delete-word) ;単語DEL
  ("C-S-d" . keicy-delete-line-nokillring) ;行削除
  ("C-f" . delete-backward-char) ;Backspace
  ("M-f" . delete-backward-char) ;Backspace
  ("C-M-f" . keicy-backward-delete-word) ;単語Backspace
  ("C-g"  . undo) ;アンドゥ
  ("C-M-g" . redo) ;リドゥ
  ("M-j" . backward-char) ;一文字戻る
  ("C-M-j" . backward-word) ;一単語戻る
  ("M-k" . previous-line) ;一行上がる
  ("M-l" . next-line) ;一行下がる
  ("M-;" . forward-char) ;一文字進む
  ("C-M-;" . forward-word) ;一単語進む
  ("M-:" . seq-end) ;行末/文末/ファイル末
  ("M-v" . kill-region) ;切り取り
  ("C-v" . kill-ring-save) ;コピー
  ("C-M-v" . yank) ;ペースト
  ("M-n" . scroll-down) ;次ページ
  ("C-M-n" . scroll-up) ;前ページ
  ("C-n" . recenter-top-bottom) ;ページ再描写
  ("C-b" . seq-capitalize-backward-word) ;頭を大文字
  ("C-M-b" . seq-upcase-backward-word) ;大文字
  ("M-b" . seq-downcase-backward-word) ;小文字
  ("M-m" . split-window-horizontally) ;ウィンドウ左右分割
  ("C-6" . delete-window) ;ウィンドウ消去(※ rf.above - Dispatch Enter key from C-m.)
  ("C-M-m" . delete-other-windows) ;他ウィンドウ消去
  ("C-<tab>" . keicy-window-or-split) ;ウィンドウ切替
  ("C-x C-b" . switch-to-buffer) ;バッファ切替
  ("<f2>" . swap-screen-with-cursor) ;ウィンドウ左右入替(カーソルハイライト変更なし)
  ("S-<f2>" . swap-screen) ;ウィンドウ左右入替(カーソルハイライト変更)
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; デフォルトバインド.
    ; 特定のモードにおいてはモードバインド(下部定義)で上書きされる.

;;; DEFAULT.
(bind-keys
  ("M-h" . newline-and-indent)
  ("C-h" . newline)
  ("C-M-h" . keicy-endline-newline-indent) ;末尾に移動して改行
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; モードバインド.

;;; Common Lisp.
; lisp-mode-map
(add-hook 'lisp-mode-hook
  (lambda ()
    (bind-keys :map lisp-mode-map
               ("M-h" . keicy-cl-newline) ;一文字進んで改行し"()"を挿入
               ("C-h" . keicy-forward-char-newline) ;一文字進んで改行
               ("C-M-h" . keicy-endline-newline-indent) ;末尾に移動して改行
               )))
; slime-repl-mode-map
(add-hook 'slime-replmode-hook
  (lambda ()
    (bind-keys :map slime-repl-mode-map
               ("M-h" . keicy-cl-newline) ;一文字進んで改行し"()"を挿入
               ("C-h" . keicy-forward-char-newline) ;一文字進んで改行
               ("C-M-h" . keicy-endline-newline-indent) ;末尾に移動して改行
               )))

;;; C,Java.
(add-hook 'c-mode-common-hook
  (lambda ()
    (bind-keys :map c-mode-base-map
               ("M-h" . keicy-endline-semicolon-newline-indent) ;末尾に移動し";"を挿入して改行
               ("C-h" . keicy-endline-namikakko-newline-indent) ;末尾に移動し"{}"を挿入して改行
               ("C-M-h" . keicy-endline-newline-indent) ;末尾に移動して改行
               )))

;;; JS.
(add-hook 'js2-mode-hook
  (lambda ()
    (bind-keys :map js2-mode-map
               ("M-h" . keicy-endline-semicolon-newline-indent) ;末尾に移動し";"を挿入して改行
               ("C-h" . keicy-endline-namikakko-newline-indent) ;末尾に移動し"{}"を挿入して改行
               ("C-M-h" . keicy-endline-newline-indent) ;末尾に移動して改行
               )))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; プラグインコマンド.

;; Elscreen.
(absb elscreen
  ("C->" elscreen-next)
  ("C-<prior>" elscreen-next)
  ("C-<" elscreen-previous)
  ("C-<next>" elscreen-previous))
(keicy-util elscreen
  ("n" elscreen-create)
  ("k" elscreen-kill)
  ("." elscreen-next)
  ("," elscreen-previous)
  )

;; Helm.
(absb helm
;  ("M-x" helm-M-x)
;  ("C-x C-f" helm-find-files)
;  ("C-x C-r" helm-recentf)
  ("C-x C-b" helm-buffers-list)
  ("C-x b" helm-buffers-list)
)

;; Dired.
(keicy-util dired
  ("d" dired))

;; Ag.
(keicy-util ag
  ("r" ag-at-hand))

;; Isearch.
;(bind-exchange ?\C-z ?\C-s)
;(bind-exchange ?\C-S-z ?\C-r)

;; Multiple-Cursors.
(global-unset-key (kbd "C-6"))
;; "<hiragana-katakana>-m"を連続キーモードキャンセルとして用いる
  ; C-6 means C-m. *rf) above "Enter key dispatch from C-m."
(smartrep-define-key global-map "C-6"  
  '(
    ("a" . 'mc/mark-all-like-this)
    ("h" . 'mc/mark-all-symbols-like-this)
    ("w" . 'mc/mark-all-words-like-this)
    ("r" . 'vr/mc-mark)
    ("k" . 'mc/mark-previous-like-this)
    ("l" . 'mc/mark-next-like-this)
    ("K" . 'mc/unmark-previous-like-this)
    ("L" . 'mc/unmark-next-like-this)
    ("j" . 'mc/skip-to-previous-like-this)
    (";" . 'mc/skip-to-next-like-this)
    ("n" . 'mc/insert-numbers)
    ("s" . 'mc/sort-regions)
    ("t" . 'mc/mark-sgml-tag-pair)
   ))

;; Editing.
;todo
;; HS.
;(define-key global-map
;  (kbd "C-#") 'hs-toggle-hiding)


;;;;;;;;test -> ok
;(smartrep-define-key global-map "<hiragana-katakana>"
;  '(("i" . 'mc/mark-next-like-this)
;    ("o" . 'mc/mark-previous-like-this)))
;;;;;;;;;;;;

;;Magit.

;;Twittering-mode.

;;Slime.
(keicy-util slime
  ("s" slime)
)
;(bind-keys :map lisp-mode-map
;           ("C-q" . slime-load-file)
;           ("C-w" . slime-compile-and-load-file)
;           ("C-e" . slime-compile-defun)
;)







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; 【参考情報】古い定義
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; Cursole binds.
;(bind-keys*
   ;; カーソル移動 ---------------------------------------------------
;  ("C-a" . seq-home)                      ;行頭/文頭/ファイル頭
;  ("C-d" . delete-char)                   ;DEL
;  ("C-f" . delete-backward-char)          ;Backspace
;  ("C-h" . backward-char)                 ;一文字戻る
;  ("C-j" . forward-char)                  ;一文字進む
;  ("C-k" . next-line)                     ;一行下がる
;  ("C-l" . previous-line)                 ;一行上がる
;  ("C-;" . newline-and-indent)            ;改行&インデント
;  ("M-;" . keicy-endline-newline-indent)  ;行末へ移動&改行&インデント
;  ("C-M-;" . keicy-endline-newline-indent);同上
;  ("C-:" . seq-end)                       ;行末/文末/ファイル末

  ;; 編集 ---------------------------------------------------------
;  ("C-g" . undo)                          ;アンドゥ
;  ("M-g" . redo)                          ;リドゥ 
;  ("M-w" . kill-region)                   ;切り取り
;  ("C-w" . kill-ring-save)                ;コピー
;  ("C-e" . cua-paste)                     ;ペースト
;  ("M-e" . cua-paste)                     ;同上
;    ( "C-"" . )         ;置換
;    ( "C-"" . )         ;矩形選択

  ;; emacs操作 ----------------------------------------------------
;  ("C-q" . abort-recursive-edit)          ;操作キャンセル(C-gの代わり) ※トラブルがあるので下記詳細
;  ("C-t" . keicy-window-or-split)         ;ウィンドウ切替
;  ("C-x C-b" . switch-to-buffer)          ;バッファ切替 ※デフォルトはlist-buffers
;)

;;;; C-g(keyboard-quit)を他キーに割り当てるトラブルについて ;;;;;;;;;;;;
;;
;;keyboard-quitをC-qなどに割り当てると正常動作しない
;;(definbd "C-q"" 'keyboard-quit)
;;これは、ミニバッファ内でC-gを押しているとき、実はkeyboard-quitではなく
;;abort-recursive-editを読んでいるためらしい
;;※cf) http://emacs.stackexchange.com/questions/5971/additional-binding-for-keyboard-quit-doesnt-work-with-minibuffer
;;下記のように書くと一応動くが、ちょくちょくマクロエラーが吐かれる
;;(glod "C-g"")
::
;;そこで、C-qにはkeyboard-quitではなく下記いずれかを割り当て対処する
;;1)top-level
;;2)abort-recursive-edit
;;3)keyboard-escape-quit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;; 改行でオートインデント
;; 文字変換確定
;(globalbd "C-m"" 'newline-and-indent)
;; C-hでBackSpace
;(keyboard-translate ?\C-h ?\C-?)
;; 折り返しトグルコマンド
;(globalbd "C-c l"" 'toggle-truncate-lines)
;; アンドゥ ※ElScreenとかぶってしまう。。。
;(keyboard-translate ?\C-z ?\C-/)

;;前のバッファ
;(global-bd "M-p" 'previous-buffer)
;;次のバッファ
;(global-bd "M-n"" 'next-buffer)


;----------------------------------------;
; ElScreen
;----------------------------------------;
;(global-set-key [(C-zenkaku-hankaku)] 'elscreen-previous)
;(global-set-key [(C-tab)] 'elscreen-next)
;(global-set-key "\M-1" '(lambda () (interactive) (elscreen-goto 1)))
;(global-set-key "\M-2" '(lambda () (interactive) (elscreen-goto 2)))
;(global-set-key "\M-3" '(lambda () (interactive) (elscreen-goto 3)))
;(global-set-key "\M-4" '(lambda () (interactive) (elscreen-goto 4)))
;(global-set-key "\M-5" '(lambda () (interactive) (elscreen-goto 5)))
;(global-set-key "\M-6" '(lambda () (interactive) (elscreen-goto 6)))
;(global-set-key "\M-7" '(lambda () (interactive) (elscreen-goto 7)))
;(global-set-key "\M-8" '(lambda () (interactive) (elscreen-goto 8)))
;(global-set-key "\M-9" '(lambda () (interactive) (elscreen-goto 9)))
;(global-bd "C-M-<left>"" 'elscreen-swap-previous)
;(global-bd "C-M-<right>"" 'elscreen-swap-next)
;(global-bd "M-k"" 'kill-buffer-for-elscreen)

;----------------------------------------;
; expand-region
;----------------------------------------;
;(global-bd "C-@"" 'er/expand-region)
;(global-bd "C-M-@"" 'er/contract-region)

;----------------------------------------;
; auto-complete
;----------------------------------------;
;(define-key ac-completing-map "\C-n" 'ac-next)
;(define-key ac-completing-map "\C-p" 'ac-previous)

;----------------------------------------;
; SLIME
;----------------------------------------;
;(globalbd "C-c C-s"" 'my-slime)
 
;----------------------------------------;
; RUBY-MODE
;----------------------------------------;
;;;;マイナーモード[inf-ruby-mode]の優先競合キーを無効化し独自バインドを設定
;(eval-after-load "inf-ruby"
;  '(progn
;     (debd "C-c C-r"" nil)
;     ))
;(add-hook 'ruby-mode-hook
;          '(lambda ()
;        bd "C-c C-r"" 'keicy-ruby-script-runner)
;             ))

;----------------------------------------;
; INF-RUBY-MODE
;----------------------------------------;
;;;;メジャーモード[inf-ruby-mode]において競合キーを上書きし独自バインドを設定
;(add-hook 'inf-ruby-mode-hook
;          '(lambda ()
;        bd "C-c C-r"" 'keicy-ruby-script-runner)
;             ))
