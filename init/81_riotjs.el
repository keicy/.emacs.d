(add-to-list 'auto-mode-alist '("\\.tag\\'" . my-riot-hook))

(defun my-riot-hook ()
  (setq web-mode-engines-alist '(("riot" . "\\.tag\\'")))
  (web-mode)
  (setq flycheck-checker 'javascript-eslint)
  (flycheck-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
)
