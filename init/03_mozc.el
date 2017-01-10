; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ;
;                                                                       ;
;                               メモ                                    ;
;                                                                       ;
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ;

;; キーバインドとの悪相性
  ; mozc と 99_key-binds.elの C-mキーをRTNキーから分離する設定とは相性が悪く、
  ; 日本語モードではRTNキーで改行できない。(newline)で対処するか、上記を諦めるかしかない。
  ; 原状、上記を諦めた。

;; OS側の設定
  ; mozcサーバ側に、変換中のキー操作を定義することができ、する必要がある。
  ; https://github.com/keicy/.emacs.d/issues/12 を参照。
  ; 参考
  ; http://log-c.blog.so-net.ne.jp/2011-08-24-3
  ; http://washieagle.blogspot.jp/2010/10/scim-mozcemacs.html



; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ;
;                                                                       ;
;                               設定                                    ;
;                                                                       ;
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ;

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
;(custom-set-variables '(mozc-leim-title "【JP】")) ; 画面左端の表示、デフォルトは "[Mozc]"
;(custom-set-variables '(mozc-leim-title "【日本語】"))
(custom-set-variables '(mozc-leim-title nil))

;; 上記 toggle-input-method を用いた設定が不安定な時用の設定
  ; ただし、下記カーソル色切替が効かない、画面右下に表示がでない、など弊害があるため使いたくない。
;(global-set-key (kbd "<zenkaku-hankaku>") 'mozc-mode)
;(global-set-key (kbd "C-v") 'mozc-mode)
;(custom-set-variables '(mozc-mode-string "[Mozc]")) ; この行を設定しないとなにも表示してくれないので注意

;; カーソル色切替
  ; 色見本 : http://life.a.la9.jp/hp/color/rgb-tab-pc.html
  ; ちなみに、カーソル形状の変更情報は http://th.nao.ac.jp/MEMBER/zenitani/elisp-j.html#cursor
(add-hook 'input-method-activate-hook
          (lambda() (set-cursor-color "DeepPink")))
(add-hook 'input-method-inactivate-hook
          (lambda() (set-cursor-color "orange"))) ; ここは 02_theme.el で読み込んでいるテーマファイルで設定されている `cursor` の色に合わせる

;; ミニバッファでの日本語入力を無効化(migemo があるため必要ない)
(defun when-return-from-minibuffer()
  (if current-input-method
      (set-cursor-color "DeepPink")))

(add-hook 'minibuffer-setup-hook 'deactivate-input-method)
(add-hook 'focus-in-hook 'when-return-from-minibuffer)
