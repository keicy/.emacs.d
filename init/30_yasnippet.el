(bundle yasnippet)
(let ((builtin-items (expand-file-name "el-get/yasnippet/snippets" (locate-user-emacs-file emacs-version)))
      (custom-items (expand-file-name "tools/yasnippets" user-emacs-directory)))
  (setq yas-snippet-dirs
        `(,builtin-items ,custom-items)))
(yas-global-mode 1)
(custom-set-variables '(yas-trigger-key "TAB"))