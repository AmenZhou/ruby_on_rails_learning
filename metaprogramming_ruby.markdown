##### Class Macros

```ruby
def add_checked_attribute(klass, attribute, &validation)
  klass.class_eval do
    defined_method "#{attribute}=" do |value|
      raise "Invalid Attribute" unless validation.call(attributes)
      instance_variable_set("@#{attribute}", value)
    end
    
    defined_method attribute do
      instance_variable_get("@#{attribute}")
    end
  end
end
```
