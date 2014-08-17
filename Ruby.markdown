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
### Object Compare
ruby can't compare two instances of some classes by using eql? or uniq, blow is a way to do this
```ruby
class Item
  attr_reader :item_name, :qty
  
  def initialize(item_name, qty)
    @item_name = item_name
    @qty = qty
  end
  
  def to_s
    "Item (#{@item_name}, #{@qty})"
  end
  
  def hash
    self.item_name.hash ^ self.qty.hash
  end

  def eql?(other_item)
    puts "#eql? invoked"
    @item_name == other_item.item_name && @qty == other_item.qty
  end
  
end
```


```ruby
class Item
  def initialize(item_name, quantity, supplier_name, price)
    @item_name = item_name
    @quantity = quantity
    @supplier_name = supplier_name
    @price = price
  end 
  
  # implement ==, eql? and hash
  def hash
    @item_name.hash ^ @quantity.hash ^ @supplier_name.hash ^ @price.hash
  end
  
  def ==(other_item)
    self.hash == other_item.hash
  end
  
  def eql?(other_item)
    self.==(other_item)
  end
end
```
### YAML
```ruby
class Ogre
  attr_accessor :strength, :speed, :smell
  def initialize(strength, speed, smell)
    @strength = strength
    @speed = speed
    @smell = smell
  end
end

class Dragon
  attr_accessor :strength, :speed, :color
  def initialize(strength, speed, color)
    @strength = strength
    @speed = speed
    @color = color
  end
end

class Fairy
  attr_accessor :strength, :speed, :intelligence
  def initialize(intelligence)
    @strength = 1
    @speed = 42
    @intelligence = intelligence
  end
end

def save_game(characters)
	# TODO: serialize a character hash of :ogres, :dragons, and :fairies  
  gf = GameFile.new(".yaml")
  yaml = YAML::dump(characters)
  p yaml
  gf.write(yaml)
end

def load_game
  # TODO: return a deserialized hash of characters
  gf = GameFile.new(".yaml")
  yaml = gf.read
  # YAML don't need to be call under an object, it can be call outside. 
  YAML::load(yaml)
end
```
