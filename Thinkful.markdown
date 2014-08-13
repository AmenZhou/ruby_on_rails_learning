Mentor Session - 5/27/14

1 I can define a hash in two types of syntax. 

my_hash = {firstname:'Haimeng', lastname:"Zhou"}

my_hash = {:firstname => 'Haimeng', :lastname => 'Zhou'}

'=>' is called 'hashrocket'

2 Variables in string interpolation format

%d -- a decimal number

%2.f -- 2 digital after point number

%% -- a percent

example: "This meal is %2.f dollars, the tax rate is %d%%, this meal totally costs me %2.f dollars" % [meal_value, tax_rate, meal_with_tax]

======================================================================

Office Hour - 6/2/14
Relation database discussion

Reference: 

Rails Guide about relation data 
http://guides.rubyonrails.org/association_basics.html 


Diagram 
http://yuml.me/edit/cf205763

==========================================================================

Mentor Time -- 06/02/14

1 A useful gem 
https://rubygems.org/gems/better_errors 
http://railscasts.com/episodes/402-better-errors-railspanel

2 User Story 
As a I want to do so that I can achieve this

3 Sql outer Join & inner join 
SELECT a, b FROM A FULL OUTER JOIN B ON a=z 
http://www.w3schools.com/sql/sql_join_inner.asp

=================================================================================

Office Hours

SQL learning
sql.learncodethehardway.org


Display error messages in rails console
art.errors.full_messges


A thinkful student's incredibal learning records
https://github.com/limingth/myRoR/commits/master

Some examples of test in ruby
https://github.com/alexch/learn_ruby

==========================================================

Office Hour


http://eewang.github.io/blog/2013/03/12/how-and-when-to-use-single-table-inheritance-in-rails/

http://thibaultdenizet.com/tutorial/single-table-inheritance-with-rails-4-part-1/

railscasts.com/episodes/394-sti-and-polymorphic-associations

http://railscasts.com/episodes/279-understanding-the-asset-pipeline

http://guides.rubyonrails.org/asset_pipeline.html

https://www.codeschool.com/courses/assembling-sass

=================================================================

Mentor Session

Talking about ORM (object relation mapper)

SQL inner join, outer join, left join, right join


======================================================================

Office Hours

Ajax: http://railscasts.com/episodes/136-jquery-ajax-revised

Single table inheritance: http://thibaultdenizet.com/tutorial/single-table-inheritance-with-rails-4-part-1/

Three useful method

pluck

unq

constantize

=======================================================================

Mentor Time

MVC
1. Data and information
2. Presenting, what info are you showing
3. Access

Models to create structure for your database and they hold business logic
This means all crucial db related info is stored in your models
Views Views are used for presentation

===========================================================================

Office Hour

A gem can be conviently used to switch users for testing purpose -- switch-user

I ask a question about brm project, click a text input bar in form, the content auto disappeared, this is a javascript problem.

Don't be dragged in a problem more than 20 mins.


=================================================================

Office Hour 

present? -- article.present?

each_slice -- 
(1..10).each_slice(3) {|a| p a}
# outputs below
[1, 2, 3]
[4, 5, 6]
[7, 8, 9]
[10]


default_scope

.js.erb  <% j %> -- it can has embedded ruby

Ajax -- an example
https://gist.github.com/mattjstar/259d54f18bac846367b4

railscast -- http://railscasts.com/episodes/136-jquery-ajax-revised

==========================================================

Authentication

omniauth

http://intridea.github.io/omniauth/

http://railscasts.com/episodes/241-simple-omniauth

http://sourcey.com/rails-4-omniauth-using-devise-with-twitter-facebook-and-linkedin

1. Security -- https
2. Authentication -- omniauth + devise
3. Authorization -- cancan

=====================================================================

Office Hour

Learn Ruby -- repo: https://github.com/wolframarnold/learn_ruby
							guide:http://rails-test-2835.use1.nitrousbox.com:8080/00_hello/index.html

Boots camps --http://www.jumpstartlab.com/courses

==============================================================

Office Hour

Ruby-bits -- http://rubybits.codeschool.com/levels/1

Presenter -- http://railscasts.com/episodes/287-presenters-from-scratch

=====================================================================

Unit3 Lesson4

private
def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

helper_method :current_user 

==========================================================================

Procs and lambas

haimeng = Proc.new  { |n| n ** 2 }

haimeng.call(2) => 4

haimeng.call(2, 3) => 4

--------------------------------------

Haimeng = lambda{ |n| n + 2 }

Haimeng(2) => 4

Haimeng(2, 3) => error

-------------------------------------

 l = ->(x,y){ x * y }

=================================================================

 Office Hour

 Learn Ruby

def multiply(*array)
  array.flatten.inject(:*)
end

multiply(2, 3) => 6
multiply([2, 3]) => 6
multiply([2, 3], 3, 4) => 72

===================================================

Office Hour

Git Flow

http://danielkummer.github.io/git-flow-cheatsheet/

==================================================================

Office Hour


Go through my twetter code, alter username to links part.

1 Don't need to use this function in the controller, because this function is only used in the views.

2 raw(string) is better than html_safe, if the string==nil the raw method won't raise error

ref: http://www.tigraine.at/2012/08/23/when-to-use-raw-and-when-to-use-html_safe

3 validates data in the model 

ref: http://guides.rubyonrails.org/active_record_validations.html

4 rescue 

ref: http://guides.rubyonrails.org/action_controller_overview.html#rescue

http://rails-bestpractices.com/posts/702-don-t-rescue-exception-rescue-standarderror

http://stackoverflow.com/questions/3128580/rails-exception-handling

==================================================================

Office Hour

'hello'.methods.grep /case/

%w{foo bar john} => ["foo", "bar", "john"]

omniref

['a', 'b', 'c'].sort_by {|word| word.length}

http://koans.heroku.com/en

================================================================

username is a variable and replace
```ruby
content.gsub(/@(?<username>(\w+))/, '<a href="\k<username>">@\k<username></a>')

# or

gsub(/@(\w+)/, '<a href="\1">@\1</a>')
```

http://www.regular-expressions.info/refext.html

https://docs.djangoproject.com/en/1.6/intro/tutorial03/

http://ruby-doc.org/core-2.0.0/String.html#method-i-gsub


Retwet Part

Display the retweet

<span class="glyphicon glyphicon-retweet smaller text-primary"></span>


=============================================================================

    [:flatten!, :compact!, :uniq!].each{ |meth| ids.send(meth) }
    where(
      arel_table[:user_id]
      .in(ids)
      .or(arel_table[:id].in(
        Retwet.where(:user_id => ids).map(&:twet_id)
      ))
    ).order('created_at DESC')


===================================================================

###Mentor Session

Test Driven Development
This is where you write tests first
Then the test fails
Because you have written the code
Then you write the code
To make the test pass
Failing test
Then write the code that makes it pass
Then you modify or refactor the code
Is by practising
RIght now I won't delve

BDD
Behaviour driven development
Is you test applications behaviour
Test parts
Get request to be sent when a user views all twets
you can test for that
Here what you are looking for how the application interacts with your user

### Mentor Session

######Go through this website to known the basic knowlege of building an online store

http://tutorials.jumpstartlab.com/projects/merchant.html

### Office Hour
```
Matt Star	下午2:24
POSTS
POST: id: 1, content: "great tweet guys", user_id: 3, tweet_id: nil, origin_id: nil
//
POST: id: 1, content: "great tweet guys", user_id: 3, origin_id: nil
POST: id: 2, content: "great tweet guys", user_id: 17, origin_id: 3
//
POST: id: 1, content: "great tweet guys", user_id: 3, tweet_id: nil
POST: id: 2, content: nil, user_id: 17, tweet_id: 1
//
class Retwet < Post
//
def original_user
//
Post.find(2).original_user
User (3)
//
class Retwet
validates :tweet_id, presence: true
//
class Twet
validates :content, presence: true
//
class Post
validates :user_id, presence: true
//
class Retwet < Post
class Twet < Post
class Post < ActiveRecord::Base
//
Matt: "Great office hours guys"
Haimeng: Matt: "Great office hours guys"
Haimeng: Matt: "Great office hours guys"
Real Estate
HOUSES
BROKERS
...
IMAGES
...
HOUSES
IMAGES
house_images
house_image: house_id: 1
image_id: 4
...
HOUSES
BROKERS
IMAGES(houses)
IMAGES(brokers)
...
http://guides.rubyonrails.org/association_basics.html#polymorphic-associations
scout.rawrdenim.com
attachmentable
house_images
image relationships
-store_id
-garment_id
-attachment_id
attachmentable
attachmentable_id
attachmentable_type
....
STORE id: 3
attachmentable_id: 3
attachmentable_type: Store
...
GARMENT id: 14
attachmentable_id: 14
attachmentable_type: Garment
...
attachment_id: ...
ATTACHMENTS
ATTACHMENTABLES
GARMENTS
STORES
has_many :attachments
as: attachmentable
http://railscasts.com/episodes/154-polymorphic-association-revised
```

### Office Hour
###### A ping pong game

https://github.com/michaelfairley/pong

###### .ruby-version replace .rvmrc

### Mentor Session
https://delicious.com/

http://guides.spreecommerce.com/developer/getting_started_tutorial.html

http://doc.locomotivecms.com/

http://blog.referralcandy.com/2014/02/26/24-best-ecommerce-website-designs-inspire/

http://helmboots.com/

http://www.shopify.com/blog/11863377-30-beautiful-and-creative-ecommerce-website-designs

### Office Hour Sidekiq
###### Sidekiq is gem for background work, it works with redis

http://railscasts.com/episodes/366-sidekiq

Redis is an open source, BSD licensed, advanced key-value cache and store. It is often referred to as a data structure server since keys can contain strings, hashes, lists, sets, sorted sets, bitmaps and hyperloglogs.
"delayed_jobs" => {"1" => "Store.delete_all" }

### Mentor Session
ruby learning http://designthinkingbook.co.uk/  http://koans.heroku.com/en

ruby books recommend
	Practical Object 
	Oriented Rubyz

http://www.sitepoint.com/simple-testing-ruby-using-minitest/
