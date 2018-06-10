(bundle json-mode
  (add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode)))

(add-hook 'json-mode-hook
          (lambda ()
            (setq js-indent-level 2)
            (flycheck-mode)
            (setq flycheck-checker 'json-jsonlint)
            (flycheck-add-mode 'json-jsonlint 'json-mode)
            (rainbow-delimiters-mode)
            ))
