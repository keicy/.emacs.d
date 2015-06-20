(bundle js2-mode
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

  (with-eval-after-load-feature 'js2-mode
    (setq js2-basic-offset 2))

  (with-eval-after-load-feature (flycheck js2-mode)
    (add-hook 'js2-mode-hook 'flycheck-mode))
)
