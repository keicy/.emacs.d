(bundle slime
  (setq inferior-lisp-program "sbcl")
  (slime-setup '(slime-fancy)))



;; slime起動時に出るworningメッセージを無効化
; cf1 - https://lists.gnu.org/archive/html/emacs-devel/2012-12/msg00068.html
; cf2 - http://ircbrowse.net/browse/lisp?events_page=244482
;(byte-compile-disable-warning 'cl-functions)



;(add-to-list 'load-path "/home/kei/.emacs.d/24.5.1/el-get/slime/")
;(setq inferior-lisp-program "sbcl")
;(require 'slime)
; (setq slime-net-coding-system 'utf-8-unix)
; (slime-setup '(slime-repl slime-fancy slime-banner slime-indentation))
; (slime-setup '(slime-repl slime-banner slime-indentation))




;(slime-setup '(slime-fancy slime-repl))

;(bundle slime
;  (with-eval-after-load-feature 'slime
;    (setq inferior-lisp-program "sbcl")
;    (setq slime-net-coding-system 'utf-8-unix))
;  (with-eval-after-load 'slime
;    (slime-setup '(slime-fancy)))
;)


;;;; Util Functions

; C-c C-s で slimeを起動
;(defun my-slime (&optional command coding-system)
;  (interactive)
;  (switch-to-buffer-other-window (get-buffer-create "*lisp*"))
;  (slime command coding-system))

;;;; junk

 ;;起動後のフックアクション
 ;;実用に支障ないが、カーソル位置が微妙にいけてないので一旦コメントアウト
 ;;代わりにスタートアップに記述している
 ;(add-hook 'slime-connected-hook 'keicy-after-connect-slime)
 ;(defun keicy-after-connect-slime ()
 ;  (shrink-window 16)
 ;  (select-window (get-lru-window nil)) )
 ;; 自動インデント
 ;(add-hook 'slime-mode-hook
 ;      (lambda ()
 ;        (setq lisp-indent-function 'common-lisp-indent-function)))
 ;; Additional definitions by Pierpaolo Bernardi.
 ;(defun cl-indent (sym indent)
 ;  (put sym 'common-lisp-indent-function
 ;       (if (symbolp indent)
 ;       (get indent 'common-lisp-indent-function)
 ;     indent)))
 ;(cl-indent 'if '1)
 ;(cl-indent 'generic-flet 'flet)
 ;(cl-indent 'generic-labels 'labels)
 ;(cl-indent 'with-accessors 'multiple-value-bind)
 ;(cl-indent 'with-added-methods '((1 4 ((&whole 1))) (2 &body)))
 ;(cl-indent 'with-condition-restarts '((1 4 ((&whole 1))) (2 &body)))
 ;(cl-indent 'with-simple-restart '((1 4 ((&whole 1))) (2 &body)))
