(bundle elm-mode
  (add-to-list 'auto-mode-alist '("\\.elm\\'" . elm-mode)))

;(bundle elm-mode
;  (add-to-list 'auto-mode-alist '("\\.elm\\'" . my-elm-hook)))
;(defun my-elm-hook ()
;  (add-hook 'flycheck-mode-hook 'flycheck-elm-setup)
;  (setq flycheck-checker 'elm)
;  (flycheck-mode)
;  (setq company-backends '(company-elm))
;  (elm-oracle-setup-completion)
;  (elm-mode)
;)
