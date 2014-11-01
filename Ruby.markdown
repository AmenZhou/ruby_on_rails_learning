Ruby--a method with an optional hash parameter

```ruby
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
```
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

### Class Inherite
http://rubymonk.com/learning/books/4-ruby-primer-ascent/problems/85-whodunnit#solution4016

```ruby
def location_in_hierarchy(object, method)
  klass = object.class
  ancestors = [klass]
  while not (superclass = klass.superclass).nil?
    ancestors << superclass
    klass = superclass
  end
  ancestors.reverse.find do |ancestor| 
    ancestor.instance_methods.include?(method)
  end
end
```

### Orders and Cost
http://rubymonk.com/learning/books/1-ruby-primer/problems/155-restaurant
```ruby
class Restaurant
  def initialize(menu)
    @menu = menu
  end

  def cost(*orders)
    # your code here
    cost = 0
    orders.each do |order|
      order.each do |k, v|
        cost += @menu[k] * v
      end
    end
    cost
  end
end
```
Official Answer
```ruby
class Restaurant
  def initialize(menu)
    @menu = menu
  end

  def cost(*orders)
    orders.inject(0) do |total_cost, order|
      total_cost + order.keys.inject(0) {|cost, key| cost + @menu[key]*order[key] }
    end
  end
end
```

### Palindromes

http://rubymonk.com/learning/books/1-ruby-primer/problems/143-palindrome#solution4780

```ruby
def palindrome?(sentence)
  # Write your code here
  str = sentence.downcase.gsub(" ", "")
  str == str.split("").reverse.join("")
end
```
Official Anwser
```ruby
def palindrome?(sentence)
  downcase_stripped_sentence = sentence.downcase.gsub(" ", "")
  downcase_stripped_sentence  ==  downcase_stripped_sentence.reverse
end
```

### Find non-duplicate values in an Array
http://rubymonk.com/learning/books/1-ruby-primer/problems/147-non-duplicate-values

```ruby
def non_duplicated_values(values)
  # Write your code here
  values.delete_if{|v| values.count(v) > 1}
end
```
Official Anwser
```ruby
def non_duplicated_values(values)
  values.find_all { |x| values.count(x) == 1 }
end
```

### Enough Contrast?

http://rubymonk.com/learning/books/1-ruby-primer/problems/152-color-contrast

```ruby
class Color
  attr_reader :r, :g, :b
  def initialize(r, g, b)
    @r = r
    @g = g
    @b = b
  end

  def brightness_index
    (@r*299 + @g*587 + @b*114) / 1000
  end
  
  def brightness_difference(another_color)
    #your code here
    (self.brightness_index - another_color.brightness_index).abs
  end

  def hue_difference(another_color)
    #your code here
    (@r - another_color.r).abs + (@g - another_color.g).abs + (@b - another_color.b).abs
  end

  def enough_contrast?(another_color)
    # your code here
    brightness_difference(another_color) > 125 and hue_difference(another_color) > 500
  end
end
```
Official Anwser

```ruby
class Color
  attr_reader :r, :g, :b
  def initialize(r, g, b)
    @r = r
    @g = g
    @b = b
  end

  def brightness_index
    (r*299 + g*587 + b*114) / 1000
  end

  def brightness_difference(another_color)
    (brightness_index - another_color.brightness_index).abs
  end

  def hue_difference(another_color)
    (r-another_color.r).abs +
    (g-another_color.g).abs +
    (b-another_color.b).abs
  end

  def enough_contrast?(another_color)
    brightness_difference(another_color) > 125 && hue_difference(another_color) > 500
  end
end
```
### Check if all elements in an array are Fixnum

http://rubymonk.com/learning/books/1-ruby-primer/problems/148-array_of_fixnum

```ruby
def array_of_fixnums?(array)
  # Write your code here
  array.each {|n| return false unless n.is_a?(Fixnum) }
end
```
Official Answer
```ruby
def array_of_fixnums?(array)
  array.all? { |x| x.is_a? Fixnum }
end
```

### Kaprekar's Number

http://rubymonk.com/learning/books/1-ruby-primer/problems/150-kaprekar-s-number#solution4794
```ruby
def kaprekar?(k)
  num = k * k
  i = 10
  while(num / i != 0)
    p num % i + num / i
    return true if (num % i + num / i) == k
    i *= 10
  end
  false
end
```
Official
```ruby
def kaprekar?(k)
  no_of_digits = k.to_s.size
  square = (k ** 2).to_s
  
  second_half = square[-no_of_digits..-1]
  first_half = square.size.even? ? square[0..no_of_digits-1] : square[0..no_of_digits-2]
  
  k == first_half.to_i + second_half.to_i
end
```

### Splat

Calculate median num of a array
[1 ,2, 3] => 2
[1, 2, 3, 4] => 2.5

```ruby
def median(*list)
  # write your method here
  return if list.empty?
  arry = *list.sort
  size = arry.size
  arry.size.even? ? (arry[size / 2] + arry[size / 2 - 1]).to_f / 2 : arry[size / 2]
end
```
###

```ruby
zen = *(1..42) #=> [1, 2, 3, ... 42]
str = *"Zen" #=> ['Zen']
```
```ruby
[[1, 2, 3, 4], [42, 43]].each { |a, *b| puts "#{a} #{b}" } 
```
```ruby
puts Hash[4, 8]  #=> {4 => 8}
puts Hash[ [[4, 8], [15, 16]] ] #{4 => 8, 15 => 16}
```

### Array

http://rubymonk.com/learning/books/4-ruby-primer-ascent/chapters/33-advanced-arrays/lessons/87-using-the-api#solution4078
```ruby
def zen(array)
	# write your method here
  index = array.flatten.compact.index(42) 
  index == 5 ? index + 1 : nil
end
```

zip

```ruby
p [4, 8, 15, 16, 23, 42].zip([42, 23, 16, 15, 8]) # => [[4, 42], [8, 23], [15, 16], [16, 15], [23, 8], [42, nil]]
```
slice
```ruby
p [4, 8, 15, 16, 23, 42].slice(2)   #=>15
p [4, 8, 15, 16, 23, 42].slice(2..5) #=>[15, 16, 23, 42]
```

### Stack

```ruby
class Stack
  def initialize(size)
    @stack = Array.new
    @size = size
  end
  
  def pop
    @stack.pop
  end
  
  def push(element)
    return if full? or element.nil?
    @stack.push(element)
    self
  end
  
  def size
    @size
  end
  
  def look
    @stack.last
  end
  
  private
  
  def full?
    @stack.size >= @size
  end
  
  def empty?
    @stack.empty?
  end
end
```

```ruby
class Queue
  def initialize(size)
    @queue = Array.new
    @size = size
  end
  
  def dequeue
    @queue.pop
  end
  
  def enqueue(element)
    return if full? or element.nil?
    @queue.unshift(element)
    self
  end
  
  def size
    @size
  end
  
  private
  
  def full?
    @queue.size >= size
  end
  
  def empty?
    @queue.empty?
  end
end
```
Below is same as above

```ruby
class Queue
  attr_accessor :body, :max_size
  def initialize(size)
    self.body = Array.new
    self.max_size = size
  end
  
  def dequeue
    body.pop
  end
  
  def enqueue(element)
    return if full? or element.nil?
    body.unshift(element)
    self
  end
  
  def size
    self.max_size
  end
  
  private
  
  def full?
    body.size >= size
  end
  
  def empty?
    body.empty?
  end
end
```

### Disjoin Array

```ruby
class WaiterRobot

  def initialize(chef, tables)
    @chef = chef
    @tables = tables
    @name = "Tyler Durden"
  end
  
  def name
    @name
  end
  
  def place_order(table_number, sandwich, drink)
    # tell the chef with Chef#new_order(waiter_robot, order_hash)
    @chef.new_order(self, {table: table_number, sandwich: sandwich, drink: drink})
  end
  
  def serve(order)
    # digest the chef's sloppy order instructions:
    # 1) find the table number you need to serve
    # 2) call Table#serve_sandwich and Table#serve_drink
    puts "Test ++++++++++++++++++"
    p order
    p table
    table = @tables[order[1]]
    table.serve_sandwich(order[3])
    table.serve_drink(order[5])
  end
  
end
```
Official Anwser
```ruby
class WaiterRobot

  def initialize(chef, tables)
    @chef = chef
    @tables = tables
    @name = "Tyler Durden"
  end
  
  def name
    @name
  end
  
  def place_order(table_number, sandwich, drink)
    order = {:table => table_number, :sandwich => sandwich, :drink => drink}
    @chef.new_order(self, order)
  end
  
  def serve(order)
    # digest the chef's sloppy order instructions:
    # 1) find the table number you need to serve
    o = Hash[*order]
    table_number = o[:table]
    table = @tables[table_number]
    
    # 2) call Table#serve_sandwich and Table#serve_drink
    table.serve_sandwich(o[:sandwich])
    table.serve_drink(o[:drink])
  end
end
```  
### Fake Matrix

```ruby
CHARACTERS = ["Joey Jeremiah", "Snake Simpson", "Wheels", "Spike Nelson", "Arthur Kobalewscuy", "Caitlin Ryan", "Shane McKay", "Rick Munro", "Stephanie Kaye"]

def degrassi_couples
  # match 'em up!
  CHARACTERS.product(CHARACTERS).delete_if{|x| x[0] == x[1]}
end
```

### Column Base Matrix trans to Row Base Matrix

```ruby
class Announcements
  def initialize(printer)
    @printer = printer
  end
  
  def notify_user(column_table)
    row_table = column_table.transpose# batter up!
    @printer.print_with_ink(row_table)
  end
end
```

### include and extend

```ruby
module Foo

  def self.included(base)
    base.extend ClassMethods
  end

  def say
    "hello world"
  end
  
  module ClassMethods
    def guitar
      "gently weeps"
    end
  end
end

class Bar
  include Foo #only call instance method
  extend Foo #call class method
end

puts Bar.say
puts Bar.guitar
```
### Rescue

```ruby
EXAMPLE_SECRETS = ["het", "keca", "si", nil, "iel"]

def decode(jumble)
  secret = jumble.split("").rotate(3).join("")
  announce(secret)
  secret
end

#method raise a error
def decode_all(secrets)
  secrets.map do |secret|
    decode(secret)
  end
rescue Exception => e
  puts "String can't be decoded, #{e.inspect}"
end
```
ensure -- do something whether it failed or not

```ruby
class UserDataAccess
  attr_accessor :db
  
  def initialize
    @db = Database.new
  end

  def find_user(name)
    @db.find("SELECT * FROM USERS WHERE NAME = '%'", name)
  rescue Exception => e
    puts "A database error occurred."
  ensure
    @db.close  
  end
end
```

rescue in one in without exception
```ruby
EXAMPLE_SECRETS = ["het", "keca", "si", nil, "iel"]

def decode(jumble)
  secret = jumble.split("").rotate(3).join("")
  announce(secret)
  secret
end

def decode_all(secrets)
  secrets.map{ |secret| decode(secret)} rescue "it's okay, little buddy."
end
```

Write a string_slice method that accepts 5 string parameters and raises ArgumentError if more than 5 are passed in. string_slice returns a sequential array of these strings sliced up until the third character; it also raises IndexError if the string is less than 3 characters long.

```ruby
def string_slice(*strings)
  raise ArgumentError, "Argument Error" if strings.size > 5
  strings.map {|x| raise IndexError, "Index error" if x.length < 3; x.slice(0..2)}
end
```

Raise a custom exception handler KasayaError in the robe method if the argument type is not a String "Kasaya". It should return "Dharmaguptaka's Kasaya Robe" otherwise
```ruby
def robe(type)
  raise KasayaError if type.downcase != "kasaya"
  "Dharmaguptaka's Kasaya Robe"
end
class KasayaError < StandardError
end
```

### 5.2 Throw and Catch

```ruby
floor = [["blank", "blank", "blank"],
         ["gummy", "blank", "blank"],
         ["blank", "blank", "blank"]]

attempts = 0
candy = catch(:found) do
	floor.each do |row|
  	row.each do |tile|
      attempts += 1
    	throw(:found, tile) if tile == "jawbreaker" || tile == "gummy"
  	end
	end
end
puts candy
puts attempts
```

Use return instead of catch and throw pair

```ruby
def search(floor)
  floor.each do |row|
  	row.each do |tile|
      return tile if tile == "jawbreaker" || tile == "gummy"
  	end
  end
end
```
### 6.1 Literals

```ruby
def quoted_string(to_be_quoted)
  # quotes in quotes.
  "Suuuure. You were just \"making sure the cake was comfortable\"."
end
```

```ruby
def multi_line_string(*lines)
  # newline, carriage-return, whatever-you-call it.
  "Here are your lines!\n\n#{lines.join("\n")}"
end
puts multi_line_string(["abc", "def"])
```

```ruby
def big_q_string(numerator, denominator)
	%Q[This %Q syntax is the ugliest one.
#{numerator} out of #{denominator} "dentists" agree.]
end
puts big_q_string(4, 5) #=>This %Q syntax is the ugliest one. 
                        # 4 out of 5 "dentists" agree.
```
Generate a-z charactor 
```ruby
def range_of_characters
  # an easy one!
  ('a'..'z')
end
```

### Ruby Monk 6.2 Variables

$ => Prefix of Global Variable

$* (the command-line arguments used to execute this Ruby program), 
$@ (the location of the last error), 
$~ (the last regular expression match), 
$0 (the name of the current ruby script)

### 6.3 Constant

another way to define a class 
```ruby
def awkward_sheep
  sheep = Class.new do
    def speak
      "Bah."
    end
  end
  # create a class here with a method 'speak'
end
```

```ruby
module Fence
  Sheep = Class.new do
    def speak
      "Bah."
    end
  end
end

def call_sheep
  Fence::Sheep.new.speak
end
```

### 7.0 Enumerators and Enumerables

Try and implement a simplemap_with_index on the Array class through which you can call a block with two arguments: the element and its index. It should return an Enumerator object if no block is given, an Array otherwise.

My Answer
```ruby
class Array
def map_with_index(&block)
  block_given? ? each_with_index.map(&block) : each_with_index
end
end
```

Official 
```ruby
class Array
  def map_with_index(&block)
    self.each_with_index.map(&block)
  end
end
```

### 7,1

```ruby
def occurrences(str)
  str.downcase.scan(/\w+/).inject(Hash.new(0)){|hash, char| hash.update(char => hash[char] + 1)}
 # str.downcase.scan(/\w+/).inject(Hash.new(0)){|hash, char| puts hash[char]} wrong method
end
```

```ruby
[4, 8, 15, 16, 23, "42"].any? { |e| e.class == String }

{:locke => 4, :hugo => 8}.any? { |candidate| candidate[1] > 4 } 

{:locke => 4, :hugo => 8}.any? { |candidate, number| number < 4 } 
```

```ruby
class Island
  def initialize(candidates)
    @candidates = candidates
    puts @candidates
  end
  
  def survive?
    @candidates.none?{|c| c == 'Esau'}
  end
  
  def safe?
    @candidates.all?{|c| c == 'Jack'}
  end
end
```

```ruby
union_example = ["a", "b", "a"] | ["c", "c"] #=>["a", "b", "c"]

array_difference = [1,2,3, 1,2,3] - [1] #=> [2, 3, 2, 3]
```

```ruby
class Order
  GIFT_ITEMS = [Item.new(:big_white_tshirt), Item.new(:awesome_stickers)]
  OUT_OF_STOCK_ITEMS = [Item.new(:ssd_harddisk)]

  def initialize(order)
    @order = order || []  
    puts @order
  end
  
  def final_order
    # fix this method to get the tests to pass.
    @order = @order - OUT_OF_STOCK_ITEMS + GIFT_ITEMS
  end
end

customer_order = Order.new([Item.new(:fancy_bag),Item.new(:ssd_harddisk)])

p customer_order.final_order
```
7.2

```ruby
class FibonacciNumbers
  NUMBERS = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
    
  def each
    for el in NUMBERS
      yield(el)
    end
  end
end

f=FibonacciNumbers.new
f.each do |fibonacci_number|
  puts "A Fibonacci number multiplied by 10: #{fibonacci_number*10}"
end
```

Enumerable
```ruby
class FibonacciNumbers
  NUMBERS = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
  #this is important!! include Enumerable
  include Enumerable
  # all your code goes here
  # once implement each method, all other enumerable methods depends on it
  def each
    for n in NUMBERS
      yield(n)
    end
  end
  
  #optional implenment-- do not need to implement inject and map methods 
  def inject(accumulator=0, &block)
    self.each do |item|
      accumulator = block.call(accumulator, item)
    end
    accumulator
  end
  
  def map(&block)
    return_value = []
    self.each do |item|
      return_value << block.call(item)
    end
    return_value
  end
end


f = FibonacciNumbers.new
puts f.inject(0){|sum, n| sum + n}

if f.respond_to?(:map)
  squares = f.map {|number| number * number }
	puts "The squares of the fibonacci numbers are #{squares}"
else
  puts "I'll reveal the squares to you once you pass the tests."
end
```

### 7.3

understanding of gsub

```ruby
a = "tom"
b = "jerry"
superheroes = [a,b]
puts superheroes #=>tom, jerry

# reassign a to a different superhero
a = "batman"
puts superheroes #=>tom jerry

# jerry is in fact superman. who knew!
b.gsub!("jerry", "superman")
puts superheroes #=> tom, superman
```

### The Debugging Primaries

Use debug technic to solve problem

Old one
```ruby
class VisualAcuity
  def initialize(subject, normal)
    @subject = subject
    @normal = normal    
  end
  def can_drive?
    (@subject / @normal) >= 0.5
  end  
end

class DrivingLicenseAuthority
  def initialize(name, age, visual_acuity)
    @name = name
    @visual_acuity = visual_acuity
  end
  
  def valid_for_license?
		@age >= 18
  end
  
  def verdict
    if valid_for_license?
	    "#{@name} can be granted driving license"
    else
      "#{@name} cannot be granted driving license"
    end
  end
end
```

Fixed one
```ruby
class VisualAcuity
  def initialize(subject, normal)
    @subject = subject
    @normal = normal    
  end
  def can_drive?
    (@subject.to_f / @normal.to_f) >= 0.5
  end  
end

class DrivingLicenseAuthority
  def initialize(name, age, visual_acuity)
    @age = age
    @name = name
    @visual_acuity = visual_acuity
  end
  
  def valid_for_license?
    @age >= 18 and @visual_acuity.can_drive?
  end
  
  def verdict
    if valid_for_license?
	    "#{@name} can be granted driving license"
    else
      "#{@name} cannot be granted driving license"
    end
  end
end
```

Benchmark
```ruby
require 'benchmark'

n=4000
Benchmark.bm do |benchmark|
  benchmark.report do
    a=[]; n.times { a = a + [n] }
  end
  benchmark.report do
    a=[]; n.times { a << n }
  end
  benchmark.report do
    a=[1..n].map {|number| number}
  end
end
```

9.2 What is an object?

```ruby
class Dish
end

class Soup < Dish
end
class IceCream < Dish
end
class ChineseGreenBeans < Dish
end

class DeliveryTray
  DISH_BOWL_MAPPING = { 
    Soup => "soup bowl",
    IceCream => "ice cream bowl",
    ChineseGreenBeans => "serving plate"
  }
    
  def initialize
    @delivery_tray = {Soup => 0,
      IceCream => 0,
      ChineseGreenBeans => 0}
  end
  
  def add(dish)
    @delivery_tray[dish.class] = @delivery_tray[dish.class] + 1
  end
  
  def dishes_needed
    text = @delivery_tray.map do |key, value|
      next if value == 0
      value.to_s + " " + DISH_BOWL_MAPPING[key]
		#"None."
    end
    text.compact.join(", ")
  end
end  

d = DeliveryTray.new
d.add Soup.new; d.add Soup.new
d.add IceCream.new

puts d.dishes_needed # should be "2 soup bowl, 1 ice cream bowl"
```

### Singleton Methods

```ruby
class Object  
  def singleton_method?(method)
    singleton_methods = 
      self.singleton_class.instance_methods - self.class.instance_methods
        
    singleton_methods.include? method
  end
end


foo = "A string"
def foo.shout
  puts foo.upcase
end

# shout is a singleton method.
p foo.singleton_method?(:shout)
```

### Send

```ruby
def relay(array, data_type)
  # Write your code here
  array.map{|x| x.send("to_#{data_type}")}
end
```

### Missing Method

method_missing method won't return any response even if call a undefined method
```ruby
class Spy
  # Write your code here
  def method_missing(sym, *args, &block)
  end
end

Spy.new.hello #=> nothing
```
record the methods were called before

```ruby
class MethodCall
  def initialize(sym, args)
    @sym = sym
    @args = args
  end
  
  def sym
    @sym
  end
  
  def args
    @args
  end
  
  def ==(other_call)
    @sym == other_call.sym && @args == other_call.args
  end
end

class Spy
  def initialize
    @method_calls = []
  end
  
  def method_missing(sym, *args, &block)
    @method_calls << MethodCall.new(sym, args)
  end

  def method_called?(sym, *args)
    @method_calls.include?(MethodCall.new(sym, args))
  end
end
```

```ruby
class Spy
  def initialize(enemy_agent)
    @enemy_agent = enemy_agent
  end

  # Write your method_missing here
  def method_missing(sym, *args)
    @enemy_agent.send(sym, *args)
  end
end
```

### 1.2 Define Method

```ruby
class Monk
  # put your code here
  %w(life the_universe everything).each do |s|
    define_method("meditate_on_#{s}") do
      "I know the meaning of #{s.split("_").join(" ")}"
    end
  end
end
```
### 2.1 Inspector Gadget

```ruby
def monk(arg1, *args2)
  "Monks" + arg1 + args2.first
end

mo = self.method(:monk)

puts "Arity"
p mo.arity

puts "Parameters"
p mo.parameters
# => Arity
#-2
#Parameters
#[[:req, :arg1], [:rest, :args2]]
```

```ruby
class Monastery
	def monks(arg1, arg2)
  	"Monks" + arg1 + arg2
	end
end

mo = Monastery.new.method(:monks)

puts "Receiver --"
p mo.receiver

puts

puts "Owner --"
p mo.owner

# =>
#Receiver --
#<Monastery:0x000000030d3308>

#Owner --
#Monastery
```

2.2 Tap in Deeper

```ruby
def inspect_instance_variable(class_name, variable)
  klass = Module.const_get(class_name).new #get class name constant and then generate an object of that class
  klass.instance_variable_get('@' + variable)# get instance of that class
end
```
### Tech Talk

https://gist.github.com/shellyser/082dec009bbfe256406d#file-DSL-rb

https://github.com/superbay/knowledge/blob/master/tech_talk/concern.markdown

http://stackoverflow.com/questions/19098663/auto-loading-lib-files-in-rails-4

### Tech Talk

https://github.com/ChristinaLeuci/Ruby

https://github.com/superbay/knowledge/blob/master/rails/rails4way/chapter15.markdown

http://victorarias.com.br/2013/08/13/leaky-ruby.html





### Interview Tests
######Test 1

>**Your task is to**
write a function that determines for each pair if it’s an anagram or not
for each pair of words your function will print to standard output (stdout) the value 1 if the pair is an anagram or 0 otherwise (one result per line)

>**Note that your function will receive the following arguments:**
>firstWords
which is an array of strings giving the first word for each of the pairs
secondWords
which is an array of strings giving the corresponding second word

>**Data constraints**
>the number of word pairs will not exceed 100
the maximum length of any word in the pairs will not exceed 100 characters
all words will contain only lowercase English letters (a-z)

>**Efficiency constraints**
>your function is expected to print the result in less than 2 seconds

>**Example**
>Input	Output
firstWords: “cinema”, “host”, “aba”, “train”
secondWords: “iceman”, “shot”, “bab”, “rain”
1
1
0
0

>**Explanation**
>for the given arguments above we have the following pairs:
(cinema, iceman) (host, shot) (aba, bab) (train, rain)
only the first two pairs are anagrams.

```ruby
def check_anagrams(first_words, second_words)
    # Write your code here
    # To print results to the standard output you can use puts
    # Example puts "Hello world!
    return if first_words.size > 100 or second_words.size > 100
    first_words.each_with_index do |first_word, index|
	if second_words[index]
	  continue if first_word.length > 100 or second_words[index].length > 100
	  continue if first_word.downcase != first_word or second_words[index].downcase != second_words[index]
	  if first_word.split('').sort.join == second_words[index].split('').sort.join
	      puts 1
	  else
	      puts 0
	  end
	end
    end
end
```

Challenge 2: Braces
Given an array of strings containing three types of braces: round (), square [] and curly {}
Your task is to
write a function that checks whether the braces in each string are correctly matched
prints 1 to standard output (stdout) if the braces in each string are matched and 0 if they're not (one result per line)
Note that your function will receive the following arguments:
expressions
which is an array of strings containing braces
Data constraints
the length of the array will not exceed 100
the length of any string will not exceed 5000
Efficiency constraints
your function is expected to print the result in less than 2 seconds
Example
Input	Output
expressions: [ ")(){}", "[]({})", "([])", "{()[]}", "([)]" ]
0
1
1
1
0

```ruby
def check_braces(expressions)
    # Write your code here
    # To print results to the standard output you can use puts
    # Example puts "Hello world!"
    return if expressions.size > 100
    pairs = {')' => '(', ']' => '[', '}' => '{'}
    
    expressions.each do |expression|
        continue if expression.length > 5000
        brackets = []

        expression.split('').each do |char|
          if pairs.values.include?(char)
              brackets << char
          elsif pairs.keys.include?(char)
              if pairs[char] == brackets.last
                  brackets.pop
              else
                  brackets << char
                  break
              end
          end
        end
        
        if brackets.empty?
            puts 1
        else
            puts 0
        end
    end
end
```

Challenge 3

Your task is to
write a function that finds the minimum value X that makes possible the following: generate a new array that is sorted in strictly ascending order by increasing or decreasing each of the elements of the initial array with integer values in the [0, X] range.
Example: Having the initial array [5, 4, 3, 2, 8] the minimum value for X is 3. Decrease the first element (5) by 3, decrease the second one (4) by 1, increase the third one (3) by 1, increase the forth one (2) by 3 and do nothing to the last one (8). In the end we obtain the array [2, 3, 4, 5, 8] which is sorted in strictly ascending order.
print the result X to the standard output (stdout)
Note that your function will receive the following arguments:
v
which is the array of integers
Data constraints
numbers are in ascending order when arranged from the smallest to the largest number
strictly ascending order means that each element is greater than the preceding one (e.g. [1, 2, 2, 3] is NOT strictly ascending order)
the length of the array will not exceed 5000
the elements of any of the arrays are integer numbers in the [1, 231 -1] range
Efficiency constraints
your function is expected to print the result in less than 2 seconds
Example
Input	Output
v: 5, 4, 3, 2, 8
3


Challenge 4: Deviation
Given an array of integer elements and an integer d please consider all the sequences of d consecutive elements in the array. For each sequence we compute the difference between the maximum and the minimum value of the elements in that sequence and name it the deviation.
Your task is to
write a function that computes the maximum value among the deviations of all the sequences considered above
print the value the standard output (stdout)
Note that your function will receive the following arguments:
v
which is the array of integers
d
which is an integer value giving the length of the sequences
Data constraints
the array will contain up to 100,000 elements
all the elements in the array are integer numbers in the following range: [1, 231 -1]
the value of d will not exceed the length of the given array
Efficiency constraints
your function is expected to print the result in less than 2 seconds
Example
Input	Output
v: 6, 9, 4, 7, 4, 1
d: 3
6
Explanation
The sequences of length 3 are:
6 9 4 having the median 5 (the minimum value in the sequence is 4 and the maximum is 9)
9 4 7 having the median 5 (the minimum value in the sequence is 4 and the maximum is 9)
7 4 1 having the median 6 (the minimum value in the sequence is 1 and the maximum is 7)
The maximum value among all medians is 6



Challenge 5: Maximum Difference
Given an array of integer elements, a subsequence of this array is a set of consecutive elements from the array (i.e: given the array v: [7, 8, -3, 5, -1], a subsequence of v is 8, -3, 5)
Your task is to
write a function that finds a left and a right subsequence of the array that satisfy the following conditions
the two subsequences are unique (they don't have shared elements)
the difference between the sum of the elements in the right subsequence and the sum of the elements in the left subsequence is maximum
print the difference to the standard output (stdout)
Note that your function will receive the following arguments:
v
which is the array of integers
Data constraints
the array has at least 2 and at most 1,000,000 numbers
all the elements in the array are integer numbers in the following range: [-1000, 1000]
Efficiency constraints
your function is expected to print the result in less than 2 seconds
Example
Input	Output
v: 3, -5, 1, -2, 8, -2, 3, -2, 1
15
Explanation
The left sequence is : -5, 1, -2 and the right sequence is: 8, -2, 3.
