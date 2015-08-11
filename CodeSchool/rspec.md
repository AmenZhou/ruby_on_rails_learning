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

```ruby
  zombie = Zombie.new
#before
  begin
    zombie.make_decision!
  rescue Zombie::NotSmartEnoughError => e
    e.should be_an_instance_of(Zombie::NotSmartEnoughError)
  end
  
#after
  expect{ zombie.make_decision! }.to raise_error(
    Zombie::NotSmartEnoughError
  )
```

```ruby
# After refactor
  context "when zombie has high iq" do
    subject { Zombie.new(iq: 3) }
    
    it { should be_genius }
    its(:brains_eaten_count) { should == 1 }
  end
  
# Before
  it "should be_genius with high iq" do
    zombie = Zombie.new(iq: 3)
    zombie.should be_genius
  end

  it 'should have a brains_eaten_count of 1 with high iq' do
    zombie = Zombie.new(iq: 3)
    zombie.brains_eaten_count.should == 1
  end
```

```ruby
describe Tweet do
  context 'after create' do
    let(:zombie) { Zombie.create(email: 'anything@example.org') }
    let(:tweet) { zombie.tweets.new(message: 'Arrrrgggghhhh') }
    let(:mail) { stub(deliver: true) }

    it 'calls "tweet" on the ZombieMailer' do
      ZombieMailer.should_receive(:tweet).and_return(mail)
      tweet.save
    end
  end
end
```

```ruby
describe Tweet do
  context 'after create' do
    let(:zombie) { Zombie.create(email: 'anything@example.org') }
    let(:tweet) { zombie.tweets.new(message: 'Arrrrgggghhhh') }
    let(:mail) { stub(:mail, deliver: true) }

    it 'calls "tweet" on the ZombieMailer as many times as there are zombies' do
      Zombie.stub(all: [stub, stub, stub])
      ZombieMailer.stub(tweet: mail)
      ZombieMailer.should_receive(:tweet).exactly(3).times
      tweet.save
    end
  end
end
```

**Matcher**

```ruby
module ValidateNumericalityOf
  class Matcher
    def initialize(attribute)
      @attribute = attribute
      @options = {}
      @errors = []
    end

    def matches?(model)
      @model = model
      @model[@attribute] = "not a number"
      @model.valid?
      
      if !@model.errors[@attribute].include?("is not a number")
        @errors << "numericality" 
      end

      if @options[:only_integers]
        @model[@attribute] = 1.5
        @model.valid?
        if !@model.errors[@attribute].include?("must be an integer")
          @errors << "as an integer"
        end
      end

      if @errors.empty?
        true
      else
        false
      end
    end

    def failure_message
      "#{@model.class} failed to validate: #{@attribute} #{@errors.join(', ')}"
    end

    def negative_failure_message
      "#{@model.class} unexpected validation: #{@attribute} #{@errors.join(', ')}"
    end

    def description
      "validate numericality of #{@attribute}"
    end
    
    def only_integers
      @options[:only_integers] = true
      self
    end
  end

  def validate_numericality_of(attribute)
    Matcher.new(attribute)
  end
end

RSpec.configure do |config|
  config.include ValidateNumericalityOf, type: :model
end
```

```ruby
class Zombie < ActiveRecord::Base
  attr_accessible :iq
  validates :iq, presence: true,
  numericality: {
  only_integers: true
  }
end
```
