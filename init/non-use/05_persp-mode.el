(bundle! persp-mode
  (with-eval-after-load 'persp-mode
    (add-hook 'after-init-hook #'(lambda () (persp-mode 1)))))
