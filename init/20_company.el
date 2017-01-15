(bundle company
  ; 候補の先頭と最後を繋げる
  (setq company-selection-wrap-around t)
  ; 補完表示までのラグ時間 (デフォルト: 0.5 )
  (setq company-idle-delay 0)
  ; 補完開始文字数 (デフォルト: 4)
  (setq company-minimum-prefix-length 2)
)
