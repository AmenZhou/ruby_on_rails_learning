###stripe

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
