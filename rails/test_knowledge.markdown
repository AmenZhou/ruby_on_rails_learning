### intellgence rspec test
```
rails g integration_test named --integration-tool=rspec
```
### set default rspec engine
```ruby
#application.rb
config.generators do |g|
  g.test_framework :rspec
end
```
