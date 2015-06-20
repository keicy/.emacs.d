(bundle rainbow-delimiters)
(add-hook 'slime-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'slime-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-interaction-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
 
 ;;カッコの色を変更する
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
  '(rainbow-delimiters-depth-1-face ((t (:foreground "dark glay"))))
  '(rainbow-delimiters-depth-2-face ((t (:foreground "magenta"))))
  '(rainbow-delimiters-depth-3-face ((t (:foreground "deep sky blue"))))
  '(rainbow-delimiters-depth-4-face ((t (:foreground "dark orange"))))
  '(rainbow-delimiters-depth-5-face ((t (:foreground "dark violet"))))
  '(rainbow-delimiters-depth-6-face ((t (:foreground "dark glay"))))
  '(rainbow-delimiters-depth-7-face ((t (:foreground "magenta"))))
  '(rainbow-delimiters-depth-8-face ((t (:foreground "blue"))))
  '(rainbow-delimiters-depth-9-face ((t (:foreground "dark orange"))))
  '(rainbow-delimiters-unmatched-face ((t (:foreground "red")))) 
)
 
;; 色を濃くする (最終行の数値が大きいと濃くなる)
;; 現状requireのとこでモジュールがなくてエラーになるのでコメントアウト
;(require 'cl-lib)　
;(require 'color) 
;(cl-loop
; for index from 1 to rainbow-delimiters-max-face-count
; do
; (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
;   (cl-callf color-saturate-name (face-foreground face) 100)))
