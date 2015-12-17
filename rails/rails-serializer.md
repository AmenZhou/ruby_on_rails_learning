**Scope**

controller

```ruby
serialization_scope :view_context

def current_user
end
```

serializer

```ruby
delegate :current_user, to: :scope
```
