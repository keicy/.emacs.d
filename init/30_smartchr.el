(bundle smartchr)
(add-hook 'lisp-mode-hook 'keicy:smartchr:cl:chrset)
(add-hook 'slime-repl-mode-hook 'keicy:smartchr:cl:chrset)

;;;; 大文字はC-M-b系のキーバインドで入力する.

(defun keicy:smartchr:cl:chrset ()
  (progn
    (local-set-key (kbd "A") (smartchr '("(apply `!!')" "A")))
    (local-set-key (kbd "B") (smartchr '("&body body`!!'" "B")))
    (local-set-key (kbd "C") (smartchr '("(cond `!!')" "C")))
    (local-set-key (kbd "D") (smartchr '("(defun `!!')" "(defvar `!!')" "(defmacro `!!')" "(defparameter `!!')" "D")))
    (local-set-key (kbd "E") (smartchr '("(eql `!!')" "(equal `!!')" "(equalp `!!')" "E")))
    (local-set-key (kbd "F") (smartchr '("(funcall `!!')" "F")))
    (local-set-key (kbd "G") (smartchr '("(getf `!!')" "(gensym)`!!'" "G")))
    (local-set-key (kbd "I") (smartchr '("(if `!!')" "I")))
    (local-set-key (kbd "J") (smartchr '("(`!!')" "\"`!!'\"" "((`!!'))" "J")))
    (local-set-key (kbd "L") (smartchr '("(let ((`!!')))" "let ((`!!'))" "(loop `!!')" "L")))
    (local-set-key (kbd "P") (smartchr '(keicy:smartchr:cl:progn "Q")))
    (local-set-key (kbd "Q") (smartchr '("'" "`" "Q")))
    (local-set-key (kbd "S") (smartchr '("(setf `!!')" "S")))
    (local-set-key (kbd "U") (smartchr '("(unless `!!')" "U")))
    (local-set-key (kbd "W") (smartchr '("(when `!!')" "(with-gensyms (`!!'))" "W")))
    (local-set-key (kbd "#") (smartchr '("#'" "#P" "#|" "|#" "#")))
    (local-set-key (kbd "@") (smartchr '(",@" "`" "@")))
    (local-set-key (kbd ",") (smartchr '("," "'," ",@")))
    ;(local-set-key (kbd "*") (smartchr '("*`!!'*" "*")))
  ))

(defun keicy:smartchr:cl:progn ()
 ""
   "(progn
      `!!')")
