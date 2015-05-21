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
