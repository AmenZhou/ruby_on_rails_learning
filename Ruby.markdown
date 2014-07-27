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
