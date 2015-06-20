;;CLの関数を有効化
(require 'cl-lib)

;;各種設定ファイル用のメジャーモード有効化
(require 'generic-x)

;; (),{}などの対応を自動で入れる
(electric-pair-mode t)

;; 対応する括弧を光らせる。
(show-paren-mode 1)

;; ウィンドウ内に収まらないときだけ括弧内も光らせる。
(setq show-paren-style 'mixed)
