; OVERRIDE Flycheck's elisp source codes @flycheck/flycheck.el.
  ; r.f. ) https://truongtx.me/2014/07/22/setup-php-development-environment-in-emacs 
(with-eval-after-load-feature 'flycheck
	(flycheck-define-checker php
		"A PHP syntax checker using the PHP command line interpreter.

	See URL `http://php.net/manual/en/features.commandline.php'."
		:command ("php" "-l" "-d" "error_reporting=E_ALL" "-d" "display_errors=1"
							"-d" "log_errors=0" source)
		:error-patterns
		((error line-start (or "Parse" "Fatal" "syntax") " error" (any ":" ",") " "
						(message) " in " (file-name) " on line " line line-end))
		:modes (php-mode php+-mode web-mode)
		:next-checkers ((warning . php-phpmd)
										(warning . php-phpcs)))

	(flycheck-define-checker php-phpmd
		"A PHP style checker using PHP Mess Detector.

	See URL `https://phpmd.org/'."
		:command ("phpmd" source "xml"
							(eval (flycheck-option-comma-separated-list
										 flycheck-phpmd-rulesets)))
		:error-parser flycheck-parse-phpmd
		:modes (php-mode php+-mode web-mode)
		:next-checkers (php-phpcs))

	(flycheck-define-checker php-phpcs
		"A PHP style checker using PHP Code Sniffer.

	Needs PHP Code Sniffer 2.6 or newer.

	See URL `http://pear.php.net/package/PHP_CodeSniffer/'."
		:command ("phpcs" "--report=checkstyle"
							;; Use -q flag to force quiet mode
							;; Quiet mode prevents errors from extra output when phpcs has
							;; been configured with show_progress enabled
							"-q"
							(option "--standard=" flycheck-phpcs-standard concat)
							;; Pass original file name to phpcs.  We need to concat explicitly
							;; here, because phpcs really insists to get option and argument as
							;; a single command line argument :|
							(eval (when (buffer-file-name)
											(concat "--stdin-path=" (buffer-file-name)))))
		:standard-input t
		:error-parser flycheck-parse-checkstyle
		:error-filter
		(lambda (errors)
			(flycheck-sanitize-errors
			 (flycheck-remove-error-file-names "STDIN" errors)))
		:modes (php-mode php+-mode web-mode)
		;; phpcs seems to choke on empty standard input, hence skip phpcs if the
		;; buffer is empty, see https://github.com/flycheck/flycheck/issues/907
		:predicate (lambda () (not (flycheck-buffer-empty-p))))
)

(add-to-list 'auto-mode-alist '("\\.php?\\'" . my-php-mode-hook))

(defun my-php-mode-hook ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 4)
  (web-mode)
  (flycheck-mode)
)
