(bundle web-mode
  (add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
  
  (with-eval-after-load-feature (flycheck web-mode)
    (add-hook 'web-mode-hook 'flycheck-mode))

  (add-hook 'web-mode-hook 'indent-hook)
)

;;インデント設定
(defun indent-hook ()
  (setq web-mode-markup-indent-offset 4))
  
