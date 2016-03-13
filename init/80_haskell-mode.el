(bundle haskell-mode
  (add-to-list 'auto-mode-alist '("\\.hs" . haskell-mode))
  ;(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))
  ;(add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode))

  ;(with-eval-after-load-feature (flycheck haskell-mode)
  ;  (add-hook 'haskell-mode-hook 'flycheck-mode))

  ;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
  ;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  ;(add-hook 'haskell-mode-hook 'font-lock-mode)
  ;(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)
)
