Rails.application.routes.draw do
  resources :products
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  get "/profile/:id", to: "users#profile"
  post "/profile", to: "users#profile_update"
  get "/password/:id", to: "users#password"
  post "/change_password", to: "users#changes_password"
  
end
