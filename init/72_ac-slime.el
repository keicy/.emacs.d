(bundle ac-slime
  (with-eval-after-load-feature 'ac-slime
    (add-hook 'slime-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'set-up-slime-ac))
  (with-eval-after-load-feature 'auto-complete
    (add-to-list 'ac-modes 'slime-repl-mode)))
