#####Which of the following is NOT a valid tool for combining multiple bits of output to form the overall response?

A		partials
B		yield and content_for
C		asset tags
D		combine_to

My Answer: D


#####Which of the following extensions is appended to an image being linked if only the image name is specified?

Answer: Can't do it.



#####Which of the following options will provide an image for a video before it starts playing?



#####Which of the following application configuration options prevents passwords from being stored in the log files?

```ruby
filters = Rails.application.config.filter_parameters
f = ActionDispatch::Http::ParameterFilter.new filters
f.filter :password => 'haha' # => {:password=>"[FILTERED]"}
```

#####Which of the following methods skips validations and will save an object to the database regardless of its validity?

update_attribute


Test Name:	Ruby on Rails 3.0

Test Date:	1/30/2015

Elapsed Time:	00:17:41

Questions Correct:	32 out of 39

Percent Correct:	82%

Percentile Ranking:	40

Global Average:	71%



============================================================

##### double class

#####  FactoryGirl without ActiveRecord

##### has_many, through

======================================================================

##### Lambda Proc and Block

. Procs are objects, blocks are not

. At most one block can appear in an argument list

. Lambdas check the number of arguments, while procs do not

. Lambdas and procs treat the ‘return’ keyword differently

http://awaxman11.github.io/blog/2013/08/05/what-is-the-difference-between-a-block/

=================================================================

##### Symbol and String

. Symbol is not mutable but String is

```ruby
puts "hello" << " world"
puts :hello << :" world"

# => hello world
# => *.rb:4: undefined method `<<' for :hello:Symbol (NoMethodError)
```
. Symbol can be resused and not destroyed after used, but String can not

```ruby
#Each String oject has unique id
puts "hello world".object_id
puts "hello world".object_id
puts "hello world".object_id
puts "hello world".object_id
puts "hello world".object_id

# => 3102960
# => 3098410
# => 3093860
# => 3089330
# => 3084800


puts :"hello world".object_id
puts :"hello world".object_id
puts :"hello world".object_id
puts :"hello world".object_id
puts :"hello world".object_id

# => 239518
# => 239518
# => 239518
# => 239518
# => 239518
```

. Performance -- Symbol computation is faster than String

================================================================================

require_relative complements the builtin method require by allowing you to load a file that is relative to the file containing the require_relative statement.

For example, if you have unit test classes in the "test" directory, and data for them under the test "test/data" directory, then you might use a line like this in a test case:

===============================================================================

##### Explain each of the following operators and how and when they should be used: ==, ===, eql?, equal?.

== – Checks if the value of two operands are equal (often overridden to provide a class-specific definition of equality).

=== – Specifically used to test equality within the when clause of a case statement (also often overridden to provide meaningful class-specific semantics in case statements).

eql? – Checks if the value and type of two operands are the same (as opposed to the == operator which compares values but ignores types). For example, 1 == 1.0 evaluates to true, whereas 1.eql?(1.0) evaluates to false.

equal? – Compares the identity of two objects; i.e., returns true iff both operands have the same object id (i.e., if they both refer to the same object). Note that this will return false when comparing two identical copies of the same object.

========================================================================================

##### difference between Concat and +=

```ruby
#concat change object itself
foo = "foo"
foo2 = foo
foo.concat "bar"

puts foo
=> "foobar"
puts foo2
=> "foobar"

#+= create a new object, not change itself
foo += "baz"
puts foo
=> "foobarbaz"
puts foo2
=> "foobar"
```
===========================================================================================

##### In Ruby code, you quite often see the trick of using an expression like array.map(&:method_name) as a shorthand form of array.map { |element| element.method_name }. How exactly does it work?

When a parameter is passed with & in front of it (indicating that is it to be used as a block), Ruby will call to_proc on it in an attempt to make it usable as a block. Symbol#to_proc quite handily returns a Proc that will invoke the method of the corresponding name on whatever is passed to it, thus enabling our little shorthand trick to work.

===============================================================================================

##### In Ruby, the only values that evaluate to false are false and nil. Everything else – even zero (0) and an empty array ([]) – evaluates to true.

=================================================================================================

##### What is the difference between calling super and calling super()?

A call to super invokes the parent method with the same arguments that were passed to the child method. An error will therefore occur if the arguments passed to the child method don’t match what the parent is expecting.

A call to super() invokes the parent method without any arguments, as presumably expected. As always, being explicit in your code is a good thing.

============================================================================================

##### Notice the argument of the method call

```ruby
def times_two(arg1);
  puts arg1 * 2;
end

def sum(arg1, arg2);
  puts arg1 + arg2;
end

times_two 5 #=>10
times_two(5) #=>10
times_two (5) #=>10
sum 1, 2 #=>3
sum(1, 2) #=>3
sum (1, 2) #=> syntax error
```
The problem is the space between the method name and the open parenthesis. Because of the space, the Ruby parser thinks that (1, 2) is an expression that represents a single argument, but (1, 2) is not a valid Ruby expression, hence the error.

Note that the problem does not occur with single argument methods (as shown with our timesTwo method above), since the single value is a valid expression (e.g., (5) is a valid expression which simply evaluates to 5).

===============================================================================

##### Proc and []

Is the line of code below valid Ruby code? If so, what does it do? Explain your answer.
```ruby
-> (a) {p a}["Hello world"]
```
**Yes**

You can call a Proc by using either the call method on Proc, or by using the square bracket syntax, so this line of code also invokes the Proc and passes it the string “Hello World”.

So putting that all together, this line of code (a) creates a Proc that takes a single parameter a which it prints out and (b) invokes that Proc and passes it the string “Hello world”. So, in short, this line of code prints “Hello World”.

================================================================================

##### `and` compare with `&&`

`and` has lower precedence than `&&`

```ruby
#this line is equal to (val1 = true) and false
val1 = true and false  # hint: output of this statement in IRB is NOT value of val1!
val2 = true && false
```

==========================================================================================

##### What is CSRF? How does Rails protect against it?

CSRF stands for Cross-Site Request Forgery. This is a form of an attack where the attacker submits a form on your behalf to a different website, potentially causing damage or revealing sensitive information. Since browsers will automatically include cookies for a domain on a request, if you were recently logged in to the target site, the attacker’s request will appear to come from you as a logged-in user (as your session cookie will be sent with the POST request).

In order to protect against CSRF attacks, you can add protect_from_forgery to your ApplicationController. This will then cause Rails to require a CSRF token to be present before accepting any POST, PUT, or DELETE requests. The CSRF token is included as a hidden field in every form created using Rails’ form builders. It is also included as a header in GET requests so that other, non-form-based mechanisms for sending a POST can use it as well. Attackers are prevented from stealing the CSRF token by browsers’ “same origin” policy.

=======================================================================================

##### Self-referential relationships

How would you define a Person model so that any Person can be assigned as the parent of another Person (as demonstrated in the Rails console below)? What columns would you need to define in the migration creating the table for Person?
```
irb(main):001:0> john = Person.create(name: "John")
irb(main):002:0> jim = Person.create(name: "Jim", parent: john)
irb(main):003:0> bob = Person.create(name: "Bob", parent: john)
irb(main):004:0> john.children.map(&:name)
=> ["Jim", "Bob"]
```
And for a more advanced challenge: Update the Person model so that you can also get a list of all of a person’s grandchildren, as illustrated below. Would you need to make any changes to the corresponding table in the database?
```
irb(main):001:0> sally = Person.create(name: "Sally")
irb(main):002:0> sue = Person.create(name: "Sue", parent: sally)
irb(main):003:0> kate = Person.create(name: "Kate", parent: sally)
irb(main):004:0> lisa = Person.create(name: "Lisa", parent: sue)
irb(main):005:0> robin = Person.create(name: "Robin", parent: kate)
irb(main):006:0> donna = Person.create(name: "Donna", parent: kate)
irb(main):007:0> sally.grandchildren.map(&:name)
=> ["Lisa", "Robin", "Donna"]
```

Normally, the target class of an ActiveRecord association is inferred from the association’s name (a perfect example of “convention over configuration”). It is possible to override this default behavior, though, and specify a different target class. Doing so, it is even possible to have relationships between two objects of the same class.

This is how it is possible to set up a parent-child relationship. The model definition would look like:

```ruby
class Person < ActiveRecord::Base
  belongs_to :parent, class: Person
  has_many :children, class: Person, foreign_key: :parent_id
end
```

It’s necessary to specify the foreign_key option for the has_many relationship because ActiveRecord will attempt to use :person_id by default. In the migration to create the table for this model, you would need to define, at minimum, a column for the name attribute as well as an integer column for parent_id.

Self-referential relationships can be extended in all the same ways as normal two-model relationships. This even includes has_many ... :through => ... style relationships. However, because we are circumventing Rails’ conventions, we will need to specify the source of the :through in the case of adding a grandchild relationship:

```ruby
class Person < ActiveRecord::Base
  belongs_to :parent, class: Person
  has_many :children, class: Person, foreign_key: :parent_id
  has_many :grandchildren, class: Person, through: :children, source: :children
end
```

Consequently, since this is still just using the parent_id defined in the first case, no changes to the table in the database are required.

##### custom url

Create a route to be able to display pages with different information about different types of beer. The route should recognize URL paths like /beer/<beer_type> and should use the same controller action for each type of beer with the actually beer type passed into the controller action as a parameter. The valid beer types are:

IPA
brown_ale
pilsner
lager
lambic
hefeweizen
Any other type of beer specified should generate a 404 status code.


**Answer**

One option would be to generate a simple get route that specifies the controller action to call and passes the kind of beer as a parameter:

```ruby
get 'beers/:kind' => 'beers#kind'
```

Then, within the context of the controller action, if the kind parameter is not included in the list of valid kinds, the action can raise a ActionController::RoutingError, which will redirect to 404 in production.

Alternatively, a simpler solution is to check against the list of valid kinds in the definition of the route. This can be accomplished using the constraints option as follows:

```ruby
kinds = %w|IPA brown_ale pilsner lager lambic hefweizen|
get 'beers/:kind' => 'beers#kind', constraints: {kind: Regexp.new(kinds.join('|'))}
```

This code calls the BeersController#kind action method with params['kind'] set to a string representing the beer type given in the URL path. The key is using the constraints option for the route to specify a regular expression to use to verify the route is correct. In this case, the lambda checks to see that the kind parameter is included in the list of valid beer types.

Or perhaps an even better solution would be to use resource routing. This has the added benefit of providing URL generation helpers, but at the cost of requiring that the parameter name for the beer be passed as :id. This would look something like:

```ruby
kinds = %w|IPA brown_ale pilsner lager lambic hefweizen|
resource :beer, only: [:show], constraints: {id: Regexp.new(kinds.join('|'))}
```
=======================================================================================

##### n+1 problem

What’s the issue with the controller code below? How would you fix it?

```ruby
class CommentsController < ApplicationController
  def users_comments
    posts = Post.all
    comments = posts.map(&:comments).flatten
    @user_comments = comments.select do |comment|
      comment.author.username == params[:username]
    end
  end
end
```

This is a classic example of the notorious “n+1” bug. The first line will retrieve all of the Post objects from the database, but then the very next line will make an additional request for each Post to retrieve the corresponding Comment objects. To make matters worse, this code is then making even more database requests in order to retrieve the Author of each Comment.

This can all be avoided by changing the first line in the method to:

```ruby
posts = Post.includes(comments: [:author]).all
```

This tells ActiveRecord to retrieve the corresponding Comment and Author records from the database immediately after the initial request for all Posts, thereby reducing the number of database requests to just three.

Please note that the above answer is only one of a few ways that it is possible to avoid incurring an “n+1” penalty, and each alternative will have its own caveats and corner cases. The above answer was selected to be presented here since it requires the smallest change to the existing code and makes no assumptions regarding the reverse association of Comment to Post.

============================================================================================

##### What is a class, what is an object and why we need modules

This may be simple, but it allows to start a conversation between two strangers involved into the same craft.

Answer: classes are a blue-print, they may hold data, likely they hold methods; classes are directly connected with an idea of objects, because object is an instance of a class. As objects are first-class citizens in Ruby, there is a main, root class Object, and all classes are inherited from this root entity. Modules, generally, are a tool for mix-ins and they provide something we call a namespace. Modules cannot be initialised the way we can do this with classes, but they provide a multiple inheritance.

=========================================================================================

##### Who’s _why and what’s up with his Shoes?

Answer: ‘why the lucky stiff’ (or ‘_why’) is the artist from a past decade, who used Ruby as his brush, and our minds as a canvas. He is both writer, cartoonist, artist, and computer programmer, famous by his contribution to many Open Source Ruby projects, “Why’s Poignant Guide to Ruby” piece of art and who disappeared in 2009. Shoes is a nice OSI project, initially made by _why, and it allows to create nice looking GUI applications using Ruby, for programmers of any age (from 3 to 100 years old). Shoes now are fine and quite active thanks to Shoes Team. You can find it on Github.

===========================================================================================

##### Why automated testing is a good and bad thing in the same time

Answer: automated testing (especially as the main tool of TDD/BDD) is an absolutely important part of modern applications development. This is your friend during refactoring, development and debugging. This is the way how you understand your codebase deeper, a way to predict bottle-necks, and sometimes it allows you to keep your code maintainable without unnecessary investments for years. In the same time, automated testing could be a source of terrible bugs and fails, as by itself, tests are the same code, as the ‘real’ code. This way, automating testing is an another tool to help your mind keep architecture and abstractions in the form of the code, speed-up things and automate sanity-tests. Which doesn’t mean you always have to pay your attention on manual testing.

==============================================================================================

##### What is Lambda? What is Proc? What is Block? What is Dash Rocket (stabby lambda)?

Answer: They are from the same plate, however there are differences. Firstly, Proc is a nameless function, an anonymous method you use very frequently. Procs are objects, Blocks are not. Blocks are ‘business cards’ of Ruby, and they are, in fact, a syntax literals of Proc; they may take and return values. The main difference between Lambdas and Procs is Lambda explicitly check for arguments, while Proc is not. Stabby lambda ( -> ) is nothing more than another Lambda literal, from Ruby >= 1.9, you may easily think of this like of syntax sugar.

================================================================================================

##### Agile Development

The Agile Manifesto is based on 12 principles:[9]

1. Customer satisfaction by rapid delivery of useful software
2. Welcome changing requirements, even late in development
3. Working software is delivered frequently (weeks rather than months)
4.Close, daily cooperation between business people and developers
5.Projects are built around motivated individuals, who should be trusted
6.Face-to-face conversation is the best form of communication (co-location)
7.Working software is the principal measure of progress
8.Sustainable development, able to maintain a constant pace
9.Continuous attention to technical excellence and good design
10.Simplicity—the art of maximizing the amount of work not done—is essential
11.Self-organizing teams
12.Regular adaptation to changing circumstance

===================================================================================================

##### A Rails-specific question: how Date.today differs from Date.current?

Answer: It’s all about time zones: with Date.today you’ll have a system date, with Date.current it's system date, plus Rails’ time zone applied. Funny, but Time.zone.today should return you a date with a time zone too.

==================================================================================================

##### Skinny Controllers. Logic-less (as much as possible) templates. But where we’ll keep this zillions lines of code this way?

Answer: first answer could be, we’ll move controller’s code to models. Oookay. But we’ll have Fat Models (tm) this way, right? Then we’ll move everything to Rails’ concerns! And we’ll separate reusable code as libraries and gems. And this is true. The fact is it could be (sic!) even worse than to keep everything in models. One of the ways is, for example, to radically change architecture, introducing Rails' engines (and here you can talk about differences between gem and Rails Engine) or even partially move the code to the separated Rack application, and link your host with Rack app via internal API (here is the good place to talk about general application architecture). Or you can implement Data/Context/Interaction approach (here is the good place to talk about advanced architectural themes). After this, you’ll feel if it is reasonable to talk about Model-Views and Decorators.

===============================================================================================

##### What is database transactions and how it is represented in Rails

Answer: transactions are sets of changes, that must all be made together. It may, or may not change the contents of the database. When we talk about transactions, we usually mean we need to do something with database as single unit execution. A classy transaction is when you withdraw money from one bank account to another, and you need to substract from one bank account and add to another in the same time. In Rails you have ActiveRecord::Base.transaction, which allows you to easily pass multiple actions in a block, and they’ll be executed a transactional way.

===============================================================================================

