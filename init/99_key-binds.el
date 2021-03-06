; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ;
;                                                                       ;
;                           前提マシン設定                              ;
;                                                                       ;
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ;

;(左)無変換  -> Ctrl
;(右)変換    -> Alt





; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ;
;                                                                       ;
;                              基本設定                                 ;
;                                                                       ;
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ;

; #####   Utilプラグイン インストール (bind-key)   ###
  ;; バグっぽくて (bundle!...) では動作しないため下記の方法でインストール

(when (locate-library (symbol-name 'bind-key))
  (require 'bind-key))



; #####   独自プレフィックスキー設定 (<hiragana-katakana>)   ###
  ;; http://qiita.com/Fenril058/items/f66cb8c76cdff729826c
  ;; http://yohshiy.blog.fc2.com/blog-entry-271.html

(defvar keicy-util-map (make-keymap))
(global-set-key (kbd "<hiragana-katakana>") keicy-util-map)



; #####   RTNと "C-m" の分離   ###
  ;;
  ;; http://stackoverflow.com/questions/2298811/how-to-turn-off-alternative-enter-with-ctrlm-in-linux
  ;; C-1からC-9には他愛もないコマンドが割り当てられているためC-m押下を例えばC-6と認識するようにパッチ
  ;; そしてEnterキーをC-mと認識するようにパッチ
  ;; ※C-mにキーを割り当てる場合、C-6に割り当てる必要がある
  ;; ; + - + + - + - + - + - + - + - + - + - + - + - + - + - + - + - +
  ;; ;  @@ 注意 @@                                                   ;
  ;; ;  日本語入力プラグイン `mozc.el` と相性悪く、これをやると      ;
  ;; ;  あちらでRTNキーでの改行ができなくなってしまうため、          ;
  ;; ;  今はこちらの設定は使っていない。                             ;
  ;; ; + - + + - + - + - + - + - + - + - + - + - + - + - + - + - + - +
;(define-key input-decode-map (kbd "C-m") [?\C-6])
;(define-key input-decode-map (kbd "<return>") [?\C-m])



; #####   TABと "C-i" の分離   ###
  ;; 上記RTNと同様の処置
  ;; ※C-iにキーを割り当てる場合、C-7に割り当てる必要がある
;(define-key input-decode-map (kbd "C-i") [?\C-7])
;(define-key input-decode-map (kbd "<tab>") [?\C-i])





; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ;
;                                                                       ;
;                          ユーティリティ関数                            ;
;                                                                       ;
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ;

; #####   ライブラリ向け絶対バインド   ###
  ;; 対象ライブラリがインスコされている場合に
  ;; そのライブラリの関数についての絶対バインドを定義する。
  ;; http://rubikitch.com/2014/09/10/bind-key/
  ;; ;+ - + + - + - + - + - + - + - + - + - + - + - + - + - + - + - +
  ;; ;  @@ 使い方 @@                                                ;
  ;; ;  (absb helm                                                  ;
  ;; ;    ("M-x" helm-M-x)                                          ;
  ;; ;    ("C-x C-r" helm-recentf))                                 ;
  ;; ;+ - + + - + - + - + - + - + - + - + - + - + - + - + - + - + - +
(defmacro absb (libsym &rest body)
  `(when (locate-library ,(symbol-name libsym))
    (bind-keys* 
      ,@(loop for e
              in body
              collect `(,(car e) . ,(cadr e))))))



; #####   ライブラリ向けkeicy-utilバインド   ###
  ;; 対象ライブラリがインスコされている場合に
  ;; そのライブラリの関数についてのキーバインドをkeicy-util-mapに定義する。
  ;; ;+ - + + - + - + - + - + - + - + - + - + - + - + - + - + - + - +
  ;; ;  @@ 使い方 @@                                                ;
  ;; ;  (keicy-util elscreen                                        ;
  ;; ;    ("n" elscreen-create)                                     ;
  ;; ;    ("k" elscreen-kill))                                      ;
  ;; ;+ - + + - + - + - + - + - + - + - + - + - + - + - + - + - + - + 
(defmacro keicy-util (libsym &rest body)
  ""
  `(when (locate-library ,(symbol-name libsym))
    (progn
      ,@(loop for bind
              in body
              collect `(define-key keicy-util-map ,(car bind) ',(cadr bind))))))





; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ;
;                                                                       ;
;                            バインド定義                               ;
;                                                                       ;
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ;

;; @@  システムプレフィックス(元C-x)  @@
(bind-key* "C-SPC" 'Control-X-prefix)
(unbind-key "C-x")

;; @@  システムプレフィックス(元M-x)  @@
(bind-key* "M-<return>" 'helm-M-x)
(unbind-key "M-x")

; #####   アンバインド   ###

(unbind-key "C-z" ctl-x-map)
(unbind-key "C-c" ctl-x-map)
(unbind-key "C-q")
(unbind-key "M-j")
(unbind-key "C-z")

; #####   基本操作   ###
  ;; 着本的に絶対バインドで設定

;; @@  入力コマンドキャンセル(元C-g)  @@

;(bind-key* "C-<return>" 'keyboard-quit)
;(bind-key* "C-<return>" 'abort-recursive-edit minibuffer-local-map)
  ; 下記不具合があり、より良い設定を模索する必要がある
    ; 1. `C-SPC` でリージョンをキャンセルすることができない
    ; 2. ちょくちょく `No recursive edit is in progress` というワーニングが出ている

; OKっぽい.一旦これで設定.
; これで駄目なら,上記コメントの `C-m` のように、 `C-q` を `C-<return>` として認識させる設定を試す.こちらのほうが筋が良い可能性もある.
(bind-key "C-<return>" 'keyboard-quit)
(bind-key "C-<return>" 'abort-recursive-edit minibuffer-local-map)

;; @@  システム操作  @@

(bind-keys :map ctl-x-map
           ;("C-b" . helm-mini) ;バッファ切替
           ;("b" . helm-mini) ;バッファ切替
           ("C-SPC" . helm-mini) ;バッファ切替
           ("SPC" . helm-mini) ;バッファ切替
           ("C-k" . kill-this-buffer) ;バッファ削除
           ("k" . kill-this-buffer) ;バッファ削除
           ("C-f" . helm-find-files) ;ファイル参照
           ("f" . helm-find-files) ;ファイル参照
)

(bind-keys*
  ("C-<tab>" . keicy-window-or-split) ;ウィンドウ切替
  ("C-M-<tab>" . swap-screen-with-cursor) ;ウィンドウ左右入替(カーソルハイライト変更なし)
  ;("C-M-<backtab>" . swap-screen) ;ウィンドウ左右入替(カーソルハイライト変更) ;;良い割当が無いため一旦未定義
  ("C-0" . delete-window) ;ウィンドウ消去(※ rf.above - Dispatch Enter key from C-m.)
  ("C-1" . delete-other-windows) ;他ウィンドウ消去
)

;; @@  編集操作  @@
(setq viper-mode nil)
(require 'viper)
(bind-keys*

  ;;; カーソル移動

  ("M-j" . backward-char) ;一文字戻る
  ;("C-M-j" . backward-word) ;一単語戻る ※単語には記号は含まない.a-z0-9のみ.
  ;("C-M-j" . backward-same-syntax) ;記号も考慮して一単語戻る
  ("C-M-j" . viper-backward-word) ;記号も考慮して一単語戻る
  ("M-k" . forward-char) ;一文字進む
  ;("C-M-k" . forward-to-word) ;一単語進む ※単語には記号は含まない.a-z0-9のみ.
  ;("C-M-k" . forward-same-syntax) ;記号も考慮して一単語進む
  ("C-M-k" . viper-forward-word) ;記号も考慮して一単語進む
  ("M-i" . previous-line) ;一行上がる
  ("M-n" . next-line) ;一行下がる

  ("M-[" . seq-home) ;行頭/文頭/ファイル頭
  ("M-{" . seq-end) ;行末/文末/ファイル末

  ("M-l" . goto-last-change) ;直前の編集箇所に戻る
  ("M-L" . goto-last-change-reverse) ;直後の編集箇所に戻る

  ;;; 編集
  
  ("C-d" . delete-char) ;DEL
  ("M-d" . delete-region) ;選択範囲をDEL ;;本当は、選択モード中は `C-d` でこの動作をしてほしい
  ;("C-M-d" . keicy-delete-word) ;単語DEL
  ("C-M-d" . forward-delete-word) ;単語DEL
  ("C-S-d" . keicy-delete-line-nokillring) ;行削除
  ("C-f" . delete-backward-char) ;Backspace
  ;("C-M-f" . keicy-backward-delete-word) ;単語Backspace
  ("C-M-f" . backward-delete-word) ;単語Backspace

  ("C-s"  . save-buffer) ;保存

  ("C-g"  . undo) ;アンドゥ
  ("C-S-g" . redo) ;リドゥ

  ("M-o" . kill-region) ;切り取り
  ("M-p" . kill-ring-save) ;コピー
  ("M-u" . yank) ;ペースト
  ("C-M-u" . helm-show-kill-ring) ;履歴からペースト

  ("M-@"  . er/expand-region) ;erで範囲選択
  ("C-M-@"  . mark-word) ;次の単語を範囲選択
  ("M-`"  . mark-whole-buffer) ;全選択
  ;("C-M-`"  . (mark-word -1)) ;前の単語を範囲選択 -> リージョンを前方向に伸ばす方法が見つからないのでこれは未実装. この実装では駄目.

  ("C-r" . seq-capitalize-backward-word) ;頭を大文字
  ("C-M-r" . seq-upcase-backward-word) ;大文字
  ("M-r" . seq-downcase-backward-word) ;小文字

  ;;; 検索

  ("C-e"  . isearch-forward) ;前方検索
  ("C-S-e" . isearch-backward) ;後方検索

  ;;; 描写

  ("C-M-i" . scroll-down) ;前ページ
  ("C-M-n" . scroll-up) ;次ページ
  ("C-M-b" . recenter-top-bottom) ;ページ再描写
)

;; @@  特定のモードでは挙動が上書きされる操作  @@

(bind-keys
  
  ;;; 改行

  ("C-h" . newline-and-indent)
  ("M-h" . endline-newline-indent) ;末尾に移動して改行
  ("C-M-h" . endline-newline2-indent) ;末尾に移動して2行改行
)

;; @@  検索機能補足設定 (ISearch)  @@

  ; http://blog.livedoor.jp/tek_nishi/archives/2932391.html

(bind-keys :map isearch-mode-map
           ("C-f" . isearch-del-char)
           ("C-e" . isearch-repeat-forward)
           ("C-S-e" . isearch-repeat-backward)
           ("C-h" . isearch-ring-retreat)
           ("M-u" . isearch-yank-kill)
           ("M-p" . isearch-yank-word-or-char)
)
(bind-keys :map minibuffer-local-isearch-map
           ("C-e" . isearch-reverse-exit-minibuffer)
           ("C-S-e" . isearch-forward-exit-minibuffer)
           ("C-h" . previous-history-element)
)

;; @@  置換/矩形編集機能補足設定 (Multiple-Cursors)  @@

(bind-key* "C-M-q" 'mc/mark-all-dwim) ; 大抵の単語選択に対応できる便利コマンド

(smartrep-define-key global-map "C-q"
  '(
    ("C-q" . 'mc/keyboard-quit)
    ("C-a" . 'mc/mark-all-like-this)
    ("C-i" . 'mc/mark-previous-like-this)
    ("C-S-i" . 'mc/unmark-previous-like-this)
    ("C-n" . 'mc/mark-next-like-this)
    ("C-S-n" . 'mc/unmark-next-like-this)
    ("C-w" . 'mc/mark-all-words-like-this)
    ("C-l" . '(mc/insert-numbers 1)) ; 連番が1から始まるように設定
    ("C-s" . 'mc/sort-regions)
    ("C-t" . 'mc/mark-sgml-tag-pair)
    ;("h" . 'mc/mark-all-symbols-like-this)
    ;("r" . 'vr/mc-mark)
    ;("j" . 'mc/skip-to-previous-like-this)
    ;(";" . 'mc/skip-to-next-like-this)
))



; #####   プラグイン設定   ###

;; @@  	1文字ジャンプ (avy)  @@

(defun bind-avy-jump-key (prefix c &optional mode)
  (define-key global-map
    (read-kbd-macro (concat prefix (string c)))
    `(lambda ()
       (interactive)
       (funcall (if (eq ',mode 'word)
                    #'avy-goto-word-1
                    #'avy-goto-char) ,c))))

(loop for c from ?0 to ?9 do (bind-avy-jump-key "H-" c))
(loop for c from ?a to ?z do (bind-avy-jump-key "H-" c))
(loop for c from ?! to ?~ do (bind-avy-jump-key "H-" c))
(loop for c from ?0 to ?9 do (bind-avy-jump-key "H-C-" c 'word))
(loop for c from ?a to ?z do (bind-avy-jump-key "H-C-" c 'word))
(loop for c from ?! to ?~ do (bind-avy-jump-key "H-C-" c 'word))


;; @@  	Gitクライアント (Magit)  @@

(bind-key "C-z" 'magit-status) ; 起動

(with-eval-after-load-feature 'magit
  (bind-keys :map magit-mode-map
             ("C-z" . magit-dispatch-popup) ; ヘルプを表示
             ("C-<return>" . kill-current-buffer-previous-multiframe-window) ; Quit
  )

  (bind-keys :map magit-popup-mode-map
             ("C-z" . magit-popup-help) ; ヘルプを表示
             ("C-<return>" . magit-popup-quit) ; Quit
  )
)

;; @@  	タブ機能 (Elscreen)  @@

(bind-keys :map ctl-x-map
           ("n" . elscreen-create) ; 新しいスクリーンを作成
           ("C-n" . elscreen-create) ; 新しいスクリーンを作成
           ("w" . elscreen-kill) ; スクリーンを削除
           ("C-w" . elscreen-kill) ; スクリーンを削除
           ("," . elscreen-previous) ; 前のスクリーンに移動
           ("C-," . elscreen-previous) ; 前のスクリーンに移動
           ("." . elscreen-next) ; 次のスクリーンに移動
           ("C-." . elscreen-next) ; 次のスクリーンに移動
)

;; @@  	フォルダ編集機能 (Dired)  @@

(bind-keys :map ctl-x-map
           ("d" . dired) ; 起動
           ("C-d" . dired) ; 起動
)

;; @@  ファルダ配下一括編集機能 (Ag)  @@

(bind-keys :map ctl-x-map
           ("g" . ag-at-hand) ; 起動
           ("C-g" . ag-at-hand) ; 起動
)

;; @@  インタフェースツール (Helm)  @@

(defvar keicy-helm-mini-buffer-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-<return>")    'helm-keyboard-quit)
    (define-key map (kbd "M-k")           'helm-execute-persistent-action)
    (define-key map (kbd "M-i")           'helm-previous-line)
    (define-key map (kbd "M-n")           'helm-next-line)
    (define-key map (kbd "C-f")           'delete-backward-char)
    ;(define-key map (kbd "C-M-f")         'keicy-backward-delete-word)
    (define-key map (kbd "C-M-f")         'backward-delete-word)
    (define-key map (kbd "M-u")           'yank)
    map))

(define-minor-mode keicy-helm-mini-buffer-mode
  "A minor mode to be defined helm mini buffer specific key bindings."
  :init-value nil
  :lighter ""
)

(add-to-list 'emulation-mode-map-alists
             `((keicy-helm-mini-buffer-mode . ,keicy-helm-mini-buffer-map)))

(add-hook 'helm-minibuffer-set-up-hook (lambda () (keicy-helm-mini-buffer-mode 1)))
(add-hook 'helm-minibuffer-set-up-hook (lambda () (override-global-mode -1)))

(bind-keys :map helm-find-files-map
           ("M-j" . helm-find-files-up-one-level)
)
(bind-keys :map helm-read-file-map
           ("M-j" . helm-find-files-up-one-level)
)

;; @@  入力補完ツール (Company)  @@

(with-eval-after-load-feature 'company
  (bind-keys :map company-active-map
             ("C-<return>" . company-abort)
             ("M-p" . nil)
             ("M-i" . company-select-previous)
             ("M-n" . company-select-next) ;デフォルトでこれだが明示的に
             ;("<tab>" . company-complete-common-or-cycle) ; デフォルト: company-complete-common
))

;; @@  Scala 開発環境 (ENSIME)  @@

;;; ENSIME

(with-eval-after-load-feature 'ensime
  (bind-keys :map ensime-mode-map
             ("M-@" . ensime-edit-definition)
             ("M-`" . ensime-pop-find-definition-stack)
             ("M-[" . ensime-backward-note)
             ("M-]" . ensime-forward-note)
))

;;; Scala REPL

(defun keicy-ensime-inf-mode-binds()
  (bind-keys :map ensime-inf-mode-map

             ; システムコマンド
             ("M-<return>" . execute-extended-command)
             ("C-<tab>" . keicy-window-or-split)
             ("C-<return>" . comint-accumulate) ; デフォルトで M-<return> に割り当てられていたもの,複数行入力用の改行コマンド

             ; 編集
             ("C-g"  . undo) ;アンドゥ
             ("C-S-g" . redo) ;リドゥ

             ("M-o" . kill-region) ;切り取り
             ("M-p" . kill-ring-save) ;コピー
             ("M-u" . yank) ;ペースト

             ("C-r" . seq-capitalize-backward-word) ;頭を大文字
             ("C-M-r" . seq-upcase-backward-word) ;大文字
             ("M-r" . seq-downcase-backward-word) ;小文字

             ("M-j" . backward-char) ;一文字戻る
             ;("C-M-j" . backward-word) ;一単語戻る ※単語には記号は含まない.a-z0-9のみ.
             ("C-M-j" . backward-same-syntax) ;記号も考慮して一単語戻る
             ("M-k" . forward-char) ;一文字進む
             ;("C-M-k" . forward-to-word) ;一単語進む ※単語には記号は含まない.a-z0-9のみ.
             ("C-M-k" . forward-same-syntax) ;記号も考慮して一単語進む
             ("M-i" . previous-line) ;一行上がる
             ("M-n" . next-line) ;一行下がる

             ("M-l" . goto-last-change) ;直前の編集箇所に戻る
             ("M-L" . goto-last-change-reverse) ;直後の編集箇所に戻る

             ;("C-d" . delete-char) ;DEL ; これを追加すると `cntl-D` が効かなくなるので排除.ただこれがなくともデフォルトでこのバインドがシェル側に定義されているので困らない.
             ;("C-M-d" . keicy-delete-word) ;単語DEL
             ("C-M-d" . forward-delete-word) ;単語DEL
             ("C-f" . delete-backward-char) ;Backspace
             ;("C-M-f" . keicy-backward-delete-word) ;単語Backspace
             ("C-M-f" . backward-delete-word) ;単語Backspace
             ("M-," . beginning-of-line) ;行頭
             ("M-." . end-of-line) ;行末

             ; ページング
             ("C-M-i" . scroll-down) ;前ページ
             ("C-M-n" . scroll-up) ;次ページ
             ("C-M-b" . recenter-top-bottom) ;ページ再描写

             ; ターミナル
             ("C-i" . comint-previous-input) ;コマンド履歴を辿る
             ("C-n" . comint-next-input) ;コマンド履歴を戻る
))

; 絶対バインドを無効化
(add-hook 'ensime-inf-mode-hook (lambda () (override-global-mode -1)))
(add-hook 'ensime-inf-mode-hook 'keicy-ensime-inf-mode-binds)
