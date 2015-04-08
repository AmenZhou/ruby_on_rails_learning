### Service-Oriented Design of RoR

##### Service-Oriented Design, Service-Oriented Architechure and RestFul

##### Seprate MVC to different services


### Rails 4 Way

#### Rails load files

1. config/boots.rb
2. config/application.rb
3. config/environment.rb

##### application.rb

1. Auto load path
```
config.autoload_paths += [path]
```
2. Session Store
```
Rails.application.config.session_store :cookie_store, key: "_example_session"
```
3. Wrap parameters
4. Log level override
```
config.log_level = :debug
```
5. Schema dumper
```
config.active_record.schema_format = :sql
```
6. Console
```
console do
  require "pry"
  config.console = Pry
end
```

##### Development

1. Auto Class Reloading
```
config.cache_classes = false

```
2. Rails Classes Load
```
#type it in rails console
$LOAD_PATH
```
3. Eager Load
```
# set true in production to cache all the application in the memory
config.eager_load = false
```
4. Cache
```
#only set it true in production
config.action_controller.perform_caching = false
```
5. Raise delivery Errors
```
config.action_mailer.raise_delivery_errors = false
```

6. Deprecation Notice -- Show Deprecation Warning
7. Pending Migration Error Page -- show error when rails has pending migration
```
config.active_record.migration_error = :page_load
```
8. Assets Debug Mode
```
#css and javascript file serve separate
config.assets.debug = true
```

