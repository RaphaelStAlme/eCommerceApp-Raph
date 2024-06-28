Rails.application.routes.draw do
  # Sessions
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  # Users
  get  '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/profile', to: 'users#show'
  post '/upgrade_to_seller', to: 'users#upgrade_to_seller'


  # Products
  resources :products

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "products#index"
end
