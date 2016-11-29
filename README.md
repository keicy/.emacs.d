
# .emacs.d

It's a settings for emacs that v24.5 or later.

## Usage

```
;; clone.
git clone git@github.com:keicy/.emacs.d.git

;; initialize emacs, install elisps.
emacs
```

Finish el-get initialize, then shut off emacs. 

```
;;for avoiding bug? of el-get-lock, if there whould be el-get.lock flycheck didn't work...
git update-index --skip-worktree el-get.lock
rm ./el-get.lock 
```

## Doc

### 大文字小文字

| key  | 動作 | 補足 |
| ------------- | ------------- | ------------- |
| `C-r` | 頭を大文字 |  |
| `C-M-r` | 全て大文字 |  |
| `M-r` | 全て小文字 |  |

### ページング

| key  | 動作 | 補足 |
| ------------- | ------------- | ------------- |
| `C-M-i` | 前ページ |  |
| `C-M-n` | 次ページ |  |
| `C-M-b` | 再描写 |  |

### 検索 (ISearch)

| key  | 動作 | 補足 |
| ------------- | ------------- | ------------- |
| `C-e`  | 前方検索  |  |
| `C-S-e`  | 後方検索  |  |
| `C-h`  | 履歴参照 | RTNキー押下で選択を決定し、その後 `C-e/C-S-e` での検索が可能 |
| `C-f`  | 一文字後退 | |

### 置換/矩形/その他編集

#### Multiple-Cursors

| key  | 動作 | 補足 |
| ------------- | ------------- | ------------- |
| `C-a` | 全ての選択字句を対象 |  |
| `C-q` | EXIT |  |
| `C-i` | 一つ前の選択字句を対象 |  |
| `C-S-i` | 一つ前の選択字句を対象から外す |  |
| `C-n` | 一つ後の選択字句を対象 |  |
| `C-S-n` | 一つ後の選択字句を対象から外す |  |
| `C-w` | 全てのカーソル位置の単語を対象 |  |
| `C-l` | 先頭に連番挿入 |  |
| `C-s` | ソート |  |
| `C-t` | htmlのタグペア編集 |  |

#### Rectangle-mark-mode

| key  | 動作 | 補足 |
| ------------- | ------------- | ------------- |
| `SYSpre(M-b) SPC` |  矩形選択 |  |

### タブ機能 (Elscreen)

| key  | 動作 | 補足 |
| ------------- | ------------- | ------------- |
| `<hiragana> n` | 新規タブ作成 |  |
| `<hiragana> k` | タブ削除 |  |
| `<hiragana> ,` | 左のタブに移動 |  |
| `<hiragana> .` | 右のタブに移動 |  |

### ファイル名編集 (Wdired)

着本的にはDired上で下記操作により使用する

| key  | 動作 | 補足 |
| ------------- | ------------- | ------------- |
| `<hiragana> d` | Dired呼出し |  |
| `e` | 編集モード | diredの表示上で対象ファイル/フォルダにカーソル置いて実施 |
| `C-c C-c` | 編集コミット |  |
| `C-c C-k` | 編集破棄 |  |

### フォルダ配下一括検索/編集 (Wgrep-ag)

検索文字列と対象フォルダを指定し、配下ファイルから一括検索できる
Multiple-Cursorsとの併用で一括置換が可能

| key  | 動作 | 補足 |
| ------------- | ------------- | ------------- |
| `<hiragana> g` | 機能呼出し |  |
| `e` | 編集モード | 表示された一覧上で対象行にカーソル置いて実施 |
| `C-c C-c` | 編集コミット |  |
| `C-c C-k` | 編集破棄 |  |

### 日本語入力

| key  | 動作 | 補足 |
| ------------- | ------------- | ------------- |
| `C-v` | 切替 | |

todo: 変換中の操作キーバインドをOSのサーバ側に設定
