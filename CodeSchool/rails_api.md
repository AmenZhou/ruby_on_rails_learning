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

**curl**

option `-I` to show the header of http reponse

`curl -I http://cs-zombies-dev.com:3000/humans`

### response type

```ruby
class ListingHumansTest < ActionDispatch::IntegrationTest
  test 'returns humans in JSON' do
    get "/humans", { }, { 'Accept' => Mime::JSON }
    
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
```

```ruby
class HumansController < ApplicationController
  def index
    humans = Human.all

    # your code here
    respond_to do |format|
      format.json { render json: humans, status: 200 }
      format.xml { render xml: humans, status: 200 }
    end
  end
end
```

**specify the content type**

`curl -IH "Accept: application/json" http://cs-zombies-dev.com:3000/humans`

