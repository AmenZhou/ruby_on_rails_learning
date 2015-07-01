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
