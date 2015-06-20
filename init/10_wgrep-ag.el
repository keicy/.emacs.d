(bundle wgrep-ag in wgrep
  (with-eval-after-load-feature 'wgrep-ag
    (setf wgrep-enable-key "e")           ;eでwgrepモードにする
    (setq wgrep-auto-save-buffer t)       ;wgrep終了時にバッファを保存
    (setq wgrep-change-readonly-file t)   ; read-only bufferにも変更を適用
    (add-hook 'ag-mode-hook 'wgrep-ag-setup)
  ))
