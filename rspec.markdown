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

### Share Behaves

```ruby
shared_examples "a shared example" do
  it "xxx" do
  end
end

describe "xxx" do
  it_behaves_like "a shared example"
end
```

=================================

### Nicer Rspec Running Output

```
rspec -fd spec/test_rspec.rb
```
