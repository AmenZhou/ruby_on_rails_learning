### Database Busy

http://stackoverflow.com/questions/7154664/ruby-sqlite3busyexception-database-is-locked

### Stub an attributes of a instance

```ruby
  class User
    def initialize user_name
      @user_name = user_name
    end
  end
```

`User.instance_variable_set(:@user_name, "Tom Adison")`
