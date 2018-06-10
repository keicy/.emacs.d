(bundle typescript-mode
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
  (setq typescript-indent-level 2)
)
(add-hook 'typescript-mode-hook 'rainbow-delimiters-mode)
