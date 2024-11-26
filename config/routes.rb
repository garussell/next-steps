Rails.application.routes.draw do
  root to: 'welcome#index'

  # Register and Login
  namespace :register do
    resources :providers, only: [:new, :create, :edit, :update]
  end

  delete '/register/providers/:id', to: 'register/providers#destroy', as: :delete_provider

  namespace :admin do
    resources :dashboard, only: [:index] do
      member do
        patch 'approve'
        patch 'reject'
      end
    end
  end

  #OAuth
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'

  # Search
  resources :search_results, only: [:index, :show]
  
  # Providers
  resources :providers, only: [:show]

  # User features
  get "/users/login", to: "users#login_form"

  post "/users/login", to: "sessions#new"
  get "/logout", to: "sessions#logout", as: "users_logout"

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :favorites, only: [:index, :create, :destroy]
    member do 
      get 'generate_pdf'
    end
  end

  # BE Routes
  namespace :api do
    namespace :v0 do
      resources :search, only: [:index]
      resources :provider_details, only: [:show]
      resources :providers, only: [:new, :create, :show, :update, :destroy]
    end
  end
end
