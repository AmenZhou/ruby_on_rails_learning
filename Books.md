### Service-Oriented Design of RoR

##### Service-Oriented Design, Service-Oriented Architechure and RestFul

##### Seprate MVC to different services


### Rails 4 Way

#### Rails load files

1. config/boots.rb
2. config/application.rb
3. config/environment.rb

##### application.rb

Auto load path
```
config.autoload_paths += [path]
```
Session Store
```
Rails.application.config.session_store :cookie_store, key: "_example_session"
```
Wrap parameters
Log level override
```
config.log_level = :debug
```
Schema dumper
```
config.active_record.schema_format = :sql
```
Console
```
console do
  require "pry"
  config.console = Pry
end
```

##### Development

Auto Class Reloading
```
config.cache_classes = false

```
Rails Classes Load
```
#type it in rails console
$LOAD_PATH
```
Eager Load
```
# set true in production to cache all the application in the memory
config.eager_load = false
```
Cache
```
#only set it true in production
config.action_controller.perform_caching = false
```
Raise delivery Errors
```
config.action_mailer.raise_delivery_errors = false
```

Deprecation Notice -- Show Deprecation Warning
Pending Migration Error Page -- show error when rails has pending migration
```
config.active_record.migration_error = :page_load
```
Assets Debug Mode
```
#css and javascript file serve separate
config.assets.debug = true
```

##### Assets

Javascript and style sheets are the only files can be compile in assets folder

```
#To add more sources
config.assets.precompile += %w(XXX)
```

Assets Host -- Set assets to another host
```
config.action_controller.asset_host
```

##### Log

```
#log clear
rake log:clear
```

Taged Logging
```
#add tags to log info
config.log_tags
```
##### routes

1. Routing Globbing

   ```
   #routes.rb
   get "items/q/*specs", controller: :items, action: :query
   #items_controller.rb
   Item.where(Hash[*params[:specs].split("/")])
   ```
2. response_with
   ```ruby
   class controller
     repsond_to :xml
   
     def index
       @auctions = Auction.all
       respond_with(@auctions)
     end
  end
  ```
  
  
##### ActiveRecord

1. attribute_read and write
   ```ruby
   class Specification < ActiveRecord::Base
     def tolerance
       self[:tolerance] || 'n/a'
     end
     
     def tolerance=(txt)
       self[:tolerance] = txt + 'in bed'
     end
   end
   ```
   
2. Serialize
   ```
   serialize :performance, Hash
   ```
   
3. Readonly attributes
   ```
   attr_readonly :social_security_number
   ```

4. Delete and Destroy
   ```
   delete -- pure SQL 
   
   destroy -- load instance and then delete
   ```

##### ActiveAssociation

1. << and create
  ```
    product.sizes << small_size #return association proxy
    product.sizes.create #return product object
  ```
2. any?, many? and empty?

3. delete and delete_all are only served to clean association, foreign key. Diffrerent from destroy

4. reload
  ```
   user(true).name #reload user and return a different object id
  ```
5. has_many -- after_add, before_add, before_remove callbacks

##### Validate

1. validates_confirmation_of

2. validates_acceptance_of

3. validates_inclusion_of

4. validates_exclustion_of 

##### Helpers

1. form helpers
   
   1. error_message_on

   2. error_message_for
   
   

=========================================================

### Metaprogramming Ruby

##### block

1. Scope Gate
    
    1. Class defininations
    2. Module definiations
    3. Methods

2. Flat Scope & Shared Scope

3. instance_eval & instance_exec & Clean Room

4. Turn a method to an object(Method or UnboundMethod)

5. Turn a block to an object(Proc)

6. Block & Proc & Lambdas & Plain old methods

7. DSL

##### Class Definition

1. class_eval
2. class instance variable
   instance variable is only belongs to the current self

   ```ruby
   class MyClass
     @time = 2 #class instance variable
     
     def time_read
       @time #object of class instance variable
     end
     
     def time_write
       @time = 3 #object of class instance variable
     end
     
     def self.time_read
       @time #class instance variable
     end
   end
   ```

3. define an anonymous class and assign a name to it
   ```ruby
   c = Class.new(superclass of this class)

   #assign an constant name to this class
   MyClass = c
   
   MyClass.new #=> []
   ```

4. duck typing
   ```
   if it walks like a duck, quacks like a duck, then it must be a duck
   ```
5. singleten class hierarchy
   ![singleten class hirarchy](https://cloud.githubusercontent.com/assets/6025823/8210556/9e15e97c-14e0-11e5-82af-ed864c61285f.png)
   
   ![singleten class hirarchy](https://cloud.githubusercontent.com/assets/6025823/8210554/9be98fe6-14e0-11e5-8265-753489645573.png)

6. Around Alias

   ![around alias](https://cloud.githubusercontent.com/assets/6025823/8237973/e678d9d2-15c0-11e5-88dc-1b6a00a8c9ec.png)

   1. alias a method
   2. redefine the old method
   3. call new method inside the old method
