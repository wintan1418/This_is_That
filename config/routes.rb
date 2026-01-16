Rails.application.routes.draw do
  # Devise routes with OmniAuth callbacks
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Main application routes
  root "pages#home"

  # Pages
  get "about", to: "pages#about"

  # Places
  resources :places do
    resources :reviews, only: [:create, :destroy]
    member do
      post :save_match  # Save a matched place
    end
  end

  # Search / Matching
  get "search", to: "search#index"
  post "search/find_matches", to: "search#find_matches"

  # User dashboard
  get "dashboard", to: "dashboard#index"
  get "my_places", to: "dashboard#my_places"
  get "my_matches", to: "dashboard#my_matches"
end
