**Rspec color and format**

```
rspec --color --format documentation spec/models/user_spec.rb 
```

```ruby
zombie = Zombie.new

### Next three lines equals to
zombie.iq.should == 0
zombie.eat_brains
zombie.iq.should == 3

#this one
expect{ zombie.eat_brains }.to change{ zombie.iq }.by(3)
```

```ruby
zombie = Zombie.new(name: 'Ash')
zombie.tweets.new(message: "Arrrgggggggghhhhh")
zombie.should have_at_least(1).tweets
```
