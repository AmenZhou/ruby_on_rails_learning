Compare two files in one vim windows
vnew -> edit filename

vim -- find and replace
:%s/replace this/to this/ g

```
scp -i brm.pem localfilepath ubuntu@XXXX:remotefilepath
```

###VIM Indentation

http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim

===========================

Show whole path on shell

```
export PS1='\u@\H:\w$ '
```
============================

### dotvim on mac

replace following text at bundles.vim

```
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
```
.vimrc.after
```
colorscheme buttercream
set shiftwidth=2
set softtabstop=2
```

===========================

### Mac Bash Show Git Version

`vim ~/.bash_profile`

```
  export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\] \[\033[33;1m\]\w\[\033[m\] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \$ "
```

==============================

### Vim Shortcut

https://drive.google.com/drive/folders/0B_5oQQo5-fvQY0ZzUEc3dVBZUjA

====================================

### brew install macvim

```
brew install macvim --override-system-vim
brew linkapps
```

change vim path -- /usr/local/bin comes first in your $PATH

=====================================

### vim show editor history

in vim mode

`:Gblame`

### Brew start and restart

https://robots.thoughtbot.com/starting-and-stopping-background-services-with-homebrew

`brew services start/restart [service name]`
