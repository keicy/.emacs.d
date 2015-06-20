(bundle projectile
  (with-eval-after-load-feature 'projectile
    (add-hook 'lisp-mode-hook 'projectile-mode)
    (add-hook 'web-mode-hook 'projectile-mode)
    (add-hook 'js2-mode-hook 'projectile-mode)
    
    (custom-set-variables '(projectile-enable-caching t))
    (setq projectile-completion-system 'helm)
  )																												
  (helm-projectile-on))

