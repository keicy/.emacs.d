(defvar common-lisp-hyperspec-root (expand-file-name "tools/HyperSpec-7-0/HyperSpec/" user-emacs-directory))
(defvar common-lisp-hyperspec-symbol-table (expand-file-name "tools/HyperSpec-7-0/HyperSpec/Data/Map_Sym.txt" user-emacs-directory))

(add-hook 'lisp-mode-hook
      (lambda ()
        (setq-local browse-url-browser-function 'eww-browse-url)))
(add-hook 'slime-repl-mode-hook
      (lambda ()
        (setq-local browse-url-browser-function 'eww-browse-url)))
