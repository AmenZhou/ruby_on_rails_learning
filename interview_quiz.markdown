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
