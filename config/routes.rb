Rails.application.routes.draw do
  root to: 'welcome#index'

  # Register and Login
  namespace :register do
    # get '/user', to: 'users#new'
    get '/provider', to: 'providers#new'
  end
  # get '/signin', to: 'session#new'

  #OAuth
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'

  # Search
  resources :search_results, only: [:index, :show]
  
  # Providers
  resources :providers, only: [:show]

  # User features
  get "/users/login", to: "users#login_form"
  
  post "/users/login", to: "users#login"
  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  get "/logout", to: "users#logout", as: "users_logout"
  resources :users, only: [:index, :show, :new, :create]
  
end
