### Give user the ablibity to edit ntfs external drivers

* `sudo vim /etc/fstab`

* `LABEL=DEMO none ntfs rw,auto,nobrowse`

*  Then plugin the external drivers

*  Find the partition in *Finder -> Go(menu) -> Find folder(submenu)* 

*  Drag the icon of that partition into left side *Favorite* , so next time the partition can be finded there whenever the driver is plugin

### Install Webkit Gem into Mac OS Sierra

1. see this link and follow the steps there -- https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit#macos-sierra-1012
2. `PATH=$PATH:/Users/username/Qt5.5.1/5.5/clang_64/bin gem install capybara-webkit -v '1.9.0'`

### Install new fonts for shell and vim in Mac

1. download font from https://github.com/powerline/fonts/blob/master/Inconsolata/Inconsolata%20for%20Powerline.otf and install
2. open a console and click 'mac + ,'
3. select new font from the list
