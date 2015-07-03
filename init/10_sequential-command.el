(bundle sequential-command)
(bundle! sequential-command-config
  (with-eval-after-load-feature 'sequential-command-config
    ;; 定義を変更するために上書き
    (define-sequential-command seq-home
      back-to-indentation beginning-of-line beginning-of-buffer seq-return)))
