(bundle company
  ; 候補の先頭と最後を繋げる
  (setq company-selection-wrap-around t)
  ; 補完表示までのラグ時間 (デフォルト: 0.5 )
  (setq company-idle-delay 0)
  ; 補完開始文字数 (デフォルト: 4)
  (setq company-minimum-prefix-length 2)
)

; YASnippet のスニペットを候補に表示するための設定
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
	  backend
	(append (if (consp backend) backend (list backend))
			'(:with company-yasnippet))))
(defun set-yas-as-company-backend ()
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
)
(add-hook 'company-mode-hook 'set-yas-as-company-backend)