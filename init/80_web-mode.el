(bundle web-mode
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)

  ; Normal HTML
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  ; Riot.js
  (add-to-list 'auto-mode-alist '("\\.tag\\'" . web-mode))
  (setq web-mode-engines-alist '(("riot" . "\\.tag\\'")))
)
