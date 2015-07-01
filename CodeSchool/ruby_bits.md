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

```ruby
class Library
  SYSTEMS = ['arcade', 'atari', 'pc']

  attr_accessor :games

  def method_missing(name, *args)
    system = name.to_s

    if SYSTEMS.include?(system)
      self.class.class_eval do
        define_method system do
          find_by_system(system)
        end
      end
    else
      super
    end
  end

  private

  def find_by_system(system)
    games.select { |game| game.system == system }
  end
end
```

Add respond_to

```ruby
class Library
  SYSTEMS = ['arcade', 'atari', 'pc']

  attr_accessor :games
  
  def respond_to?(name)
    system = name.to_s
    SYSTEMS.include?(system)
  end

  def method_missing(name, *args)
    system = name.to_s
    if SYSTEMS.include?(system)
      self.class.class_eval do
        define_method(system) do
          find_by_system(system)
        end
      end
      send(system)
    else
      super
    end
  end

  private

  def find_by_system(system)
    games.select { |game| game.system == system }
  end
end
```

### DSL

Example
```ruby
add_game "Civilization" do
  system "PC"
  year 1991
end

add_game "Contra" do
  system "NES"
  year 1987
end

with_game "Contra" do
  print_details
  play
  capture_screenshot
end
```

GameDSL.rb
```ruby
LIBRARY = Library.new

def add_game(name, &block)
  game = Game.new(name)
  # Capture the block and call it here
  game.instance_eval(&block)
  LIBRARY.add_game(game)
end

def with_game(name, &block)
  game = LIBRARY.find_by_name(name)
  game.instance_eval(&block)
end
```

Library.rb
```ruby
class Library
  def initialize
    @games = []
  end
 
  def add_game(game)
    @games << game
  end
end
```

Game.rb
```ruby
class Game
  attr_reader :name

  def initialize(name)
    @name = name
    @year = nil
    @system = nil
  end

  # Add methods to store year and system
  def year(year)
    self.year = year
  end
  
  def system(system)
    self.system = system
  end
  
  def print_details
    puts "#{@name} - #{@year} (#{@system})"
  end
 
  def play
  end
 
  def capture_screenshot
  end
end
```
