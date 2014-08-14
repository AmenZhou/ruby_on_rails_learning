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
