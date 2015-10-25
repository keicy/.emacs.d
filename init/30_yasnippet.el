(bundle yasnippet)
(let ((builtin-items (expand-file-name "el-get/yasnippet/snippets" (locate-user-emacs-file emacs-version)))
      (custom-items (expand-file-name "tools/yasnippets" user-emacs-directory)))
  (setq yas-snippet-dirs
        `(,builtin-items ,custom-items)))
(yas-global-mode 1)
;(custom-set-variables '(yas-trigger-key "<C-M-tab>")) ;not work.. so set under lines instead.
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "<C-M-tab>") 'yas-expand)