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