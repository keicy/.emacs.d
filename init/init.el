;; set user-emacs-directory (root dir)
;; (default "/home/kei/.emacs.d/")
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;
(let ((versioned-dir (locate-user-emacs-file emacs-version)))
  (setq el-get-dir (expand-file-name "el-get" versioned-dir)
        package-user-dir (expand-file-name "elpa" versioned-dir)))

;(setq-default el-get-emacswiki-base-url
;              "http://raw.github.com/emacsmirror/emacswiki.org/master/")

;;
(add-to-list 'load-path (locate-user-emacs-file "el-get/bundle"))
(unless (require 'bundle nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "http://raw.github.com/tarao/bundle-el/master/bundle-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;not related???    
;(setq el-get-generate-autoloads t)

;;
;(add-to-list 'el-get-recipe-path (locate-user-emacs-file "recipes"))

;;**********************************************************************

;; load bash PATHs.
(bundle! exec-path-from-shell
  (let ((envs '("PATH" "LD_LIBRARY_PATH" "MANPATH" "INFOPATH")))
    (exec-path-from-shell-copy-envs envs)))

;;##
(bundle! tarao/el-get-lock)
(el-get-lock)

;;##
;;CUTION!!! must from elpa. Do NOT from github.(its old..)
(bundle elpa:bind-key)

;;##
(bundle! with-eval-after-load-feature)

;default include???
;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;;##
(bundle! init-loader
  ;; load
  (setq-default init-loader-show-log-after-init nil
                 init-loader-byte-compile t)
                ; init-loader-byte-compile nil)
  (init-loader-load (locate-user-emacs-file "init"))

  ;; hide compilation results
   (let ((win (get-buffer-window "*Compile-Log*")))
     (when win (delete-window win)))
)
