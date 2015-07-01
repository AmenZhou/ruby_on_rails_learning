### Resources

with_options
```ruby
with_options only: :index do |list_only|
  list_only.resources :zombies
  list_only.resources :humans
  list_only.resources :medical_kits
  list_only.resources :broadcasts
end
```

constraints and namespace
```ruby
namespace :api, path: "/", constraints: { subdomain: "api" } do 
  resources :zombies
  resources :humans
end
```

### test

```ruby
class ListingHumansTest < ActionDispatch::IntegrationTest
  # setup code here
  setup { host! "api.example.com" }
  test 'returns a list of humans' do
    # test code here
    get "/humans"
    assert_equal 200, response.status
    refute_empty response.body
  end
end
```


**show**
```ruby
class ListingHumansTest < ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }

  test 'returns human by id' do
      
    human = Human.create!(name: 'Ash')
    get "/humans/#{human.id}"
    assert_equal 200, response.status
    
    human_response = json(response.body)
    assert_equal human.name, human_response[:name]
  end
end
```

```ruby
module API
  class HumansController < ApplicationController
    def show
      # code here
      human = Human.find(params[:id])
      
      render json: human, status: :ok
    end
  end
end
```
