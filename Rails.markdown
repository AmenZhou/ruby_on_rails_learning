###Cookies in Rails

1 Set a cookie with a hash which has two members 
```
cookies[:remember_token] = { value: remember_token, 
expires: 20.years.from_now.utc }
```
2 Set a cookie by permanent method 
```
cookies.permanent[:remember_token] = remember_token
```
3 Delete cookie 
```
cookies.delete(:remember_token)
```
==================================================================
How to process the "Sign in" in Rails

1 Create a Session 
. generate a session controller 
. have three method in the session controller: create, new and destroy 
. under the new method, we create a page as log in page 
. verify the email and password in the create method, two steps: get user by email and check password by user.authenticate

2 Add a Cookie Store on Both Server Side and Browser Side 
. generate a cookie 
. save that cookie to the client's browser 
. save the cookie to the database which on the user's table, recommend to encrypt

3 Create an instant variable @current_user 
. each time open a new page, all the variable will be cleared. So get the cookies from the client's browser when each time users open a new page

4 Using @current_user to identify the user

========================================================================

Render and Redirect_to

http://guides.rubyonrails.org/layouts_and_rendering.html

======================================================================

Question!
How to call a class in the module?

In the module, it can require a file then the class can be used.

But in the redis, the module is background running, it can't call any classes in other files.

=================================================================================

debugger can't be installed in 2.1.2

use byebug replace it temparary

=======================================================================

Run production env

rake db:migrate RAILS_ENV='production'


==========================================================================

Git ignore

if you want to remove an exist file in git repo

1  must rm this file in the local

2  then type git rm file

3  edit .gitignore add this file into it

4  commit it

=========================================================================

unicorn to background run rails 

Gem

unicorn_rails -E production -D -p 3000

=======================================================================

Run Resque background

nuprake resque:work QUEUE=* BACKGROUND=yes RAILS_ENV=production

nohup rake resque:work QUEUE=*  BACKGROUND=true

=======================================================================

foreman

Gem

start all the rails related services in single line

Start resque with rails
http://blog.daviddollar.org/2011/05/06/introducing-foreman.html 


Start all the rails service and related jobs when start up
sudo foreman export --app sms --user amen upstart /etc/init

this command will export several files that can start all the services by service start command

reference
http://railscasts.com/episodes/281-foreman

========================================================================

Disable auto run service

sudo sh -c "echo 'manual' > /etc/init/SERVICE.override"

========================================================================

acts_as_taggable_on

Gem

ref:http://railscasts.com/episodes/382-tagging

Question: can read, but can't edit.

======================================================

delegate

ref: http://apidock.com/rails/Module/delegate

================================================

Use default ruby version in project

You can tell RVM to always use a specific ruby version and gemset when you are in a project, by creating a simple .rvmrc file with a one line instruction like:

rvm ruby-1.9.3-p374@mygemset

===========================================================

kaminari

A Gem for page split and jumping

=============================================================

Devise

redirect to another page when login failed

http://stackoverflow.com/questions/5832631/devise-redirect-after-login-fail

============================================================

Render 

render a partial and pass a variable, must add 'partial' before partial file name

render partial: 'partial_file', locals {var: @var} 

=============================================================

has_many

has_many :mapping_table, dependent: :destroy
has_many :a_table, ->{uniq}, through: :mapgging_table

===============================================================

Add index

add_column :cog_issues_supports, :id, :primary_key

==============================================================

Git

change branch before commit code, merge modifying code to new branch
git checkout -m branch

=======================================================================

Form Helper

select_tag "people", options_from_collection_for_select(@people, "id", "name")

==================================================================

Skinny Controller and Skinny Model

http://robots.thoughtbot.com/skinny-controllers-skinny-models

============================================================================

Simple Form

https://github.com/plataformatec/simple_form

===========================================================================

persisted?()

Returns true if the record is persisted, i.e. it's not a new record and it was not destroyed, otherwise returns false.

=============================================================================

.rvmrc

rvm use ruby-2.1.2@rvmname --create

=========================================================================

Sql

update_all

http://apidock.com/rails/ActiveRecord/Base/update_all/class

=======================================================================

Google Chart

https://google-developers.appspot.com/chart/interactive/docs/gallery/piechart

======================================================================

Splat Agument

  def self.by_user_ids(*ids)
    where(:user_id => ids.flatten.compact.uniq).order('created_at DESC')
  end
  
  Twet.by_user_ids(id, *follows.map(&:following_id))
  
ref: http://endofline.wordpress.com/2011/01/21/the-strange-ruby-splat/

=========================================================================
Image Magic

sudo apt-get install libmagickwand-dev imagemagick

====================================================================

Devise 

add attribute need permit

validate :registration_code_valid?, on: :create, if: Proc.new { |u| u.front_flag.present? }

=========================================================================================
form helper

https://github.com/superbay/knowledge/blob/master/rails_basic/form/select_tag.markdown

=======================================================================================

In model, if do this, it will be a dead loop

before_save :do_some_thing

def do_some_thing
  update_attributes(attr_a: a; attr_b: b)
end

To solve that

def do_some_thing
  self.attr_a = a
  self.attr_b = b
end

=======================================================================

###ruby send method

```ruby
 %w(mon tue wed thu fri sat sun).each do |week_day|                                                                                             │·······
        eval("hash[:#{week_day}] = row.#{week_day}")                                                                                                 │·······
        #eval("hash[:#{week_day}] = row.#{week_day}")                                                                                                │·······
        hash.send(:[]=, week_day.to_sym, row.send(week_day))                                                                                         │·······
 end 
 
```
======================================================================

###Best in place

[https://github.com/bernat/best_in_place](https://github.com/bernat/best_in_place)


### Markdown Basic
https://help.github.com/articles/markdown-basics

### Turbolinks Turn Off

###### application.html.erb
```ruby
<%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
<%= javascript_include_tag 'application' %>
```

http://railscasts.com/episodes/390-turbolinks

### gemset
###### use default project ruby version

```
vim .rvmrc
rvm use 2.1.2@tweter


rvm use 2.1.2

rvm gemset create tweter
```

### belongs_to class name
```ruby
#retwet model 
#attr: origin_id => user_id

belongs_to :origin, class_name: 'User'

```

### ruby running path
```
ruby -I . test/test_calculator.rb
```
