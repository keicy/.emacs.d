(defvar keicy-junk-home "~/dev")
(defvar keicy-junk-dir (concat keicy-junk-home "/junk"))

(unless (file-exists-p keicy-junk-home)
  (make-directory keicy-junk-home))
  
(unless (file-exists-p keicy-junk-dir)
  (make-directory keicy-junk-dir))

(bundle open-junk-file
  (with-eval-after-load-feature 'open-junk-file
    (setq open-junk-file-directory (concat keicy-junk-dir "/%Y-%m-%d-%H%M."))))
