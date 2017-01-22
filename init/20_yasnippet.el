(yasnippet
  (with-eval-after-load-feature 'yasnippet

    ; 独自定義したスニペットの置き場所
    (setq yas-snippet-dirs
      (append yas-snippet-dirs '("~/.emacs.d/resources/yasnippet")))

    ; キーバインド
    (bind-keys :map yas-minor-mode-map
               ("C-M-<tab>" . yas-expand)
               ("<tab>" . nil) ; 他プラグイン(入力補完など)との競合回避
    )

    (yas-reload-all) ; スニペット読込

    ; 有効にするモード
    (add-hook 'scala-mode-hook #'yas-minor-mode)  
  )
)
