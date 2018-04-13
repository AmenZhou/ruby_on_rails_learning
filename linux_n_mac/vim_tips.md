
### Fold

```
 Vim folding commands
---------------------------------
zf#j creates a fold from the cursor down # lines.
zf/ string creates a fold from the cursor to string .
zj moves the cursor to the next fold.
zk moves the cursor to the previous fold.
za toggle a fold at the cursor.
zo opens a fold at the cursor.
zO opens all folds at the cursor.
zc closes a fold under cursor. 
zm increases the foldlevel by one.
zM closes all open folds.
zr decreases the foldlevel by one.
zR decreases the foldlevel to zero -- all folds will be open.
zd deletes the fold at the cursor.
zE deletes all folds.
[z move to start of open fold.
]z move to end of open fold.
```

### Tabs in vim

**New Table**

`tabe filename`


**Shift Tabs**

`gt`

### CTags

https://blog.sensible.io/2014/05/09/supercharge-your-vim-into-ide-with-ctags.html
```
##Generate ctags
ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)
```


**MacVim not working after upgrade to High Sierra**

1. Upgrade github keychain `printf "protocol=https\nhost=github.com\n" | git credential-osxkeychain erase`
2. Launch Xcode and let all Xcode components being upgraded
3. Upgrade MacVim by `brew upgrade macvim`
4. If you see 'Ignoring ... because its extensions are not built' when you open the vim, then run this `gem pristine --all`
