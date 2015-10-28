(bundle smartchr)
(add-hook 'lisp-mode-hook 'keicy:smartchr:cl:chrset)
(add-hook 'slime-repl-mode-hook 'keicy:smartchr:cl:chrset)

;;;; 大文字はC-M-b系のキーバインドで入力する.

(defun keicy:smartchr:cl:chrset ()
  (progn
    (local-set-key (kbd "A") (smartchr '("(apply `!!')" "A")))
    (local-set-key (kbd "C") (smartchr '("(cond `!!')" "C")))
    (local-set-key (kbd "D") (smartchr '("(defun `!!')" "(defvar `!!')" "(defmacro `!!')" "(defparameter `!!')" keicy:smartchr:cl:defpackage "D")))
    (local-set-key (kbd "E") (smartchr '("(eql `!!')" "(equal `!!')" "(equalp `!!')" "E")))
    (local-set-key (kbd "F") (smartchr '("(funcall `!!')" "F")))
    (local-set-key (kbd "G") (smartchr '("(getf `!!')" "G")))
    (local-set-key (kbd "I") (smartchr '("(if `!!')" "I")))
    (local-set-key (kbd "J") (smartchr '("(`!!')" "\"`!!'\"" "J")))
    (local-set-key (kbd "L") (smartchr '("(let ((`!!')))" "(loop `!!')" "L")))
    (local-set-key (kbd "Q") (smartchr '("'" "`" "Q")))
    (local-set-key (kbd "S") (smartchr '("(setf `!!')" "S")))
    (local-set-key (kbd "U") (smartchr '("(unless `!!')" "U")))
    (local-set-key (kbd "W") (smartchr '("(when `!!')" "W")))
    (local-set-key (kbd "#") (smartchr '("#'" "#P" "#")))
    (local-set-key (kbd "@") (smartchr '(",@" "`" "@")))
    (local-set-key (kbd ",") (smartchr '("," ",@")))
    (local-set-key (kbd "*") (smartchr '("*`!!'*" "*")))
  ))

; TODO -> replace YAsnnipet.
	; http://fukuyama.co/yasnippet
	; http://konbu13.hatenablog.com/entry/2014/01/12/113300
(defun keicy:smartchr:cl:defpackage ()
 ""
 "(in-package :cl-user)
(defpackage :`!!'
  (:use :cl
        :cl-annot)
  (:import-from :)
(in-package :)
(syntax:use-syntax :annot)")
