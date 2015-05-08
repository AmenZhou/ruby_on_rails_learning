The Procfile of Heroku

If we want to run resque work on heroku, we must add a Procfile to Heroku. 
It's on the root of the app. It usually begins with   web:  or resque:  etc.
Except the web:, other works will charge us money.
 
When upload Procfile by git. We run "heroku scale resque=1" to start it up. 

Reference: 
Resque in Heroku: https://devcenter.heroku.com/articles/queuing-ruby-resque
Procfile in Heroku: https://devcenter.heroku.com/articles/procfile

===================================================================================

Install Heroku in Ubuntu

1  install toolbelt
  wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

2  git add remote 
 git remote add heroku git@XXXX.git

3  add key
heroku keys:add ~/.ssh/id_rsa.pub

====================================================================================

### Heroku remote add

```
 heroku git:remote -a appname
```
