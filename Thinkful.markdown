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
content.gsub(/@(?<username>(\w+))/, '<a href="/\k<username>">@\k<username></a>')


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

Mentor Session

 TDD
[3:36:51 PM] Alvin Kato: Test Driven Development
[3:36:56 PM] Alvin Kato: This is where you write tests first
[3:37:06 PM] Alvin Kato: Then the test fails
[3:37:11 PM] Alvin Kato: Because you have written the code
[3:37:15 PM] Alvin Kato: Then you write the code
[3:37:20 PM] Alvin Kato: To make the test pass
[3:37:30 PM] Alvin Kato: Failing test
[3:37:38 PM] Alvin Kato: Then write the code that makes it pass
[3:37:47 PM] Alvin Kato: Then you modify or refactor the code
[3:37:59 PM] Alvin Kato: Is by practising
[3:38:05 PM] Alvin Kato: RIght now I won't delve

[3:38:33 PM] Alvin Kato: BDD
[3:38:43 PM] Alvin Kato: Behaviour driven development
[3:38:51 PM] Alvin Kato: Is you test applications behaviour
[3:38:56 PM] Alvin Kato: Test parts
[3:39:13 PM] Alvin Kato: Get request to be sent when a user views all twets
[3:39:17 PM] Alvin Kato: you can test for that
[3:39:29 PM] Alvin Kato: Here what you are looking for how the application interacts with your user

