(yasnippet
  (with-eval-after-load-feature 'yasnippet

    ; 独自定義したスニペットの置き場所
      ; `M-x customize-group RTN yasnippet RTN` -> `Yas Snippet Dirs` で設定できる。
      ; これはそのコピー。(ただし、ディレクトリの指定順は出力されたものとは入れ替えている。
      ; 入れ替えることで、 `yas-new-snippet` で保存するときに表示されるディレクトリに
      ; 先に記述したディレクトリが表示されるようになるのでUIを向上できる。
      ; また、デフォルトの独自定義の置き場所は `~/.emacs.d/snippets`
      ; これも同時に使いたい場合は下記のように定義すると良い。
      ; `(add-to-list 'yas-snippet-dirs "~/.emacs.d/resources/yasnippet")`
    (setq yas-snippet-dirs
          '("~/.emacs.d/resources/yasnippet" yas-installed-snippets-dir))

    ; キーバインド
    (bind-keys :map yas-minor-mode-map
               ("C-M-<tab>" . yas-expand)
               ("<tab>" . nil) ; 他プラグイン(入力補完など)との競合回避
    )

    ; スニペット読込
    (yas-reload-all)

    ; 有効にするモード
    (add-hook 'scala-mode-hook #'yas-minor-mode)
  )
)
