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

### Install postgres in Ubuntu and config for rails

1. install pg
   ```
   sudo apt-get install postgresql postgresql-contrib
   ```
2. switch to pg default user
   ```
   sudo su - postgres
   ```
3. change postgres password
   ```
   sudo passwd postgres
   ```

4. bundle error -- install pg gem display error
   ```
    sudo apt-get install libpq-dev
    ```

5. create a user for app
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

6. config user in app
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

====================
### config pg in Nitrous.io

1  install postgres part from parts management

2  username is action

3  must add below line to config/database
```
host: localhost
```
=========================
### Github install and config

```
sudo apt-get install git

```
[https://help.github.com/articles/set-up-git](https://help.github.com/articles/set-up-git)

======================
#### Change http to ssh

https://help.github.com/articles/changing-a-remote-s-url

==========================
### Vim Install and Config

##### pathogen
https://github.com/tpope/vim-pathogen


##### rails vim
https://github.com/tpope/vim-rails

##### nerdtree
https://github.com/scrooloose/nerdtree

##### dotvim
https://github.com/astrails/dotvim

##### solve ctags error
sudo apt-get install exuberant-ctags

===================
### ruby-install, chruby

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

chruby ruby-2.2.0 #defaut ruby version is 2.2.0

ruby setup.rb
```
==============================
### Google Pinyin

```
sudo apt-get install im-switch fcitx fcitx-config-gtk2 fcitx-googlepinyin fcitx-frontend-gtk2 fcitx-ui-classic fcitx-ui-light fcitx-rime
im-switch -s fcitx
fcitx
```
========================
### **Solr + Sunspot**

1. `sudo apt-get install openjdk-7-jdk`
2. `sudo apt-get install solr-tomcat`
3. open localhost:8080/solr, check if the solr server is running
4. copy sunspot default schema.xml file -- your_app/solr/conf/schema.xml
   to /usr/share/solr/conf
5. add new instances -- `vim /usr/share/solr/solr.xml`
   
   ```
    <cores adminPath="/admin/cores" defaultCoreName="production">
      <core name="production" instanceDir="." dataDir="production/data"/>
      <core name="staging" instanceDir="." dataDir="staging/data"/>
    </cores>
   ```

6. change data folder location -- `sudo vim /usr/share/solr/conf/solrconfig.xml`

   ```
   <dataDir>${solr.data.dir:}</dataDir>
   ```
  
   copy solr default data folder to the new instance folder
   
   ```
   sudo mkdir /usr/share/solr/production
   sudo cp /var/lib/solr/data /usr/share/solr/production -r
   ```
   
   ```
   sudo chmod 777 /usr/share/solr/production -R
   ```
   
7. restart tomcat -- `sudo service tomcat6 restart`
8. config sunspot in your app

   ```
   ENV['WEBSOLR_URL'] = "http://localhost:8080/solr/production"
   ```

9. run reindex to check everything is ok -- `bundle exec rake sunspot:reindex RAILS_ENV=production`

10. `sudo vim /var/lib/tomcat6/conf/tomcat-users.xml`

   ```
   <role rolename="solr_admin"/>
   <user username="your_username"
      password="your_password"
      roles="solr_admin"
      /> 
  ```
  
11. `sudo vim /usr/share/solr/web/WEB-INT.xml`

   ```
    <security-constraint>
      <web-resource-collection>
        <web-resource-name>Solr Lockdown</web-resource-name>
        <url-pattern>/</url-pattern>
      </web-resource-collection>
      <auth-constraint>
        <role-name>solr_admin</role-name>
        <role-name>admin</role-name>
      </auth-constraint>
    </security-constraint>
    <login-config>
      <auth-method>BASIC</auth-method>
      <realm-name>Solr</realm-name>
    </login-config> 
  ```
  
12. Edit user password anthentication to WEBSOLR_URL

   ```
   ENV['WEBSOLR_URL'] = "http://solr_username:solr_password@localhost:8080/solr/production"
   ```
   
13. change tomcat port
   ```
    sudo vim /var/lib/tomcat6/conf/server.xml 
    #change port 8080 => 8983
    <Connector port="8983" protocol="HTTP/1.1" 
       connectionTimeout="20000" 
       URIEncoding="UTF-8"
       redirectPort="8443" />
   ```
14. auto commit -- `sudo vim /usr/share/solr/conf/solrconfig.xml`

   ```
   #uncomment this block
   <autoCommit>
     <maxDocs>10000</maxDocs>
     <maxTime>1000</maxTime>
   </autoCommit>
   ```
15. set tomcat memory
    ```
    sudo vim /usr/share/tomcat6/bin/setenv.sh
    
    export JAVA_OPTS="-Xms256m -Xmx512m"
    ```

16. additional config -- timeout
    ```
    sudo vim /usr/share/solr/solr.xml
    
    <shardHandlerFactory name="shardHandlerFactory"
      class="HttpShardHandlerFactory">
      <int name="socketTimeout">${socketTimeout:0}</int>
      <int name="connTimeout">${connTimeout:0}</int>
    </shardHandlerFactory>
    ```
    
====================

### rbenv

1. `git clone https://github.com/sstephenson/rbenv.git ~/.rbenv`

2. `echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc`

3. `echo 'eval "$(rbenv init -)"' >> ~/.bashrc`

4. `source ~/.bashrc`

4. `type rbenv`

5. `git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build`

6. `apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev`

7. `rbenv install 2.2.0`


=====================================================================

### Install Mysql Client

`sudo apt-get install libmysqlclient-dev mysql`

==============================================================

### Install Pg Client

```
sudo apt-get install libpq-dev
sudo apt-get install postgresql-client
```
