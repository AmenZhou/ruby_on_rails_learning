Zombie Rails 2

Level 1

Database variable types in rails
string
text
integer
boolean
decimal
float
binary
date
time
datetime


Migration option 
default: value
limit: 30
null: false
first: true
after: :email
unique: true


Add or remove columns to tables
```
rails g migration add<columns>to<table> name:value
rails g migration Remove<Anything>From<Table name> name:value

Migration commands
rename_column :table, :old_column, :new_column
rename_table  :old_table, :new_table
drop_table	:table
change_column :table, :column, :type, :option
change_column_default :table, :column, default: true
remove_column :table, :column
add_column :table, :column, :type, :option
```
rake 
rake db:setup -- create db, load schema, run seed
========================================================

Level 2

1  Write a scope on the Tweet model called recent which returns the 4 most recent tweets. Hint: You'll need an order AND a limit scope.
```ruby
class Tweet < ActiveRecord::Base
  scope :recent, order("created_at desc").limit(4)
end
```

2  Write another scope called graveyard which only shows tweets where the show_location column is true and the location is "graveyard"

```ruby
class Tweet < ActiveRecord::Base
  scope :recent, order('created_at desc').limit(4) 
  scope :graveyard, where(show_location: true, location: 'graveyard')
end
```

3  In this controller action create an instance variable called @graveyard_tweets which uses both of the two scopes recent and graveyard together.

```ruby
class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
    @graveyard_tweets = Tweet.recent.graveyard
  end
end
```

4  Create a before_save callback that checks to see if a tweet has a location, if it does have a location then set show_location to true.
Tip: You can check to see if location exists with if self.location?

```ruby
class Tweet < ActiveRecord::Base
  before_save :set_show_location
  
  def set_show_location
    self.show_location = true if self.location? #self.location this self is optional
  end
end
```


5  Add callbacks so the appropriate log function is called after an update and destroy.

```ruby
class Tweet < ActiveRecord::Base
  after_update :log_update
  after_destroy :log_destroy

  def log_update
    logger.info "Tweet #{id} updated"
  end

  def log_destroy
    logger.info "Tweet #{id} deleted"
  end
end
```

6 Instead of storing location inside the Tweet model, let's instead break it out into a separate table (as you see below). In this case we want to define that a Tweet can have one Location, and a Location belongs to a Tweet. Fill out the models below accordingly.

```ruby
class Tweet < ActiveRecord::Base
  has_one :location
end

class Location < ActiveRecord::Base
  belongs_to :tweet
end
```

****************Pay attendtion of foreign_key*************
7 OH NO! Our Database Admin turned into a Zombie and decided to rename the belongs_to field in our locations table tweeter_id instead of the intelligent default tweet_id. We're going to slay him and correct this, but in the meantime set the foreign_key on both relationships to tweeter_id. Also set the dependency so when a tweet is destroyed, the location is destroyed as well.

```ruby
class Tweet < ActiveRecord::Base
  has_one :location, dependent: :destroy, foreign_key: :tweeter_id
end

class Location < ActiveRecord::Base
  belongs_to :tweet, foreign_key: :tweeter_id
end
```


8  We're going to be iterating through many tweets and printing out their location. Refactor the controller code below to use the includes method.

```ruby
class TweetsController < ApplicationController 
  def index
    @tweets = Tweet.recent.includes(:location).all
  end
end
```

9  A Tweet can belong to one or more Categories (e.g. eating flesh, walking dead, searching for brains). Write a migration that creates two tables, categories, and categorizations. Give categories one column named name of type string; and give categorizations two integer columns: tweet_id and category_id.

```ruby
class AddTweetCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
    end
    
    create_table :categorizations do |t|
      t.integer :tweet_id
      t.integer :category_id
    end
  end 
end
```

10 Now that we have our new tables, it's time to define the relationships between each of the models. Define the has_many through relationships in the Tweet & Category model and the belongs_to relationships in the Categorization model.

```ruby
class Tweet < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, through: :categorizations
end

class Categorization < ActiveRecord::Base
  belongs_to :tweet
  belongs_to :category
end

class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :tweets, through: :categorizations
end
```
=====================================================

Level 3

radio button

```ruby
<%= f.radio_button :decomp, 'fresh', checked: true %>
```

select

```ruby
<%= f.select :decomp, [['fresh', 1], ['rotting', 2], ['stale', 3]]%>
```


test input helper

```ruby
<%= f.password_field :password %>

<%= f.number_field :price %>

<%= f.range_field :quantity %>
```

Nested routes
pic-- Code School - Rails for Zombies Two-nested routes


Challenges

2 Create the form for entering tweet status (text_area) and location (text_field) using the appropriate Rails view helpers. All you need is a form_for block, the input helpers, and a submit button.

```ruby
<h1>New tweet</h1>

<%= form_for(@tweet) do |f| %>
  <%= f.text_area :status %>
  <%= f.text_field :location %>
  <%= f.submit value='Submit' %>
<% end %>
```

3 Look at the following database table and create the proper input fields for the columns listed here.

```ruby
<%= form_for(@weapon) do |f| %>
  <%= f.text_field :name %>
  <%= f.number_field :ammo %>
  <%= f.check_box :is_broken %>
<% end %>
```


4 Rather than having a weapon that is broken or not, lets instead have a condition field which is either "New", "Rusty", or "Broken". Add a set of radio buttons where the user can select one of these states. Make "New" be checked by default.

```ruby
<%= form_for(@weapon) do |f| %>
  <%= f.text_field :name %>
  <%= f.number_field :ammo %>
  <%= f.radio_button :condition, 'New', checked: true %>
  <%= f.radio_button :condition, 'Rusty' %>
  <%= f.radio_button :condition, 'Broken' %>
<% end %>
```

5  Instead of using radio buttons, use a select box for the condition. Refactor the code below:

```ruby
<%= form_for(@weapon) do |f| %>
  <%= f.select :condition, ['New', 'Rusty', 'Broken'] %>
<% end %>
```

6 Write the nested route that will allow us to nest tweets and weapons under the zombie resource. The idea here is that a zombie has many tweets and zombie has many weapons.

```ruby
RailsForZombies::Application.routes.draw do
  resources :zombies do
    resources :tweets
    resources :weapons
  end
end
```


7  Now that we have the proper route, we need to make sure the weapons controller properly looks up both the zombie and the weapon when we request /zombies/2/weapons/1. Finish this controller:

```ruby
class WeaponsController < ApplicationController
  def show 
    @zombie = Zombie.find(2)
    @weapon = @zombie.weapons.find(1)
  end
end
```

8  Now create the proper link_to for when we view a zombie and want to show each of its weapons, and when we want to create a new weapon for this zombie.

```ruby
<h2><%= @zombie.name %>'s weapons</h2>
<ul>
  <% @weapons.each do |w| %>
    <li><%= link_to w.name, [@zombie, w] %></li>
  <% end %>
</ul>

<%= link_to "New Weapon", new_zombie_weapon_path(@zombie) %>
```

9 Change the form_for below to use the proper nesting for creating a new weapon for a Zombie.

```ruby
<%= form_for([@zombie, @weapon]) do |f| %>
  <%= f.text_field :name %>
    
  <%= f.submit %>
<% end %>
```

10 Modify the following code to make it more pretty, using titleize, to_sentence, pluralize, and number_to_currency (in just that order)

```ruby
<h2><%= @zombie.name.titleize %></h2>
<p>Weapons: <%= @zombie.weapon_list.to_sentence %></p>
<p><%= pluralize(@zombie.tweets.size, 'Tweet') %></p>
<p>Money in Pocket <%= number_to_currency(@zombie.money) %></p>
```

11 Refactor the code below to move the form into the _form.html.erb partial.

```ruby
<h2>New Tweet</h2>

<%= render 'form' %>

<%= link_to 'back', tweets_path %>
```
=========================================================================

Level 5

1  Enter the command for generating a mailer called WeaponMailer which has the emails low_ammo and broken.

```
rails g mailer WeaponMailer low_ammo broken
```

2  Code up the low_ammo mailer with the subject of "#{weapon.name} has low ammo", the email should be sent to the zombie.email. Lastly, set the default from address for all emails in WeaponMailer to admin@rfz.com

```ruby
class WeaponMailer < ActionMailer::Base
  default from: "admin@rfz.com"
  def low_ammo(weapon, zombie) 
    mail to: zombie.email, subject: "#{weapon.name} has low ammo"
    
  end
end
```

3  Finish coding the check_ammo method on the Weapon model so when we have exactly three ammo left, it will send out the low_ammo mailer we just created.

```ruby
class Weapon < ActiveRecord::Base
  belongs_to :zombie 

  before_save :check_ammo

  def check_ammo
    if ammo == 3
      WeaponMailer.low_ammo(self, self.zombie).deliver
    end
  end
end
```


4 Change the low_ammo method to include a picture of the weapon that's low on ammo as an attachment. You can name the file weapon.jpg and load the file using weapon.picture_file.

```ruby
class WeaponMailer < ActionMailer::Base
  default from: "admin@rfz.com"

  def low_ammo(weapon, zombie)
    attachments['weapon.jpg'] = weapon.picture_file
    mail to: zombie.email, subject: "#{weapon.name} has low ammo"
  end 
end
```

5 Convert the following to their appropriate asset tags.

```ruby
<%= javascript_include_tag "weapon" %>
<%= image_tag "weapon.png" %>
<%= stylesheet_link_tag "weapon" %>
```

6 Convert the following scss.erb file to properly reference the asset_path for the image listed in it. Also, try refactoring the scss to use nesting.

```ruby
h2#newUser {
  text-indent: -9999px; 
  a {
      height: 64px;
      width: 50px;
      display: block;
      background: url(<%= asset_path('rails.png') %>) no-repeat;
  }
}
```

7 Use CoffeeScript so when the New Weapon link is pressed it makes the #newWeapon div visible and then hides the New Weapon link. Don't forget to call preventDefault().

```ruby
$(document).ready ->
  $('#displayWeaponForm').click (event) ->
    event.preventDefault()
    $(this).hide()
    $('#newWeapon').show()
```

======================================================================

Level 5

1 Complete the method below so that if the ammo is low it will render the fire_and_reload view, otherwise it should render the fire_weapon view.

```ruby
class WeaponsController < ApplicationController
  def fire_weapon
    @weapon = Weapon.find(params[:id]) 
    @weapon.fire!

    if @weapon.low_ammo?
      render 'fire_and_reload'
    end

  end
end
```

2 Create two custom member routes on the weapons resource, so you have a put method called toggle_condition and a put method called reload.

```ruby
RailsForZombies::Application.routes.draw do
  resources :zombies do
    resources :weapons do
      put :toggle_condition, on: :member
      put :reload, on: :member
    end
  end
end
```


3 Complete the create method below. When @weapon.save is successful it should render the @weapon object in JSON, have status :created, and set the location to the @weapon's show url. When @weapon.save fails it should return the @weapon.errors and have the status :unprocessable_entity.

```ruby
class WeaponsController < ApplicationController 
  def create
    @weapon = Weapon.new(params[:weapon]) 
    if @weapon.save
      render json: @weapon, status: :created, location: @weapon
      
    else
      render json: @weapon.errors, status: :unprocessable_entity
    end
  end 
end
```


4  Complete the controller so that it returns in JSON only the amount of ammo which is left in the weapon. If the ammo has less than 30 bullets it should return the status code :ok, and if not it should return the status code :unprocessable_entity.

```ruby
class WeaponsController < ApplicationController
  def reload
    @weapon = Weapon.find(params[:id]) 

    if @weapon.ammo < 30
      @weapon.reload(params[:ammo_to_reload])
      render json: @weapon.to_json(only: :ammo), status: :ok
    else
      render json: @weapon.to_json(only: :ammo), status: :unprocessable_entity
    end
  end
end
```

5 Modify the show action so that the JSON it renders includes the zombie record the @weapon belongs to. Also make it exclude the :id, :created_at, and :updated_at fields.

```ruby
class WeaponsController < ApplicationController
  def show
    @weapon = Weapon.find(params[:id])
    render json: @weapon.to_json(include: :zombie, except: [:id, :created_at, :updated_at])
  end
end
```

6 Edit the as_json method so the Zombie class only returns the zombie's name and weapons (use include). Only return the weapon's name and ammo.

```ruby
class Zombie < ActiveRecord::Base
  has_many :weapons

  def as_json(options=nil)
    super(options || 
      {only: :name, include: :weapons, only: [:name, :ammo]})
  end 
end
```

7 Modify the show.html.erb view below so that both the Toggle link and the Reload form use AJAX. All you need to do is add the option that makes them ajaxified.

```ruby
<ul>
  <li>
    <em>Name:</em> <%= @weapon.name %>
  </li> 
  <li>
    <em>Condition:</em>
    <span id="condition"><%= @weapon.condition %></span>
    <%= link_to "Toggle", toggle_condition_weapon_path(@weapon), remote: true %>
  </li> 
  <li>
    <em>Ammo:</em>
    <span id="ammo"><%= @weapon.ammo %></span>
  </li>
</ul>

<%= form_for @weapon, url: reload_weapon_path(@weapon), remote: true do |f| %>
  <div class="field">
    Number of bullets to reload:
    <%= number_field_tag :ammo_to_reload, 30 %> <br /> <%= f.submit "Reload" %>
  </div>
<% end %>
```

8 Modify the toggle_condition action so that it responds to JavaScript, and complete the toggle_condition.js.erb using jQuery to update the condition span with the @weapon's changed condition and make it highlight.

```jquery
$('span#condition').append("<%= escape_javascript(@weapon.condition) %>").effect('highlight');
```

9 Now write the controller and JavaScript code needed to properly reload the weapon using the ajaxified form. In the reload.js.erb use jQuery to update the #ammo text to the current @weapon.ammo value and if the ammo value is over or equal to 30, fadeOut the #reload_form div.

```ruby
$('span#ammo').text("<%= @weapon.ammo %>");
<% if @weapon.ammo >= 30 %>
  $('div#reload_form').fadeOut();
<% end %>
```


10 Instead of returning jQuery which gets executed on the client-side, lets write the ajax request in CoffeeScript communicating with JSON. It should do the same thing as the last challenge, updating & highlighting the ammo, and fading out the form (hint: fade out the wrapper element) if ammo is equal or above 30. 
Tip for your ajax form: data: {ammo_to_reload: ammo}.

```coffeescript
$(document).ready ->
  $('div#reload_form form').submit (event) ->
    event.preventDefault()
    url = $(this).attr('action')
    ammo = $('#ammo_to_reload').val()
    
    $.ajax
      type: 'put'
      url: url
      data: {weapon: {ammo: ammo} }
      dataType: 'json'
      success: (json) -> 
        $('#ammo').text(json.ammo).effect('highlight')
        $('#reload_form').fadeOut() if json.ammo >= 0
```
============================================================

ScreenCast

Asset Pipline

bundle open jquery-rails
rails s -e production
rake assets:precompile        

================================================

Ruby Bits

Level 2

2 We want to make sure that each game is a valid game object - in this case a simple hash of values. Even still, we wouldn't want to return a hash with a nil name. Raise an InvalidGameError error in the new_game method if name is nil.

```ruby
class InvalidGameError < StandardError; end
def new_game(name, options={})
  raise InvalidGameError, "You must provide a name" if name.nil?
  {
    name: name,
    year: options[:year],
    system: options[:system]
  }
end
begin
  game = new_game(nil)
rescue InvalidGameError => e
  puts "There was a problem creating your new game: #{e.message}"
end
```

3 When passing in an array of arguments to a method, sometimes it'll make sense to use Ruby's "splat" operator rather than explicitly requesting an array. Update the describe_favorites method and the call to it to instead use the splat operator.

```ruby
def describe_favorites(*games)
  for game in games
    puts "Favorite Game: #{game}"
  end  
end
describe_favorites('Mario', 'Contra', 'Metroid')
```

4 Passing around hashes is getting troublesome, let's use a class to hold our data. We've started the Game class for you, now please implement the initialize method to store name, system and year in instance variables.

```ruby
class Game
  def initialize(name, options={})
    @name=name
    @year=options[:year]
    @system=options[:system]
  end
end
```

6 attr_accessor
Whoever created the game object will want to be able to access the name, year and system for the game, but that doesn't mean we need to make getter methods for them. Refactor the code below to make these variables available using the Ruby way with attr_accessor.

```ruby
class Game
  attr_accessor :name, :year, :system
  def initialize(name, options={})
    @name = name
    @year = options[:year]
    @system = options[:system]
  end
end
```

7 When a game is initialized, store another variable called created_at which is set to Time.now in the initialize method. Make sure it can be accessed, but that it cannot be set from outside the object.

```ruby
class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at
  def initialize(name, options={})
    @name = name
    @year = options[:year]
    @system = options[:system]
    @created_at = Time.new
  end
end
```

level 3

1 

```ruby
class Library
  attr_accessor :games
  def initialize(games)
    @games = games
  end
end
```

2

```ruby
class Library
  attr_accessor :games

  def initialize(games)
    self.games = games
  end

  def has_game?(game)
    for game in games
      return true if game == @game
    end
    false
  end
end
```

3 We can initialize our Library with an array of games, but the only way to add games from outside the class is to use the games accessor method and alter the array. This is breaking encapsulation, so let's create a new method in Library called add_game which takes in a game and adds it to the games array.

```ruby
class Library
  attr_accessor :games

  def add_game(game)
    self.games << game
  end
  
  def initialize(games)
    self.games = games
  end

  def has_game?(search_game)
    for game in games
      return true if game == search_game
    end
    false
  end
end
```

4 Things are looking good! We're able to use our Library class to store our games now. Whenever we call add_game, let's call a new private method called log which will call puts with some information about the game that was added. Your log method should take in a string to be displayed.

```ruby
class Library
  attr_accessor :games

  def initialize(games)
    self.games = games
  end

  def has_game?(search_game)
    for game in games
      return true if game == search_game
    end
    false
  end

  def add_game(game)
    self.games << game
    log("The game name is #{game.name}, it was built in #{game.year}, for #{game.system}")
  end
  
  private 
  
  def log(message)
    puts message
  end
end
```

5

```ruby
class ArcadeGame < Game
end
class ConsoleGame < Game
end
```

6 Inheritance II
For our ArcadeGame class, we'll also want to track the weight of these giant cabinets taking up all of our available space. Luckily we thought ahead: we already take in an options parameter that we can stick weight into! Override the initialize method for ArcadeGame to take in the same parameters as its parent class, call super, and then set weight.

```ruby
class ArcadeGame < Game
  attr_accessor :weight
  def initialize(name, options={})
    super
    self.weight = options[:weight]
  end
end
class ConsoleGame < Game
end
```

7 Inheritance III
Whenever we output a game right now it'll show up using the to_s method from Object, the parent object of Game. A basic to_s implementation is completed below on Game. Override this for ConsoleGame to also show the system the game is on.

```ruby
class ConsoleGame < Game
  def to_s
    super + self.system
  end
end
```

8 Refactoring
Our to_s method will come in very handy. Whenever we need to output a game, rather than calling a method on the game, we can just output the game object and Ruby will call to_s on it automatically. Refactor both classes below. Change the description method of Game to use the to_s method implicitly. Then remove any duplicated code in ConsoleGame. Note: you'll need to use self inside a class to reference the entire object.

Original
```ruby
class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at
  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    @created_at = Time.now
  end

  def to_s
    self.name
  end

  def description
    "#{self.name} was released in #{self.year}."
  end
end

class ConsoleGame < Game
  def to_s
    "#{self.name} - #{self.system}"
  end

  def description
    "#{self.name} - #{self.system} was released in #{self.year}."
  end
end
```

Changed

```ruby
class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at
  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    @created_at = Time.now
  end

  def to_s
    self.name
  end

  def description
    "#{self} was released in #{self.year}."
  end
end

class ConsoleGame < Game
  def to_s
    "#{super} - #{self.system}"
  end
end
```

=========================================

Level 4

1 print array from Contra to the end of games

def last_games(games, index)
  games.from(index)
end
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
index = games.index('Contra')
puts last_games(games, index)

3 20 years after game release

def anniversary(game, years)
  game[:release].advance(years: years)
end

game = {
  name: 'Contra',
  release: DateTime.new(1987, 2, 20, 0, 0, 0)
}
puts anniversary(game, 20)


4 Using ActiveSupport, return the difference between Mario's favorite games and Luigis's favorite games by implementing the difference_between method.

def difference_between(player1, player2)
  player1.diff(player2)
end

mario_favorite = {
  sports: "Mario Sports Mix",
  action: "Super Mario World"
}

luigi_favorite = {
  sports: "Golf",
  action: "Super Mario World"
}

puts difference_between(mario_favorite, luigi_favorite)

5 Implement the exclude_character method below to return characters except the passed in character. Use ActiveSupport to return these key/pair values. Also, change the call to exclude_character so that yoshi's games are excluded.

def exclude_character(games, character)
  games.except(character)
end

games = {
  mario: ["Super Mario World", "Super Smash Bros. Melee"],
  luigi: ["Luigi's Mansion"],
  yoshi: ["Yoshi's Island", "Yoshi's Story"]
}
puts exclude_character(games, :yoshi)


6 Numbers
Refactor the describe_count method below to use ActiveSupport in order to find out if a number is even or odd.

def describe_count(games)
  if games.empty?
    "You have no games"
  elsif games.length.even?
    "You have an even number of games"
  elsif games.length.odd?
    "You have an odd number of games"
  end
end

games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
puts describe_count(games)


7 Strings
Implement the convert_title method to use one of String's core extension methods. Given the input below, this method should return the string 'Super Mario Bros.'

def convert_title(title)
  title.titleize
end

puts convert_title("super mario bros.")


=======================================================

Ruby Bites Lesson 5

1 Create a module named GameUtils and place the lend_to_friend method inside the module. Change lend_to_friend to a class method by prefixing it with self..
You won't need to require this module since it'll be inside the same file (already required), but you will have to namespace your method call.


module GameUtils
  def self.lend_to_friend(game, friend_email)
  end
end

game = Game.new("Contra")
GameUtils.lend_to_friend(game, "gregg@codeschool.com")



2 Re-open the Game class and include the GameUtils module so its methods are exposed as instance methods. Make sure to do this before it is called.

class Game
  include GameUtils
  def initialize(name)
    @name = name
  end
end

game = Game.new("contra")
game.lend_to_friend("Gregg")


3 Good job! Now expose the methods from the GameUtils module as class methods of the Game class.

class Game
  extend GameUtils

end

Game.find_all_from_user("Gregg")


4 Object Extend
Extend the single game object with the Playable module, so we can call the play method on it.

game = Game.new("Contra")
game.extend(Playable)
game.play


5 Hook Methods
Define a new self.included method hook for the LibraryUtils module which will extend the ClassMethods on the passed in class. Also, since we'll now be extending ClassMethods when LibraryUtils is included, remove duplicate code in the AtariLibrary class.

module LibraryUtils
  def self.included(base)
    base.extend(ClassMethods)
  end   
    
  def add_game(game)
  end

  def remove_game(game)
  end

  module ClassMethods
    def search_by_game_name(name)
    end
  end
end

class AtariLibrary
  include LibraryUtils
end

6 ActiveSupport::Concern - Part I
Now refactor the following code to use ActiveSupport::Concern's ability to expose class methods from a module.


module LibraryUtils

  extend ActiveSupport::Concern

  def add_game(game)
  end

  def remove_game(game)
  end

  module ClassMethods
    def search_by_game_name(name)
    end
  end
end

7 Call the included method from inside the LibraryUtils module and pass in a block that calls the load_game_list class method.

```ruby

module LibraryUtils

  extend ActiveSupport::Concern
  included do
    load_game_list
  end
  
  def add_game(game)
  end

  def remove_game(game)
  end

  module ClassMethods
    def search_by_game_name(name)
    end

    def load_game_list
    end
  end
end
```


8  Make sure the AtariLibrary class includes only the LibraryUtils module and let ActiveSupport::Concern take care of loading its dependencies. Then, refactor the self.included method on LibraryUtils to use the included method.

```ruby
module LibraryLoader

  extend ActiveSupport::Concern

  module ClassMethods
    def load_game_list
    end
  end
end

module LibraryUtils
  extend ActiveSupport::Concern
  include LibraryLoader
  included do
    load_game_list
  end
end

class AtariLibrary
  include LibraryUtils
end
```

### Ruby Bites Level 6 -- Block

###### 1 Let's build a Library class that will manage our growing collection of games. We've already written a list method that prints the names of all our games, but it uses an ugly for loop to iterate the list. Refactor it to use each with a block instead.

```ruby
class Library
  attr_accessor :games
  def initialize(games = [])
    self.games = games
  end

  def list
    games.each do |game|
      puts game.name
    end
  end
end
```

###### 2 We'd like to be able to operate on our games by system. Implement an each_on_system method that iterates over our games using each and yields to a block for every game on the requested system. To test that it's working, we'll call each_on_system with a simple block that prints a message for every Super Nintendo game in our library. See the example.rb below.

```ruby
class Library
  attr_accessor :games

  def initialize(games = [])
    self.games = games
  end

  def each_on_system(system)
    games.each {|game| yield if game.system == system}  
  end
end
```

###### 3 Our each_on_system method is working, but it's not very useful unless the block has access to each game that we find. Modify each_on_system to pass the Game object into the block so we can print its name.

```ruby
class Library
  attr_accessor :games

  def initialize(games = [])
    self.games = games
  end

  def each_on_system(system)
    games.each do |game|
      yield(game) if game.system == system
    end
  end
end
```

###### 4 Earlier we wrote a list method that prints the name of each game in our library. We can make the output formatting more flexible by allowing a block to be passed to the list method. We'll yield each game to the block and allow the block to format and return a string for us to display. Modify the list method to yield to a block and print whatever the block returns.

```ruby
class Library
  attr_accessor :games

  def initialize(games = [])
    self.games = games
  end

  def list
    games.each do |game|      
      puts yield(game)
    end
  end
end
```

###### 5 Using Enumerable
###### Let's add the power of Ruby's Enumerable module to our game library. Implement an each method that yields each game in the library. Finally, include the Enumerable module so that we'll be able to call methods like select and collect on our library.

```ruby
class Library
  attr_accessor :games
  include Enumerable
  def initialize(games = [])
    self.games = games
  end

  def each
    games.each do |game|
      yield game
    end
  end
end

```

###### 6 Refactoring with Blocks
###### Now that our library is complete, let's play some games! A friend has given us his Emulator class to use, and we've implemented methods to play a game and grab a screenshot. But look at all that duplicated code in play and screenshot. Refactor the duplication (the begin, new and rescue parts) into a private method called emulate that handles the emulator setup and exception handling and yields the emulator instance to a block.

```ruby
class Game
  attr_accessor :name, :year, :system
  attr_reader :created_at

  def initialize(name, options={})
    self.name = name
    self.year = options[:year]
    self.system = options[:system]
    @created_at = Time.now
  end

  def play
    emulate {|emulator| emulator.play(self)}
  end

  def screenshot
    emulate {|emulator| emulator.start(self); emulator.screenshot}
  end
  
  private
  
  def emulate
    begin
      emulator = Emulator.new(system)
      yield(emulator)
    rescue Exception => e
      puts "Emulator failed: #{e}"
    end
  end
  
end

```
### Test Level 1
1 Write a basic conditional test using assert which checks if 1 > 0. Name your test class ConditionalTest.

```ruby
require 'test/unit'

class ConditionalTest < Test::Unit::TestCase
  def test_true_or_false
    assert 1 > 0
  end
end
```

2 Add the custom error message One is not greater than zero to the failing assertion we just created

```ruby
class ConditionalTest < Test::Unit::TestCase
  def test_one_greater_than_zero
    assert 0 > 1, "one is not greater than zero"
  end
end
```

3 In a moment we are going to create the multiple_of? in our Multiple module which returns true if a number is a multiple of another number. Finish the test below, asserting that Multiple.multiple_of?(10, 5) returns true.

```ruby
class MultipleTest < Test::Unit::TestCase
  def test_multiple_of
    assert Multiple.multiple_of?(10, 5)
  end
end
```

4 Now that we have a failing test, let's make it pass by creating the self.multiple_of?(multiple, num) method in the Multiple module. Hint: one way of checking multiples is using the modulo operator, multiple % num == 0 (will be 'true' if multiple can be divided evenly by the num)

```ruby
module Multiple
  def self.multiple_of?(x, y)
    x % y == 0
  end
end
```

5 We are going to create a Zombifier class with a zombify method that upcases and adds 'BRAINS'. Lets begin by writing a test using assert_not_nil to make sure zombify returns something.

```ruby
class ZombifierTest < Test::Unit::TestCase
  def test_zombify_returns_something
    z = Zombifier.new('make me a zombie')
    assert_not_nil z.zombify
  end
end
```

6 Notice our zombifier.rb file and how the zombify method adds 'BRAINS' to the string, use assert_match to test if zombify is doing this correctly.

```ruby
class ZombifierTest < Test::Unit::TestCase
  def test_zombify_brains
    z = Zombifier.new('I love your arms')
    assert_match /BRAINS/, z.zombify
  end
end
```

7 Now, using assert_equal, write a test to make sure zombify returns the expected string, upcase with 'BRAINS'. ex. "HELLO WORLD BRAINS" is expected when we call Zombifier.new("Hello world").zombify

```ruby
class ZombifierTest < Test::Unit::TestCase
  def test_zombify_upcase
    z = Zombifier.new("Hello world")
    assert_equal "HELLO WORLD BRAINS", z.zombify
  end
end
```

8 Notice in zombifier.rb how we now raise a RuntimeError if the string already looks like a zombie (contains 'BRAINS'). Test for this behavior using assert_raise.

```ruby
class ZombifierTest < Test::Unit::TestCase
  def test_brains_in_zombify_raises_error
    z = Zombifier.new('BRAINS')
    assert_raise(RuntimeError){z.zombify}
  end
end
```

9 Since zombify is supposed to modify an existing string, it should also return a string. Create a test using assert_kind_of to make sure a String is being returned.

```ruby
class ZombifierTest < Test::Unit::TestCase
  def test_zombify_returns_a_string
    z = Zombifier.new('I like knees')
    assert_kind_of String, z.zombify
  end
end
```
### Testing level 2
1 Using an assert and the valid? method, test that a 'tweet' is not valid without a status.

```ruby
class TweetTest < ActiveSupport::TestCase
  test "invalid without a status" do
    tweet = Tweet.new
    assert !tweet.valid?
  end
end
```

2 Execute the rake command which will run both db:test:prepare and all the tests.
``` 
rake db:test:prepare
```

3 Lets try another validation test. This time, test to make sure a tweet is valid with all its attributes before save. A tweet has a zombie and a status (you'll need to create a zombie for this).

```ruby
class TweetTest < ActiveSupport::TestCase
  test "valid with all attributes" do
    zombie = Zombie.new
    tweet = Tweet.new
    
    tweet.status = 'Hello world'
    tweet.zombie = zombie
    assert tweet.valid?
  end
end
```

4 Create a tweets fixture in the tweets.yml file. The Tweet model has a zombie_id that's an Integer and a status that's a String.

```ruby
hello_world:
    zombie_id: 1
    status: "hello_world"
```

5 Now that we have fixtures tweets.yml and zombies.ymlbelow, let's clean up some tests. Add fixtures to the following tests.

```ruby
class TweetTest < ActiveSupport::TestCase
  test "valid with all attributes" do
    z = zombies(:ash)
    t = tweets(:hello_world)

    assert t.valid?, "tweet isn't valid"
  end
end
```
###### notice the 'zombies(:ash)' this method name is same as yml file name zombies.yml

6 Create a test that ensures the brains? method returns true if a status contains 'brains'.

```ruby
class TweetTest < ActiveSupport::TestCase
  test "can detect brains" do
    tweet = tweets(:hello_world)
    tweet.status = 'brains'
    
    assert tweet.brains?
  end
end
```

7 Create a test to ensure that the hello_world tweet contains zombie Ash.
```ruby
class TweetTest < ActiveSupport::TestCase
  test "contains a zombie" do
    t = tweets(:hello_world)
    z = zombies(:ash)
    z.tweets.all? {|t| t.zombie == z }
    assert t.zombie == z
  end
end
```
### Level 3
1 SETUP METHOD
http://rtfz.codeschool.com/levels/3/challenges/1

```ruby
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end
  
  test "invalid without a status" do
    @tweet.status = nil
    assert !@tweet.valid?, "Status is not being Validated"
  end

  test "valid with all attributes" do
    assert @tweet.valid?, "tweet isn't valid"
  end
end
```

2 CUSTOM ASSERT

```ruby
class TweetTest < ActiveSupport::TestCase

  def setup
    @tweet = tweets(:hello_world)
  end

  # Don't change this, use it to refactor the tests below.
  def assert_attribute_is_validated(model, attribute)
    # This line sets the specified attribute to nil 
    model.assign_attributes(attribute => nil)
    assert !model.valid?, "#{attribute.to_s} is not being validated"
  end

  test "invalid without a status" do  
    assert_attribute_is_validated(@tweet, :status)
  end

  test "invalid without a zombie" do
    assert_attribute_is_validated(@tweet, :zombie)
  end
end
```

3 INTRODUCING SHOULDA

http://rtfz.codeschool.com/levels/3/challenges/4

```ruby
class TweetTest < ActiveSupport::TestCase
  should validate_presence_of(:status)
  should validate_presence_of(:zombie)
end
```

4 SHOULDA I

http://rtfz.codeschool.com/levels/3/challenges/5

```ruby
class TweetTest < ActiveSupport::TestCase
  should validate_uniqueness_of(:id)
  should validate_numericality_of(:id)
end
```

5 SHOULDA II
http://rtfz.codeschool.com/levels/3/challenges/6
```ruby
class TweetTest < ActiveSupport::TestCase
  should ensure_length_of(:status).is_at_least(3).is_at_most(140)
end
```
### Level 4

1 STUBBING

```ruby
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  test "show_author_summary should set status to zombie summary" do 
    @tweet.zombie.stubs(:zombie_summary)
    @tweet.show_author_summary
    assert_equal @tweet.zombie.zombie_summary, @tweet.status, 'tweet status does not contain zombie summary'
  end
end
```

2 MOCKING

```ruby
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  test "show_author_summary should call zombie_summary" do
    @tweet.zombie.expects(:zombie_summary)
    @tweet.show_author_summary
  end
end
```

3 STUB + ASSERT

```ruby
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  test "status_image calls the ZwitPic get_status_image api" do 
    ZwitPic.expects(:get_status_image).with(@tweet.id)
    @tweet.status_image
  end
end
```

4 STUBS & MOCKING

```ruby
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  test "status_image calls the ZwitPic get_status_image api" do 
    ZwitPic.expects(:get_status_image).with(@tweet.id).returns(["name.png", 'http://eathead.com'])
    @tweet.status_image
  end
end
```

5 RETURNING PROPER RESULTS

```ruby
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  test "status_image returns a properly formated HTML image element with alt and src" do
    ZwitPic.stubs(:get_status_image).with(@tweet.id).returns({url: 'eatbrain.com', name: 'pic.png'})
    assert_equal "<img src='eatbrain.com' alt='pic.png' />", @tweet.status_image
  end
end
```

6 OBJECT STUB

```ruby
class TweetTest < ActiveSupport::TestCase
  def setup
    @tweet = tweets(:hello_world)
  end

  test "status_image returns a properly formated HTML image element with alt and src" do
    image = stub({name: 'Yummy brain I ate last night', url: 'http://zwitpic.com/2.jpg'})
    ZwitPic.stubs(:get_status_image).returns(image)
    assert_equal "<img src='http://zwitpic.com/2.jpg' alt='Yummy brain I ate last night' />", @tweet.status_image
  end
end
```
### JQuery
Leve 3

3.1  Refactoring

```ruby
$(document).ready(function(){
  $("button").on("click", function(){
    var tour = $(this).closest(".tour");
    var discount = tour.data("discount");
    var message = $("<span>Call 1-555-jquery-air for a $" + discount + " discount.</span>");
    tour.append(message);
    $(this).remove();
  });
});
```

3.2 Better On Handlers

```ruby
$(document).ready(function(){
  $(".tour").on("click", "button", function(){
    var tour = $(this).closest(".tour");
    var discount = tour.data("discount");
    var message = $("<span>Call 1-555-jquery-air for a $" + discount + " discount.</span>");
    tour.append(message);
    $(this).remove();
  });
});
```

3.21 New Filter

```ruby
$(document).ready(function(){
  //Create the click handler here
  $("#filters").on('click', ".on-sale", function(){});
});
```

3.22 New Filter

```ruby
$(document).ready(function(){
  $("#filters").on("click", ".on-sale", function(){
    $(".tour").filter(".on-sale").addClass("highlight");
  });
});
```

3.23 New Filter III

```ruby
$(document).ready(function(){
  $("#filters").on("click", ".on-sale", function(){
    $(".highlight").removeClass("highlight");
    $(".tour").filter(".on-sale").addClass("highlight");
  });

  $("#filters").on("click", ".featured", function(){
    $(".highlight").removeClass("highlight");
    $(".tour").filter(".featured").addClass("highlight");
  });
});
```

### Test Level 5
1 RAILS INTEGRATION TEST

```ruby
class TweetDisplaysStatusTest < ActionDispatch::IntegrationTest
  def setup
    @tweet = tweets(:hello_world)
  end

  test "Tweet page responds successfully" do
    get tweet_url(@tweet)
    assert_response :success 
  end

  test "Tweet displays status in heading" do 
    get tweet_url(@tweet)
    assert_select "h1", @tweet.status
  end
end
```

2 RAILS INTEGRATION TEST - POST


```ruby
class CreatingATweetTest < ActionDispatch::IntegrationTest
  def setup
    @zombie = zombies(:ash)
    @tweet_attributes = {tweet: {zombie_id: @zombie.id, status: 'Test tweet'}}
  end

  test "Responds with a redirect to the tweet page" do
    post tweets_url, @tweet_attributes
    @tweet = Tweet.last
    #notice tweet_path, test failed in this part
    assert_redirected_to tweet_path(@tweet)
  end
end

```

3 CAPYBARA INTEGRATION TEST

```ruby
class TweetDisplaysStatusTest < ActionDispatch::IntegrationTest
  def setup
    @tweet = tweets(:hello_world)
  end

  test "Tweet displays status in heading" do
    visit tweet_url(@tweet)
    within("h1") do
      assert has_content?(@tweet.status)
    end
    #get tweet_url(@tweet)
    #assert_select 'h1', @tweet.status
  end
end
```

4 CAPYBARA INTEGRATION TEST II

```ruby
class CreatingATweetTest < ActionDispatch::IntegrationTest
  test 'should create a new tweet' do
    visit new_tweet_url
    fill_in "tweet_status", with: 'Looking for brain'
    select "Ash", from: "tweet_zombie_id"
    click_button "Create Tweet"
    assert_equal tweet_path(Tweet.last), current_path
  end
end
```

5 CAPYBARA INTEGRATION TEST III

```ruby
class CreatingATweetTest < ActionDispatch::IntegrationTest
  test 'should go to new tweet page' do
    visit root_path
    click_link "New Tweet"
    assert_equal new_tweet_path, current_path
  end
end
```

6 HELPER METHODS

test/test_helper.rb
```ruby
class ActiveSupport::TestCase
  def create_tweet_for(zombie, status)
    visit new_tweet_url
    fill_in 'Status', with: status
    select zombie, from: 'Zombie'
    click_button 'Create Tweet'
  end
end
```

test/integration/creating_a_new_tweet_test.rb
```ruby
class CreatingATweetTest < ActionDispatch::IntegrationTest
  test 'should create a new tweet' do
   # visit new_tweet_url
  #  fill_in 'Status', with: 'I love the way your brain feels'
   # select 'Ash', from: 'Zombie'
  #  click_button 'Create Tweet'
    create_tweet_for("Ash", "I love the way your brain feels")
    assert_equal tweet_path(Tweet.last), current_path
  end
end
```
### Try JQuery Level 4

4.5 Slide Effect

```javascript
$(document).ready(function() { 
  //alert($(".photos").length)
  $("#tour").on("click", "button", function() { 
    $(".photos").slideDown();
  });
});

```
4.6 Slide Effect II

```javascript
$(document).ready(function() { 
  $("#tour").on("click", "button", function() { 
    $(".photos").slideToggle();
    //$(".photos").slideDown();
  });
});
```
4.9 Mouseover II

```javascript
$(document).ready(function() {
  $("#tour").on("click", "button", function() {
    $(".photos").slideToggle();
  });
  $(".photos").on("mouseenter", "li", function() {
    $(this).find("span").slideToggle();
  });
});
```
4.11 Named Functions

```javascript
$(document).ready(function() {
  $("#tour").on("click", "button", function() {
    $(".photos").slideToggle();
  });
  $(".photos").on("mouseenter", "li", showPhotos).on("mouseleave", "li", showPhotos);
});

function showPhotos(){
  $(this).find("span").slideToggle();
}
```
4.14 Keyup Event Handler 

```javascript
$(document).ready(function() {
  $("#nights").on("keyup", function() {
    var days = $(this).val();
    $("#nights-count").text(days);
  });
});
```
4.15 Keyup Event Handler II

```javascript
$(document).ready(function() {
  $("#nights").on("keyup", function() {
    $("#nights-count").text($(this).val());
    var total = +$(this).val() * +$(this).closest(".tour").data("daily-price");
    $("#total").text(total);
  });
});
```
4.16 Another Event Handler

```javascript
$(document).ready(function() {
  $("#nights").on("keyup", function() {
    var nights = +$(this).val();
    var dailyPrice = +$(this).closest(".tour").data("daily-price");
    $("#total").text(nights * dailyPrice);
    $("#nights-count").text($(this).val());
  });
  $("#nights").on("focus", function(){
    $(this).val("7");
  });
});
```

4.19 Link Events II

```javascript
$(document).ready(function() {
  $(".see-photos").on("click", function() {
    $(this).closest(".tour").find(".photos").slideToggle();
  });
});
```

4.20 Event Parameter

```javascript
$(document).ready(function() {
  $(".see-photos").on("click", function(event) {
    event.stopPropagation();
    $(this).closest(".tour").find(".photos").slideToggle();
  });
  $(".tour").on("click", function() {
    alert("This should not be called");
  });
});
```

4.21 Event Parameter II

```javascript
$(document).ready(function() {
  $(".see-photos").on("click", function(event) {
    event.stopPropagation();
    event.preventDefault();
    $(this).closest(".tour").find(".photos").slideToggle();
  });
  $(".tour").on("click", function() {
    alert("This should not be called");
  });
});
```
### Level 5

5.3 CSS I

```javascript
$(document).ready(function() {
  $(".tour").on("mouseenter", function() {
    $(this).css("background-color", "#252b30");
  });
});
```

5.4 CSS II

```javascript
$(document).ready(function() {
  $(".tour").on("mouseenter", function() {
    $(this).css({"background-color": "#252b30", "font-weight": "bold"});
  });
});
```
5.5 Show Photo

```javascript
$(document).ready(function() {
  $(".tour").on("mouseenter", function() {
    $(this).css({"background-color": "#252b30", "font-weight": "bold"});
    $(this).find(".photos").show();
  });
});
```
5.6 Refactoring to CSS

```javascript
//don't add . inside the addClass and removeClass, addClass(".highlight") => wrong
$(document).ready(function() {
  $(".tour").on("mouseenter", function() {
    $(this).addClass("highlight");
    $(this).find(".photos").show();
  });
  $(".tour").on("mouseleave", function(){
    $(this).removeClass("highlight");
  });
});
```

5.8 Animate I

```javascript
$(document).ready(function() {
  $('.tour').on('mouseenter', function() {
    $(this).addClass('highlight');
    //the per night is default transparent , set the opacity to show it 
    $(this).find(".per-night").animate({opacity: 1});
  });
  $('.tour').on('mouseleave', function() {
    $(this).removeClass('highlight');
  });
});
```

5.9 Animate II
```javascript
$(document).ready(function() {
  $(".tour").on("mouseenter", function() {
    $(this).addClass("highlight");
    $(this).find(".per-night").animate({"opacity": "1", "top": "-14px"});
  });
  $(".tour").on("mouseleave", function() {
    $(this).removeClass("highlight");
  });
});
```

5.10 Animation Speed
```javascript
$(document).ready(function() {
  $(".tour").on("mouseenter", function() {
    $(this).addClass("highlight");
    //add fast arg
    $(this).find(".per-night").animate({"top": "-14px","opacity": "1"}, "fast");
  });
  $(".tour").on("mouseleave", function() {
    $(this).removeClass("highlight");
  });
});
```

5.11 Animate III
```javascript
$(document).ready(function() {
  $(".tour").on("mouseenter", function() {
    $(this).addClass("highlight");
    $(this).find(".per-night").animate({"top": "-14px","opacity": "1"}, "fast");
  });
  $(".tour").on("mouseleave", function() {
    $(this).removeClass("highlight");
    //fadeOut when mouse leave
    $(this).find(".per-night").animate({top: 0, opacity: 0}, "fast");
  });
});
```
### Test Level 6

1 FACTORIES

```ruby
FactoryGirl.define do
  factory :zombie do
    name 'Sally'
    graveyard 'Valley Dim'
  end
end
```

2 COMPLEX FACTORIES

```ruby
FactoryGirl.define do
  factory :zombie do
    name 'Ash'
    graveyard 'Petrosville'
 
    # Add sally and moe here
    factory :sally do
      name 'Sally'
      graveyard 'Valley Dim'
    end
  
    factory :moe do
      name 'Moe'
      graveyard 'Petrosville'
    end
  end
end
```

3 UNIQUE ATTRIBUTES

```ruby
FactoryGirl.define do
  factory :zombie do
    sequence(:name) {|i| "Ash#{i}"}
    sequence(:graveyard) {|i| "Petrosville Cemetary#{i}"}
  end
end
```

4 ASSOCIATIONS

```ruby
FactoryGirl.define do
  factory :tweet do
    status "Dead"
    association :zombie
  end
end
```

5 USING FACTORIES

```ruby
class TweetTest < ActiveSupport::TestCase
  test "A tweet requires a status" do
    tweet = FactoryGirl.build(:tweet, status: nil)
    assert !tweet.valid?, "tweet isn't valid"
  end
end
```
6 USING FACTORIES II

```ruby
class TweetTest < ActionDispatch::IntegrationTest
  test "tweet page has zombie link" do 
    @tweet = Factory(:tweet)
    visit tweets_url
    click_link @tweet.status
    within("h3") do
      assert has_content?(@tweet.zombie.name)
    end
  end
end
```
### JQuery The return flight

1.3 Ajax

```javascript
$(document).ready(function() {
  $("#tour").on("click", "button", function() {
    $.ajax("/photos.html",
           {
             success: function (response){
               alert("Ajax");
             }
           }
          );
  });
});
```

1.4 Ajax with Response

```javascript
$(document).ready(function() { 
  $("#tour").on("click", "button", function() { 
    $.ajax('/photos.html', {
      success: function(response){
        $(".photos").html(response).fadeIn();
      }
    });
  });
});
```
1.5 $.get Shorthand

```javascript
$(document).ready(function() {
  $("#tour").on("click", "button", function() {
    $.get('/photos.html', function(response) {
        $('.photos').html(response).fadeIn();
      }
    );
  });
});
```
1.6 Ajax Data

```javascript
$(document).ready(function() {
  $("#tour").on("click", "button", function() {
    $.ajax('/photos.html', {
      success: function(response) {
        $('.photos').html(response).fadeIn();
      },
      data: {"location": $("#tour").data("location")}
    });
  });
});
```
1.8 Ajax with Errors

```javascript
$(document).ready(function() {
  var el = $("#tour");
  el.on("click", "button", function() {
    $.ajax('/photos.html', {
      data: {location: el.data('location')},
      success: function(response) {
        $('.photos').html(response).fadeIn();
      },
      error: function(request, errorType, errorMessage){
        $(".photos").html("<li>Error: " + errorType + " with message: " + errorMessage + "</li>");
      }
    });
  });
});
```
1.9 Setting a Timeout

```javascript
$(document).ready(function() {
  var el = $("#tour");
  el.on("click", "button", function() {
    $.ajax('/photos.html', {
      data: {location: el.data('location')},
      success: function(response) {
        $('.photos').html(response).fadeIn();
      },
      error: function() {
        $('.photos').html('<li>There was a problem fetching the latest photos. Please try again.</li>');
      },
      timeout: 3000
    });
  });
});
```
1.10 More Ajax Callbacks

```javascript
$(document).ready(function() {
  $("#tour").on("click", "button", function() {
    $.ajax('/photos.html', {
      success: function(response) {
        $('.photos').html(response).fadeIn();
      },
      error: function() {
        $('.photos').html('<li>There was a problem fetching the latest photos. Please try again.</li>');
      },
      timeout: 3000,
      beforeSend: function(){
        $("#tour").addClass("is-fetching");
      },
      complete: function(){
        $("#tour").removeClass("is-fetching");
      }
    });
  });
});
```
1.11 Event Delegation
```javascript
$(document).ready(function() {
  function showPhotos() {
    $(this).find('span').slideToggle();
  }
  $('.photos').on('mouseenter', 'li', showPhotos)
                 .on('mouseleave', 'li', showPhotos);


  var el = $("#tour");
  el.on("click", "button", function() {
    $.ajax('/photos.html', {
      data: {location: el.data('location')},
      success: function(response) {
        $('.photos').html(response).fadeIn();
      },
      error: function() {
        $('.photos').html('<li>There was a problem fetching the latest photos. Please try again.</li>');
      },
      timeout: 3000,
      beforeSend: function() {
        $('#tour').addClass('is-fetching');
      },
      complete: function() {
        $('#tour').removeClass('is-fetching');
      }
    });
  });
});
```
### The Return Flight Level 2

2.3 Refactor To Objects

```javascript
var tour = {
  init: function(){
    $("#tour").on("click", "button", function() {
      $.ajax('/photos.html', {
        data: {location: $("#tour").data('location')},
        success: function(response) {
          $('.photos').html(response).fadeIn();
        },
        error: function() {
          $('.photos').html('<li>There was a problem fetching the latest photos. Please try again.</li>');
        },
        timeout: 3000,
        beforeSend: function() {
          $('#tour').addClass('is-fetching');
        },
        complete: function() {
          $('#tour').removeClass('is-fetching');
        }
      });
    });
  }
};
$(document).ready(function() {
  tour.init();
});
```
2.4 Event Handler Refactor
```javascript
var tour = {
  init: function() {
    $("#tour").on("click", "button", this.fetchPhotos);
  },
  fetchPhotos: function(){
    $.ajax('/photos.html', 
      {
        data: {location: $("#tour").data('location')},
        success: function(response) {
          $('.photos').html(response).fadeIn();
        },
        error: function() {
          $('.photos').html('<li>There was a problem fetching the latest photos. Please try again.</li>');
        },
        timeout: 3000,
        beforeSend: function() {
          $('#tour').addClass('is-fetching');
        },
        complete: function() {
          $('#tour').removeClass('is-fetching');
        }
      }
    );
  }
}

$(document).ready(function() { 
  tour.init();
});
```
2.6 Creating an Function

```javascript
//notice the capital T of the function name
function Tour() {
  console.log("A new Tour was created");
}
$(document).ready(function() { 
//new + object name
  var tour = new Tour();
});
```

2.7 Functionality in Functions
```javascript
function Tour(price) {
  console.log("A new Tour was created");
  this.price = price;
  this.cost = function(nights){
    console.log(nights * this.price);
  }
}
$(document).ready(function() { 
  var tour = new Tour(100);
  tour.cost(4);
});
```

2.8
```javascript
function Tour(el) {
  console.log(el)
}
$(document).ready(function() { 
  var paris = new Tour($('#paris'));
});
```

2.9 Function Setup

```javascript
function Tour(el) {
  this.el = el;
  //fetchPhotos must be defined before calling
  this.fetchPhotos = function(){
    alert("hello");
  }
  this.el.on('click', 'button', this.fetchPhotos);
}
$(document).ready(function() { 
  var paris = new Tour($('#paris'));
});
```

2.10 fetchPhotos Refactor
```javascript
function Tour(el) {
  var tour = this;
  this.el = el;
  this.fetchPhotos = function() {
    $.ajax('/photos.html', {
      context: tour,
      //notice this time it should use el which from Tour parameter, not this.el
      //the context only affect success and error functions
      data: {location: el.data('location')},
      success: function(response) {
        this.el.find('.photos').html(response).fadeIn();
      },
      error: function() {
        this.el.find('.photos').html('<li>There was a problem fetching the latest photos. Please try again.</li>');
      },
      timeout: 3000,
      beforeSend: function() {
        this.el.addClass('is-fetching');
      },
      complete: function() {
        this.el.removeClass('is-fetching');
      }
    });
  };
  this.el.on('click', 'button', this.fetchPhotos);
}
$(document).ready(function() { 
  var paris = new Tour($('#paris'));
});
```

### Rails Outlaw

Allow all http methods on routes

```ruby
ZombieOutlaws::Application.routes.draw do
  match '/undeads', to: 'undeads#index', via: :all 
end
```


Update the following controller test to use the new HTTP verb for partial updates.

```ruby
class WeaponsControllerTest < ActionController::TestCase
  test "updates weapon" do
    patch :update, zombie_id: @zombie, weapons: { name: 'Scythe' }
    assert_redirected_to zombie_url(@zombie)
  end
end
```

Routes Concern
```ruby
ZombieOutlaws::Application.routes.draw do
  
  concern :defensible do
    resources :shotguns
    resources :rifles
    resources :knives
  end
  
  resources :sheriffs, concerns: :defensible

  resources :gunslingers, concerns: :defensible

  resources :preachers, concerns: :defensible
end
```

Routes Concern
```ruby
ZombieOutlaws::Application.routes.draw do
  concern :defensible do |options|
    resources :shotguns, options
    resources :rifles, options
    resources :knives, options
  end

  resources :sheriffs, concerns: :defensible
  resources :gunslingers, concerns: :defensible
  resources :preachers do
    concerns :defensible, except: :destroy
  end
end
```

Thread Safety
```
ZombieOutlaws::Application.configure do
  # config.threadsafe!
  #prevents class reloading between requests and ensures Rack::Lock is not included in middleware stack
  config.cache_classes = true 
  #loads all code before new threads are created
  config.eager_load = true
end
```

### Rails Outlaw

```ruby
@zombie = Zombie.find_or_create_by(name: params[:name])
```
Scope
```ruby
scope :recent, ->{where('killed_on > ?', 2.days.ago)}
scope :outlaws, ->{where(status: 'outlaw')}
```
Return a null
```ruby
class Deputy < ActiveRecord::Base
  def self.zombie_counterforce
    if Zombie.at_large_count.zero?
      Deputy.none
    else
      Deputy.where(status: 'available')
    end
  end
end
```

Relation
```ruby
Zombie.where.not(status: 'outlaw')

Zombie.order(name: :desc, killed_on: :desc)

Weapon.includes(:zombies)
.where("zombies.name = 'Ash'").references(:zombies)

Weapon.includes(:zombies).where(zombies: {name: 'Ash'})
```

Need a ajax call authentication
```ruby
module ZombieOutlaws
  class Application < Rails::Application
    config.time_zone = 'Central Time (US & Canada)'
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
```

Add a new flash type
In the controller
```ruby
add_flash_types :groan

redirect_to @zombie, groan: @zombie.groan
```

Show flash on the view
```ruby
<div id='groan'><%= groan %></div>
```

Collection radio button
```ruby
<%= form_for(@limb) do |f| %>
  <div class="field">
    <%= f.label :zombie %><br />
    <%= collection_radio_buttons(:limb, 
                                 :zombie_id, 
                                 @zombies, 
                                 :id, 
                                 :name) %>
  </div>
<% end %>
```
Collection check box button
```ruby
<%= form_for(@zombie) do |f| %>
  <div class="field">
    <%= f.label :limbs %><br />
    <%= collection_check_boxes(:limb, 
                               :id, 
                               @limbs, 
                               :id, 
                               :kind) %> 
  </div>
<% end %>
```

Date Type Input
```ruby
<%= form_for(@limb) do |f| %>
  <div class="field">
    <%= f.label :date_found %><br />
    <%= f.date_field :date_found %>
  </div>
<% end %>
```

JSON
```ruby
limbs_hashes = @limbs.map do |limb|
  { owner_name: limb.zombie.name, kind: limb.kind }
end
# TODO: Output JSON version of limbs_hashes.
limbs_hashes.to_json
```

Skip Test
```ruby
class ZombieTest < ActiveSupport::TestCase
  test "should match number of Items" do
    skip
    zombie = Zombie.new
    zombie.items.new(name: 'revolver')
    zombie.items.new(name: 'noose')
    assert_equal 2, zombie.item_count
  end
end
```

Rake Test
```ruby
rake test:models
```

Rake Test Verbose
```ruby
rake test:models TEST_OPTS="--verbose"
```

Fresh When
```ruby
class MostWantedController < ApplicationController
  def show
    @zombie = Zombie.most_wanted
    fresh_when(@zombie)
  end
end
```
```ruby
class MostWantedController < ApplicationController

  etag { current_user.country }

  def show
    @zombie = Zombie.most_wanted
    fresh_when(@zombie)
  end

  def edit
    @zombie = Zombie.most_wanted
    fresh_when(@zombie)
  end
end
```

Cache
```ruby
<% cache zombie do %>
  <li><%= zombie %></li>
<% end %>
```
```ruby
class Zombie < ActiveRecord::Base
  belongs_to :weapon, touch: true
end
```
```ruby
<% cache @weapon do %>
  <section>
    <h3><%= @weapon.name %></h3>
    <ul>
      <%= render partial: 'zombies/zombie', 
            collection: @weapon.zombies.recent %>
    </ul>
    <%= link_to 'Details', @weapon %>
  </section>
<% end %>
```

Live
```ruby
class SightingsController < ApplicationController

  include ActionController::Live

  def alerts
    response.stream.write "Half-eaten brains found near saloon.\n\n"
    response.stream.write "Chickens disappear from farm.\n\n"
    response.stream.write "Zombie seen by Walker Ranch!\n\n"
    response.stream.close
  end

end
```

EventSource
```ruby
#controller
class SightingsController < ApplicationController

  include ActionController::Live

  def alerts
    response.headers['Content-Type'] = 'text/event-stream'
    response.stream.write "data: Half-eaten brains found near saloon.\n\n"
    response.stream.write "data: Chickens disappear from farm.\n\n"
    response.stream.write "data: Zombie seen by Walker Ranch!\n\n"
    response.stream.close
  end

end
```
```javascript
function initialize() {
  var source = new EventSource('/sightings/alerts');
  source.addEventListener('message', function update(event) {
    var div = $('<div>').text(event.data);
    $('#alerts').append(div);
  });
};
$(document).ready(initialize);
```
```ruby
<div id="alerts">
</div>
```

TurboLink Events
```javascript
function initialize() {
  alert('Welcome, Deputy! Check back often for new zombie sightings!');
}

$(document).ready(initialize);
$(document).on('page:load', initialize);
```

Change a way to add click event
```javacript
$(document).on('click', '#alert_resolved', clickAlert);
```

Show 'loading' when fetching page, under turbolink
```ruby
<!DOCTYPE html>
<html>
<head>
  <title>Zombie Outlaws</title>
  <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>
<body>

<%= yield %>

<div id="loading">Loading...</div>

</body>
</html>
```
```javascript
<!DOCTYPE html>
<html>
<head>
  <title>Zombie Outlaws</title>
  <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>
<body>

<%= yield %>

<div id="loading">Loading...</div>

</body>
</html>
```
```javascript
$(document).on('page:change', hideLoading);
$(document).on('page:fetch', showLoading);
```

Disable turbolink
e.g.1
```ruby
<%= link_to 'Home', welcome_path, "data-no-turbolink" => true %>
```
e.g.2
```ruby
<div id="navigation" <%= link_to 'Home', welcome_path, "data-no-turbolink" => true %>>
  <div><%= link_to 'Zombies', zombies_path %></div>
  <div><%= link_to 'Weapons', weapons_path %></div>
</div>
```

Rails Pattern

```ruby
class UserRegistration
  attr_reader :user
  
  def initialize(params={})
    @user = User.new(params)
    @user.is_approved = true if valid_background_check?
  end
  
  private
  # private methods go here
  def valid_background_check?
    !!(@user.valid_ssn? || @user.valid_address?)
  end
end
```
