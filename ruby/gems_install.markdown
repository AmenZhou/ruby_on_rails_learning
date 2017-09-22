### stripe

example: http://www.sitepoint.com/payments-in-rails-with-stripe/

https://stripe.com/docs/checkout/guides/rails

========================================

##### ActiveAdmin + Delayed Job
Active Admin is an upgraded Rails Admin, good for user interaction

Add Page for Delay Job management
https://gist.github.com/balauru/5706272

================================================

### Byebug Stop Only Once Problem


`gem 'byebug', github: 'deivid-rodriguez/byebug', branch: 'master'`


==========================================

### Minimagik Error

Error Message
```
ImageFailed to manipulate with MiniMagick, maybe it is not an image? Original Error: executable not found: "identify"
```

Resolve
`sudo apt-get install imagemagick`

====================================================

### Carrierwave + S3/Google Storage

```ruby
######S3
if Rails.env.test? or Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
  end
else
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV['S3_ACCESS_KEY'],                        # required
      aws_secret_access_key: ENV['S3_SECRET_KEY'],
      #region:                'US Standard',                  # optional, defaults to 'us-east-1'
      #host:                  's3.example.com',             # optional, defaults to nil
      #endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory  = 'sales-assistant'                          # required
    #config.fog_public     = false                                        # optional, defaults to true
    #config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
  end
end
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

##### Google Storage
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider                         => 'Google',
      :google_storage_access_key_id     => ENV['GOOGLE_STORAGE_PUBLIC_KEY'],
      :google_storage_secret_access_key => ENV['GOOGLE_STORAGE_SECRET_KEY'],
    }
    config.fog_directory = 'sa_storage'
  end
```

Gemfile

```ruby
gem "fog", "~> 1.20"
gem "fog-aws"
```

======================================

### Memcached

Store Session

```ruby
gem 'dalli'

config.cache_store = :mem_cache_store
```
====================================

### Active Record Session Store

Store sessions on database
```ruby
gem 'activerecord-session_store'
```

=======================================

### lib8 gem install on mac

```
gem install libv8 -v '3.11.8.17' -- --with-system-v8  
```

========================================

### HTML Editor -- Tinymce

https://github.com/spohlenz/tinymce-rails

==========================================

### Use Local Gem

https://coderwall.com/p/tqdrhq/work-against-local-gems-without-modifying-your-gemfile

`bundle config local.GEM_NAME /path/to/local/repo`

`bundle config`

`bundle config --delete local.GEM_NAME`

=

### Rmagick gem install at Mac

`C_INCLUDE_PATH=/usr/local/Cellar/imagemagick/6.9.1-1/include/ImageMagick-6/wand/MagickWand.h gem install rmagick`

---

### Mac install nikogori

if you've installed a bunch of different versions of Xcode, 
and unfortunately get such error message when you try to install nokogiri

```
checking if the C compiler accepts ... *** extconf.rb failed ***
Could not create Makefile due to some reason, probably lack of
necessary libraries and/or headers.  Check the mkmf.log file for more
details.  You may need configuration options.
```

Please run this command in your bash, select yes/accept if any windows pop up.

`xcode-select --install`


---

### Mac install eventmachine 


Get any errors when compling the source files, please run

`brew link openssl --force`

----

### Avoid using bundle exec

`gem install rubygems-bundler`

`gem regenerate_binstubs`
