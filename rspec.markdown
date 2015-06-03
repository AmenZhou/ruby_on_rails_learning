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

=====================================

### render_views

it renders the view's in the controller spec. If you don't put render_views, the views won't render, that means the controller is called but after it returns the views are not rendered. Controller tests will run faster, as they won't have to render the view, but you might miss bugs in the view.

=======================================

### expects

```ruby
controller.expects(:record_registration_attempt).with(params[:registration], 'completed')
```

========================================

### fast test

`rspec spec/ --fail-fast`
