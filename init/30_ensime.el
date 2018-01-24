(custom-set-variables
  ;; 起動時メッセージを表示しない
  '(ensime-startup-notification nil)
  '(ensime-startup-snapshot-notification nil)

  ;; 自動接続有効化
  '(ensime-auto-connect (quote always))

  ;; .ensime をPJルートに自動作成
  '(ensime-auto-generate-config t)

  ;; UIにHRLMを使う
  '(ensime-use-helm t)
)

(bundle ensime)
