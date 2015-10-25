(bundle auto-complete
  (ac-config-default)
  (with-eval-after-load-feature 'auto-complete
    (add-to-list 'ac-dictionary-directories (locate-user-emacs-file "el-get/auto-complete/ac-dict"))
    (setq ac-comphist-file (locate-user-emacs-file "el-get/auto-complete/cashe/ac-comphist.dat"))
  )
)

;(global-auto-complete-mode t)
 ;;;;;;.lispファイルを読まない場合、下でモード指定で読み込ませることもできる;;;;;;
 ;;(add-to-list 'ac-modes 'lisp-mode)
 ;;(add-to-list 'interpreter-mode-alist '("clisp" . emacs-lisp-mode))
 ;;(add-to-list 'auto-mode-alist '("\\.lisp$" . emacs-lisp-mode))
 ;;;;;;;;;;;;;;;;
