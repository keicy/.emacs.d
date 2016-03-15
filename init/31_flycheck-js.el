(add-hook 'js2-mode-hook
          (lambda ()
            ;; flycheckに於いて優先度の高いlinter設定を無効化
            (setq-local flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                '(javascript-jshint javascript-jscs)))
            ;; modeを設定
              (flycheck-add-mode 'javascript-eslint 'js2-mode)
              (flycheck-mode)))
