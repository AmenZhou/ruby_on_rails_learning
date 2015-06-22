##### Class Macros

```ruby
def add_checked_attribute(klass, attribute, &validation)
  klass.class_eval do
    define_method "#{attribute}=" do |value|
      raise "Invalid Attribute" unless validation.call(attributes)
      instance_variable_set("@#{attribute}", value)
    end
    
    define_method attribute do
      instance_variable_get("@#{attribute}")
    end
  end
end
```

PUT IT INTO A MODULE
```ruby
module CheckAttributes
  # add a hook on module include
  def self.included(base)
    base.extend ClassMethod
  end
  
  module ClassMethod
    def attr_checked(attribute, &validation)
      define_method "#{attribute}=" do |value|
        raise "Invalid Attribute" unless validation.call(attributes)
        instance_variable_set("@#{attribute}", value)
      end
      
      define_method attribute
        instance_variable_get("@#{attribute}")
      end
    end
  end
end
```

INCLUDE THE CHECKATTRIBUTES MODULE AND CALL ATTR_CHECKED
```ruby
class Person
  attr_checked :age do |v|
    v >= 18
  end
end
```
