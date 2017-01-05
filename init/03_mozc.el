; 99_key-binds.elの C-mキーをRTNキーから分離する設定と
; 相性悪く、日本語モードではRTNキーで改行できない。(newline)で対処するか、上記を諦めるかしかない。
; 原状、上記を諦めた。

(bundle! mozc
  (set-language-environment "Japanese")
  (setq default-input-method "japanese-mozc")
  (prefer-coding-system 'utf-8)
)

;; nn で 「ん」を変換表示
(setq quail-japanese-use-double-n t)

;; キー設定
(global-set-key (kbd "<zenkaku-hankaku>") 'toggle-input-method)
(global-set-key (kbd "C-v") 'toggle-input-method)
;(custom-set-variables '(mozc-mode-string "[Mo]")) ; 画面左端の表示、デフォルトは "[Mozc]", この行を削除した場合はこれが表示される

;; 上記 toggle-input-method を用いた設定が不安定な時用の設定
  ; ただし、下記カーソル色切替が効かない、画面右下に表示がでない、など弊害があるため使いたくない。
;(global-set-key (kbd "<zenkaku-hankaku>") 'mozc-mode)
;(global-set-key (kbd "C-v") 'mozc-mode)
;(custom-set-variables '(mozc-leim-title "[Mozc]")) ; この行を設定しないとなにも表示してくれないので注意

;; カーソル色切替
  ; 色見本 : http://life.a.la9.jp/hp/color/rgb-tab-pc.html
  ; ちなみに、カーソル形状の変更情報は http://th.nao.ac.jp/MEMBER/zenitani/elisp-j.html#cursor
(add-hook 'input-method-activate-hook
          (lambda() (set-cursor-color "DeepPink")))
(add-hook 'input-method-inactivate-hook
          (lambda() (set-cursor-color "orange"))) ; ここは 02_theme.el で読み込んでいるテーマファイルで設定されている `cursor` の色に合わせる

;; OS側の設定メモ
  ; mozcサーバ側に、変換中のキー操作を定義することができる。
  ; http://log-c.blog.so-net.ne.jp/2011-08-24-3
  ; http://washieagle.blogspot.jp/2010/10/scim-mozcemacs.html


;; ミニバッファでの日本語入力を無効化(migemo があるため必要ない)
(defvar ime-active-p nil)

(defun my-into-minibuffer-func()
  (if current-input-method
      (progn
        (setq ime-active-p t)
        (toggle-input-method)
        ;(set-cursor-color "orange")
          ;; なぜかこれがあっても M-x ではカーソル色が変わらない、、。
          ;; そしてこれがなくても他のhelmなどでは勝手に復元してくれる。
          ;; なのでこれはコメントアウト。
        )))

(defun my-quit-minibuffer-func()
  (if ime-active-p
      (progn
        (setq ime-active-p nil)
        (set-cursor-color "DeepPink")
        )))

(add-hook 'minibuffer-setup-hook 'my-into-minibuffer-func)
;(add-hook 'helm-minibuffer-set-up-hook 'my-into-minibuffer-func)
  ;; これは↑の行で含まれているので設定しなくて良い模様。コメントアウトしておく。
(add-hook 'focus-in-hook 'my-quit-minibuffer-func)
