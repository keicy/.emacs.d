;; sync emacs & OS keyring
(cond (window-system
(setq x-select-enable-clipboard t)))

;; autosaveファイルを作らない
(setq auto-save-default nil)

;; bkファイルを作らない
(setq make-backup-files nil)
(setq backup-inhibited t)

;; menu-barを非表示
(menu-bar-mode 0)

;; tool-barを非表示
(tool-bar-mode 0)

;; scroll-barを表示する
(scroll-bar-mode t)

;; 質問をy/nで回答
(fset 'yes-or-no-p 'y-or-n-p)

;; スタートアップメッセージを非表示
(setq inhibit-startup-screen t)

;; *scratch*のメッセージを非表示
(setq initial-scratch-message "")

;; 同一ファイル名の後ろにフォルダ名をつける
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; ファイルが #! から始まる場合、+xを付けて保存する
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; 現在のカーソル行を目立たせる
; (global-hl-line-mode)

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 行番号表示
(global-linum-mode t)
(set-face-attribute 'linum nil
                    :foreground "#75C6C3" ;色
                    :height 0.9)

;; 行間
(setq-default line-spacing 1)

;;タブ幅
(setq tab-width 2)

;; タブをスペースで扱う
(setq-default indent-tabs-mode nil)

;; カーソルの位置が何文字目かを表示する
(column-number-mode t)

;; カーソルの位置が何行目かを表示する
(line-number-mode t)

;; 自動改行をoffにする
(setq text-mode-hook 'turn-off-auto-fill)

;; file名の補完で大文字小文字を区別しない
(setq completion-ignore-case t)

;;find-file のデフォルトパスを設定
(setq default-directory "~/dev/")
(setq command-line-default-directory "~/dev/")

;; モードラインに現在時刻を表示する
(display-time)

;; デフォルトのフォントサイズ
(set-frame-font "Monospace-14")

;; デフォルトの連携ブラウザ
(setq browse-url-browser-function 'browse-url-generic
          browse-url-generic-program "chromium-browser")
