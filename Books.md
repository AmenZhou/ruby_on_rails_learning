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
