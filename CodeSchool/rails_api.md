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

### POST(CREATE)

```ruby
class CreatingHumansTest < ActionDispatch::IntegrationTest
  test 'creates human' do
    # code here
    post "/humans", { human: { name: 'John', brain_type: 'small' } }.to_json, { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
    
    assert_equal 201, response.status
  end
end
```

```ruby
class CreatingHumansTest < ActionDispatch::IntegrationTest
  test 'creates human' do
    post '/humans', { human: { name: 'John', brain_type: 'small' } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 201, response.status
    # your code here
    assert_equal Mime::JSON, response.content_type   
    
    human = json(response.body)
    assert_equal human_url(human[:id]), response.location
  end
end
```
```ruby
class HumansController < ApplicationController
  def create
    # your code here
    human = Human.new(human_params)
    
    if human.save
    #send the location url of the new created human instance
      render json: human, status: 201, location: human
    end
  end

  private

  def human_params
    params.require(:human).permit(:name, :brain_type)
  end
end
```

**get ride of FORGERY PROTECTION
```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
end
```

**curl command for post**
```
curl -i -X post -d "human[name]=Ash" http://cs-zombies-dev.com:3000/humans
```

**return an empty content, with a location url**
```ruby
render nothing: true, status: 204, location: human
```

**head-only response**
```ruby
  def create
    human = Human.new(human_params)

    if human.save
      # code here
      head 204, location: human
    end
  end
```

**422 response status**
```ruby
  test 'does not create human with name nil' do
    post '/humans',
      { human:
        { name: nil, brain_type: 'large' }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal Mime::JSON, response.content_type
    assert_equal 422, response.status
  end
```
```ruby
  def create
    human = Human.new(human_params)

    if human.save
      head 204, location: human
    else
      # code here
      render json: human.errors, status: 422
    end
  end
```

**PATCH**
```ruby
class HumansController < ApplicationController
  def update
    human = Human.find(params[:id])

    if human.update(human_params)
      render json: human, status: 200
    else
      render json: human.errors, status: 422
    end
  end

  private

  def human_params
    params.require(:human).permit(:name, :brain_type)
  end
end
```
```ruby
class UpdatingHumansTest < ActionDispatch::IntegrationTest
  setup { @human = Human.create!(name: 'Robert', brain_type: 'small') }

  test 'unsuccessful update on bad name' do
    patch "/humans/#{@human.id}",
      { human: { name: nil } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      
    assert_equal 422, response.status
  end
end
```

**Delete**
```ruby
class DeletingZombiesTest < ActionDispatch::IntegrationTest
  setup { @zombie = Zombie.create!(name: 'Undead Jack', brain_type: 'large') }

  test 'deletes existing zombie' do
    # your code here
    delete "/zombies/#{@zombie.id}"
    
    assert_equal 204, response.status
  end
end
```

```ruby
class ZombiesController < ApplicationController
  def destroy
    zombie = Zombie.find(params[:id])

    # your code here
    zombie.destroy
    head 204
  end
end
```

### Internationalize

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  
  protected
  
  def set_locale
    I18n.locale = request.headers['Accept-Language']
  end
end
```

Jbuilder
```ruby
json.array(@humans) do |human|
  # your code here
  json.extract! human, :id, :name, :brain_type
  json.message I18n.t('human_message', name: human.name)
end
```

```yml
en:
  # your code here
  human_message: "My name is %{name} and I am still alive!"
```

**Header Remote Addr attribute**

`get '/v2/zombies', {}, { 'REMOTE_ADDR' => @ip }`


**Set client ip address**

```ruby
class ApplicationController < ActionController::Base
  before_action -> { @user_ip = request.headers["REMOTE_ADDR"] }
end
```

### Accept Header Version

```ruby
class ListingZombiesTest < ActionDispatch::IntegrationTest
  test 'show zombie from API version 1' do
    get '/zombies/1', {}, { 'Accept' => 'application/vnd.zombies.v1+json' }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal "This is version one", json(response.body)[:message]
  end
end
```
