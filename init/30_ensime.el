;; 起動時メッセージを表示しない
(setq ensime-startup-notification nil)

;; sbtコマンド(デフォルト)の代替でactivatorコマンドを使用する
;; これによりOS側にはActivatorのみあれば良く、sbtはインストールしないで良い
(setq sbt:program-name "activator")

(bundle ensime)