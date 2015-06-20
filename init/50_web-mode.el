(bundle web-mode
  (add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
  
  (with-eval-after-load-feature (flycheck web-mode)
    (add-hook 'web-mode-hook 'flycheck-mode))

  ;;インデント設定
  (with-eval-after-load-feature 'web-mode 
    (add-hook 'web-mode-hook '(lambda ()
                                (setq web-mode-attr-indent-offset nil)
                                (setq web-mode-markup-indent-offset 2)
                                (setq web-mode-css-indent-offset 2)
                                (setq web-mode-code-indent-offset 2)
                                (setq web-mode-sql-indent-offset 2)
                                (setq indent-tabs-mode nil)
                                (setq tab-width 2))))
)
