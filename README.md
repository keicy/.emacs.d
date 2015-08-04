
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
;;for avoiding bug? of el-get-lock, if there whould be el-get.lock flycheck doesn't work...
git update-index --skip-worktree el-get.lock
rm ./el-get.lock 
```
