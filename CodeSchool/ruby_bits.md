### Struct

1. Struct is an easy way to generate a class

  ```ruby
  class Game
    attr_accessor :name, :year, :system
  
    def initialize(name, year, system)
      self.name = name
      self.year = year
      self.system = system
    end
  end
  
  Game = Struct.new(:name, :year, :system)
  ```

### define_method

Old

```ruby
class Game
  SYSTEMS = ['SNES', 'PS1', 'Genesis']

  attr_accessor :name, :year, :system

  def runs_on_snes?
    self.system == 'SNES'
  end

  def runs_on_ps1?
    self.system == 'PS1'
  end

  def runs_on_genesis?
    self.system == 'Genesis'
  end
end
```

New

```ruby
class Game
  ['SNES', 'PS1', 'Genesis'].each do |_system|
    def "runs_on_#{_system.downcase}?" do
      self.system = _system
    end
  end
  attr_accessor :name, :year, :system
end
```
========================================

```ruby
class Library
  attr_accessor :games

  [:each, :map, :select].each do |name|
    define_method name do |&block|
      games.send(name, &block)
    end
  end
end
```

### method method

```ruby
library.emulate("Contra") #=>

my_method = library.method :emulate
my_method.call("Contra")
```

### class_eval

```ruby
Game.class_eval do
  def self.find_by_owner(name)
  end
end
```

```ruby
class LibraryManager
  def self.make_available(klass, user)
    klass.class_eval do
      define_method "lend_to_#{user}" do
        #do some thing inside the method
      end
    end
  end
end
```

### instance_eval

```ruby
contra_game = Game.new('Contra')
contra_game.instance_eval do
  self.owner = "Alice"
end
```

```ruby
class Game
  def initialize &block
  #pass the block to instance_eval and the context inside is an instance of Game 
    instance_eval(&block) if block_given?
  end

  def owner(name=nil)
    if name
      @owner = name
    else
      @owner
    end
  end
end
```

### method_missing

```ruby
class Library
  def method_missing(method_name, *args)
    puts method_name
  end
end
```

Pass all the args to @manager

```ruby
class Library
  def initialize(console)
    @manager = console
  end

  def method_missing(name, *args)
    @manager.send(name, *args)
  end
end
```

Simple Delegate

```ruby
require 'delegate'

class Library < SimpleDelegator
  def initialize(console)
    super console
  end
end
```
