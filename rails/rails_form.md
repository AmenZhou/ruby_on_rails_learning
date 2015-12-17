### Form Nested Attributes Builder

*Model*
```ruby
  class User
    attr_accessor :name, :address_attributes, :phones_attributes
  end
  
  class Address
    attr_accessor :first, :second, :city, :state, :zipcode
  end
  
  class Phone
    attr_accessor :area_code, :county_code, :phone_number, :extension
  end
```

*Controller*
```ruby
  @user = User.new  
  @user.phones = [Phone.new(country_code: "+1"), Phone.new]
```

*Views*
```ruby
  form_for @user do |f|
    f.text_field :name
    f.fields_for :address do |address_field|
      address_field :first
      ...
    end
    # generate two phone fields
    f.fields_for :phones do |phone_field|
      phone_field :area_code
      ...
    end
  end
```
