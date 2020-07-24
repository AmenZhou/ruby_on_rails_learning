### Move Around
g_
Last char of the current line

https://vim.fandom.com/wiki/Moving_around

e 
Move to the end of a word.

w 
Move forward to the beginning of a word.

3w 
Move forward three words.

W 
Move forward a WORD (any non-whitespace characters).

b 
Move backward to the beginning of a word.

3b 
Move backward three words.

$ 
Move to the end of the line.

0 
Move to the beginning of the line.

^ 
Move to the first non-blank character of the line.

) 
Jump forward one sentence.

( 
Jump backward one sentence.

} 
Jump forward one paragraph.

{ 
Jump backward one paragraph.

j 
Jump forward one line.

10j 
Jump forward 10 lines

k 
Jump backward one line.

10k 
Jump backward 10 lines.

H 
Jump to the top of the screen.

M 
Jump to the middle of the screen.

L 
Jump to the bottom of the screen.

10<PageUp> or 10<CTRL-B>
Move 10 pages up.
 
5<PageDown> or 5<CTRL-F>
Move 5 pages down.
 
G 
Jump to end of file.

g
Jump x screen lines in direction (up,down,left,right) - useful for moving through a long, wrapped line of text.

1G 
Jump to beginning of file (same as gg).

50G 
Jump to line 50.

mx 
Set mark x at the current cursor position.

'x 
Jump to the beginning of the line of mark x.

`x 
Jump to the cursor position of mark x.

''
Return to the line where the cursor was before the latest jump.
(Two single quotes.)

``
Return to the cursor position before the latest jump (undo the jump).
(Two back ticks. This is above the Tab key on some keyboards.)

'. 
Jump to the last-changed line.

 % 
Jump to corresponding item, e.g. from an open brace to its matching closing brace. See Moving to matching braces for more.

| 
Jump to the 1st column of the current line.

42| 

Jump to the 42nd column of the current line.

g; Edit

[Control][b] - Move back one full screen
[Control][f] - Move forward one full screen
[Control][d] - Move forward 1/2 screen
[Control][u] - Move back (up) 1/2 screen

### Nerdtree Directory Manager

`m` - Display a list of command

----------

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
