### Install RVM Ruby Rails
```
curl -sSL https://get.rvm.io | bash -s stable

rvm install ruby-2.0.0-pXXX 

rvm --default use 2.0.0

gem install rails/rvm install rails

sudo apt-get install nodejs
```
###### reference:
http://installrails.com/

=====================================================

Bundle Error

Nokogiri error--bundle install lower version of ruby happens this kind of problem
Ubuntu / Debian

Ubuntu doesn’t come with the Ruby development packages that are required for building gems with C extensions. Here are the commands to install everything you might need:
```ruby
# ruby developer packages 
sudo apt-get install ruby1.8-dev ruby1.8 ri1.8 rdoc1.8 irb1.8 
sudo apt-get install libreadline-ruby1.8 libruby1.8 libopenssl-ruby

# nokogiri requirements 
sudo apt-get install libxslt-dev libxml2-dev 
sudo gem install nokogiri

Although, if you’re using Hardy (8.04) or earlier, you’ll need to install slightly different packages:

# nokogiri requirements for Hardy (8.04) and earlier 
sudo apt-get install libxslt1-dev libxml2-dev
```
=======================================================

Gem install pg error
I got a error when I bundle install pg

1 sudo apt-get install postgresql postgresql-contrib

2 Can install bundle without production 
bundle install --without production

==========================================================

Sphinxsearch Install in Ubunt

1 Install it in Ubuntu: http://sphinxsearch.com/docs/2.1.7/installing-debian.html

2 Edit sphinxsearch.conf file, add mysql log info

3 Start service: sudo service sphinxsearch start

4 It will run a demon service backgroundly

===============================================================

Install postgres in Ubuntu and config for rails

install pg
```
sudo apt-get install postgresql postgresql-contrib
```
switch to pg default user
```
sudo su - postgres
```
change postgres password
```
sudo passwd postgres
```

bundle error
install pg gem display error
```
sudo apt-get install libpq-dev
```

create a user for app
```
su - postgres
```
```
create role myapp with createdb login password 'password1'
```
```
createuser -s myapp
```
the last semicolon is very important

config user in app
1 open config/database.yml
e.g. config/database.yml
```ruby
  adapter: postgresql
  database: wikiful_development
  encoding: unicode
  username: myapp 
  password: password1
  host: localhost
  pool: 5
  timeout: 5000
```
2 change username and password to the pg user

### config pg in Nitrous.io

1  install postgres part from parts management

2  username is action

3  must add below line to config/database
```
host: localhost
```

### Github install and config

```
sudo apt-get install git

```
[https://help.github.com/articles/set-up-git](https://help.github.com/articles/set-up-git)

#### Change http to ssh

https://help.github.com/articles/changing-a-remote-s-url

### Vim Install and Config

###### pathogen
https://github.com/tpope/vim-pathogen


###### rails vim
https://github.com/tpope/vim-rails

###### nerdtree
https://github.com/scrooloose/nerdtree

###### dotvim
https://github.com/astrails/dotvim

###### solve ctags error
sudo apt-get install exuberant-ctags

##### ruby-install, chruby

ruby-install
```
wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz
tar -xzvf ruby-install-0.5.0.tar.gz
cd ruby-install-0.5.0/
sudo make install

ruby-install ruby 2.2.0
```

chruby
```
wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install

source /usr/local/share/chruby/chruby.sh
```
