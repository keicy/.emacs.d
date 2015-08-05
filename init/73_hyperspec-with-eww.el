;;; !!! this file should be road after slime.el !!!

;; Its OVERRIDE default "my-common-lisp-hyperspec"(alias of "hyperspec-lookup") @slime~hyperspec.el
;;   to use "hyperspec-lookup" with EWW.
;; EWW cant work well with default "hyperspec-lookup".....
(defun common-lisp-hyperspec (symbol-name)
  (interactive (list (common-lisp-hyperspec-read-symbol-name)))
  (let ((name (common-lisp-hyperspec--strip-cl-package
	       (downcase symbol-name))))
    (cl-maplist 
        (lambda (entry)
		  (eww-open-file (concat common-lisp-hyperspec-root "Body/"
				      (car entry)))
		  (when (cdr entry)
		    (sleep-for 1.5)))
		(or (common-lisp-hyperspec--find name)
		    (error "The symbol `%s' is not defined in Common Lisp"
			   symbol-name)))))
