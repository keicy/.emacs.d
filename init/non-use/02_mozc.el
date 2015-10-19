; 99_key-binds.elの中の何か(多分絶対キーバッファ定義)と
; 相性悪く、日本語モードではRTNキーで改行できない。(newline)で対処。

(bundle! mozc)
(setq default-input-method "japanese-mozc")
(setq quail-japanese-use-double-n t)
