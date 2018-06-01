; 自動で 'markdown-mode' と 'gfm-mode (GitHub Flavored Markdown)' の2つが使えるようになる.
(bundle markdown-mode
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
)
