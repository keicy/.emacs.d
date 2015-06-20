;;;;TODO
;;割り当てをカスタムしたものはデフォルトを解除
;;mozcのサーバ側キーバインド設定

;----------------------------------------;
; 全てのモードで有効な設定
;----------------------------------------;

;;常に有効なマイナーモードを作ることでキーバインドをどのモードでも強制的に使うための設定
;;http://d.hatena.ne.jp/rubikitch/20101126/keymap
(define-minor-mode overriding-minor-mode
  ""
  t                                     
  ""
  `(
    ;;;;有望な空き -----------------------------------------------------
    ;;;; C-| s ] ||    || v n
    ;;;; M-| a s d f h j k l : ] || v n
    
    ;;;; カーソル移動 --------------------------------------------------
    (,(kbd "C-a") . seq-home)                      ;行頭/文頭/ファイル頭
    (,(kbd "C-d") . delete-char)                   ;DEL
    (,(kbd "C-f") . delete-backward-char)          ;Backspace
    (,(kbd "C-h") . backward-char)                 ;一文字戻る
    (,(kbd "C-j") . forward-char)                  ;一文字進む
    (,(kbd "C-k") . next-line)                     ;一行下がる
    (,(kbd "C-l") . previous-line)                 ;一行上がる
    (,(kbd "C-;") . newline-and-indent)            ;改行&インデント
    (,(kbd "M-;") . keicy-endline-newline-indent)  ;行末へ移動&改行&インデント
    (,(kbd "C-M-;") . keicy-endline-newline-indent);同上
    (,(kbd "C-:") . seq-end)                       ;行末/文末/ファイル末

    ;;;;; 編集 ---------------------------------------------------------
    (,(kbd "C-g") . undo)                          ;アンドゥ
    (,(kbd "M-g") . redo)                          ;リドゥ 
    (,(kbd "M-w") . kill-region)                   ;切り取り
    (,(kbd "C-w") . kill-ring-save)                ;コピー
    (,(kbd "C-e") . cua-paste)                     ;ペースト
    (,(kbd "M-e") . cua-paste)                     ;同上
;    (,(kbd "C-") . )         ;置換
;    (,(kbd "C-") . )         ;矩形選択

    ;;;; emacs操作 -----------------------------------------------------
    (,(kbd "C-q") . abort-recursive-edit)          ;操作キャンセル(C-gの代わり) ※トラブルがあるので下記詳細
    (,(kbd "C-t") . keicy-window-or-split)         ;ウィンドウ切替
    (,(kbd "C-x C-b") . switch-to-buffer)          ;バッファ切替 ※デフォルトはlist-buffers
   ))

;;;; C-g(keyboard-quit)を他キーに割り当てるトラブルについて ;;;;;;;;;;;;
;;
;;keyboard-quitをC-qなどに割り当てると正常動作しない
;;(define-key global-map (kbd "C-q") 'keyboard-quit)
;;これは、ミニバッファ内でC-gを押しているとき、実はkeyboard-quitではなく
;;abort-recursive-editを読んでいるためらしい
;;※cf) http://emacs.stackexchange.com/questions/5971/additional-binding-for-keyboard-quit-doesnt-work-with-minibuffer
;;下記のように書くと一応動くが、ちょくちょくマクロエラーが吐かれる
;;(global-set-key (kbd "C-q") (kbd "C-g"))
::
;;そこで、C-qにはkeyboard-quitではなく下記いずれかを割り当て対処する
;;1)top-level
;;2)abort-recursive-edit
;;3)keyboard-escape-quit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;;;####################################################
;;;;old

;;;keyboard-escape-quit
;;;(global-set-key (kbd "C-q") 'keyboard-quit)

;; 改行でオートインデント
;; 文字変換確定
;(global-set-key (kbd "C-m") 'newline-and-indent)
;; C-hでBackSpace
;(keyboard-translate ?\C-h ?\C-?)
;; 折り返しトグルコマンド
;(global-set-key (kbd "C-c l") 'toggle-truncate-lines)
;; アンドゥ ※ElScreenとかぶってしまう。。。
;(keyboard-translate ?\C-z ?\C-/)

;;前のバッファ
(global-set-key (kbd "M-p") 'previous-buffer)
;;次のバッファ
(global-set-key (kbd "M-n") 'next-buffer)


;----------------------------------------;
; ElScreen
;----------------------------------------;
(global-set-key [(C-zenkaku-hankaku)] 'elscreen-previous)
(global-set-key [(C-tab)] 'elscreen-next)
(global-set-key "\M-1" '(lambda () (interactive) (elscreen-goto 1)))
(global-set-key "\M-2" '(lambda () (interactive) (elscreen-goto 2)))
(global-set-key "\M-3" '(lambda () (interactive) (elscreen-goto 3)))
(global-set-key "\M-4" '(lambda () (interactive) (elscreen-goto 4)))
(global-set-key "\M-5" '(lambda () (interactive) (elscreen-goto 5)))
(global-set-key "\M-6" '(lambda () (interactive) (elscreen-goto 6)))
(global-set-key "\M-7" '(lambda () (interactive) (elscreen-goto 7)))
(global-set-key "\M-8" '(lambda () (interactive) (elscreen-goto 8)))
(global-set-key "\M-9" '(lambda () (interactive) (elscreen-goto 9)))
(global-set-key (kbd "C-M-<left>") 'elscreen-swap-previous)
(global-set-key (kbd "C-M-<right>") 'elscreen-swap-next)
(global-set-key (kbd "M-k") 'kill-buffer-for-elscreen)

;----------------------------------------;
; expand-region
;----------------------------------------;
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-M-@") 'er/contract-region)

;----------------------------------------;
; auto-complete
;----------------------------------------;
 (define-key ac-completing-map "\C-n" 'ac-next)
 (define-key ac-completing-map "\C-p" 'ac-previous)

;----------------------------------------;
; SLIME
;----------------------------------------;
 (global-set-key (kbd "C-c C-s") 'my-slime)
 
;----------------------------------------;
; RUBY-MODE
;----------------------------------------;
;;;;マイナーモード[inf-ruby-mode]の優先競合キーを無効化し独自バインドを設定
(eval-after-load "inf-ruby"
  '(progn
     (define-key inf-ruby-minor-mode-map (kbd "C-c C-r") nil)
     ))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (define-key ruby-mode-map (kbd "C-c C-r") 'keicy-ruby-script-runner)
             ))

;----------------------------------------;
; INF-RUBY-MODE
;----------------------------------------;
;;;;メジャーモード[inf-ruby-mode]において競合キーを上書きし独自バインドを設定
(add-hook 'inf-ruby-mode-hook
          '(lambda ()
             (define-key inf-ruby-mode-map (kbd "C-c C-r") 'keicy-ruby-script-runner)
             ))
