(bundle tide)

; 汎用設定

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

; pure TS
(defun setup-tide-mode ()
  (interactive)
  (setq typescript-indent-level 2)
  (tide-setup)
  (flycheck-mode)
  (eldoc-mode)
  (tide-hl-identifier-mode)
  (company-mode)
  (rainbow-delimiters-mode)
)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

; TSX
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . my-react-ts-hook))
(defun my-react-ts-hook ()
  (setq web-mode-engines-alist '(("jsx" . "\\.tsx\\'")))
  (web-mode)
  (setup-tide-mode)
  (flycheck-add-mode 'typescript-tslint 'web-mode)
)

; こちらは公式記載の書き方でこちらでもちゃんと動作する,好みの問題で上記を採用した.
; TSX
;(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;(add-hook 'web-mode-hook
;          (lambda ()
;            (setup-tide-mode)
;            (flycheck-add-mode 'typescript-tslint 'web-mode)
;            ))
