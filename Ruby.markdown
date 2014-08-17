Ruby--a method with an optional hash parameter


def add(*nums) 
sum = nums.inject(0){|sum, num| sum + num} 
sum 
end

def subtract(*nums) 
sum = nums.inject {|sum, num| sum - num} 
sum 
end

def calculate(*nums) 
if nums.last.is_a?(Hash) 
options = nums.last 
nums.last.delete 
add(*nums) if options[:add] 
subtract(*nums) if options[:subtract] 
else 
add(*nums) 
end 
end

calculate(2 ,3, add: true)

=================================================================

Slim

https://github.com/slim-template/slim

define a variable: -a = 'hello'

====================================================================

String

replace string -- String.gsub(pattern, replace_str)

e.g. "929-111-1111".gsub(/[^0-9]/, "") => "9291111111"

==================================================================

Compact

[ "a", nil, "b", nil, "c" ].compact! #=> [ "a", "b", "c" ]

### Block
```ruby
def foo
  yield if block_given?
end
```
###### yield with arguments
```ruby
def calculation(a, b)
  yield(a, b)
end

puts calculation(5, 6) { |a, b| a + b } # addition
puts calculation(5, 6) { |a, b| a - b } # subtraction
```
### Implicit and Explicit Block
```ruby
Filter = lambda do |array, &block|
  array.select(&block)
end

Filter.call([1, 2, 3, 4]) {|number| number.even? } returns [2, 4] 
```
```ruby
def filter(array, block)
 return array.select(&block)
end
filter([1, 2, 3, 4], lambda {|number| number.even? }) returns [2, 4] 
```
### Array Shuffle
Problem Statement
Given a 3 or 4 digit number with distinct digits, return a sorted array of all the unique numbers that can be formed with those digits.

Example: 
Given: 123 
Return: [123, 132, 213, 231, 312, 321]

```ruby
def number_shuffle(number)
  # your code here
  rs_size = number.to_s.size == 3 ? 6 : 24
  number = number.to_s.split("")
  rs = []
  while(rs.size < rs_size) do
    rs << number.shuffle.join("").to_i
    rs = rs.sort.uniq
  end
  rs
end
```
### Block

Problem Statement
Given a custom class MyArray, 
write a 'sum' method that takes a block parameter.

Example: 
my_array = MyArray.new([1, 2, 3]) 
my_array.sum gives 6 
my_array.sum(10) gives 16 
my_array.sum(0) {|n| n ** 2 } gives 14

```ruby
class MyArray
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def sum(initial_value = 0)
    # your code here
    if block_given?
      @array.inject(0){|sum, i| sum += yield(i)} + initial_value
    else
      @array.inject(0){|i, sum| sum += i} + initial_value
    end
  end
end
```

### Sort by string length

https://rubymonk.com/learning/books/1-ruby-primer/problems/14-sort-string-words

```ruby
def sort_string(string)
  # your code here
  string.split(" ").sort{|a, b| a.length <=> b.length}.join(" ")
end
```
### Boolean Expressions

```ruby
is_an_experienced_programmer = (candidate.years_of_experience >= 2 or (candidate.years_of_experience < 2 and candidate.github_points >= 500)) and candidate.age >= 15  and !candidate.applied_recently? and candidate.languages_worked_with.include?('Ruby')# Fill your expression here
```
### Ascend 
http://rubymonk.com/learning/books/4-ruby-primer-ascent/chapters/37-classes-inheritance/lessons/83-understanding-inheritance
```ruby
def is_ancestor?(klass, subclass)
  # your code here
  father = subclass.superclass
  while(father != klass and father != BasicObject) do
    father = father.superclass
  end
    father != BasicObject
end
```
### Class Variable

https://rubymonk.com/learning/books/4-ruby-primer-ascent/chapters/45-more-classes/lessons/113-class-variables

```ruby
class ApplicationConfiguration
  def self.set(property_name, value)
    @@property_name = value
  end
  
  def self.get(property_name)
    @@property_name
  end  
end

ApplicationConfiguration.set("name", "Demo Application")
ApplicationConfiguration.set("version", "0.1")

p ApplicationConfiguration.get("version")
```

### Class Instance Variable

```ruby
class ApplicationConfiguration
  @configuration = {}

  def self.set(property, value)
    @configuration[property] = value
  end

  def self.get(property)
    @configuration[property]
  end
end

class ERPApplicationConfiguration < ApplicationConfiguration
  @configuration = {}
end

class WebApplicationConfiguration < ApplicationConfiguration
  @configuration = {}
end

ERPApplicationConfiguration.set("name", "ERP Application")
WebApplicationConfiguration.set("name", "Web Application")

p ERPApplicationConfiguration.get("name")
p WebApplicationConfiguration.get("name")

p ApplicationConfiguration.get("name")
```
