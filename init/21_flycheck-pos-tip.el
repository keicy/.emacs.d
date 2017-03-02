(bundle flycheck-pos-tip
  (with-eval-after-load-feature 'flycheck
    (custom-set-variables
      '(flycheck-pos-tip-timeout 60))
    (flycheck-pos-tip-mode)))
