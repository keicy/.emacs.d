(bundle js2-mode
  (setq js2-basic-offset 2)
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  )

(add-hook 'js2-mode-hook
          (lambda ()
            (flycheck-mode)
            (setq flycheck-disabled-checkers
                  (append flycheck-disabled-checkers '(javascript-jshint javascript-jscs)))
            (setq flycheck-checker 'javascript-eslint)
            (flycheck-add-mode 'javascript-eslint 'js2-mode)
            ;(flycheck-add-mode 'javascript-standard 'js2-mode) ;ストレートにこれでも悪くなないけど
            (rainbow-delimiters-mode)
            ))
; js2-modeはmode固有の独自のコードチェッカが内蔵されている。上記設定で無効にしているが
; なにか問題があるようなら代わりに下記設定でjs-modeを使う。
;(add-hook 'js-mode-hook
;          (lambda ()
;            (flycheck-mode)
;            (setq flycheck-disabled-checkers
;                  (append flycheck-disabled-checkers '(javascript-jshint javascript-jscs)))
;            (setq flycheck-checker 'javascript-eslint)
;            (flycheck-add-mode 'javascript-eslint 'js-mode)
;            ))
