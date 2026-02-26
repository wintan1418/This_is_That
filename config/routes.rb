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
    resources :reviews, only: [ :create, :destroy ] do
      member do
        post :upvote
        post :downvote
      end
    end
    member do
      post :save_match  # Save a matched place
      post :toggle_favorite  # Toggle favorite status
    end
  end

  # Search / Matching
  get "search", to: "search#index"
  get "search/find_matches", to: redirect("/search")  # Handle refresh on results page
  post "search/find_matches", to: "search#find_matches"

  # User dashboard
  get "dashboard", to: "dashboard#index"
  get "my_places", to: "dashboard#my_places"
  get "my_matches", to: "dashboard#my_matches"
  get "favorites", to: "dashboard#favorites"

  # Settings
  get "settings", to: "settings#profile"
  patch "settings", to: "settings#update"
  delete "settings/account", to: "settings#destroy_account"

  # Explore (public places)
  get "explore", to: "explore#index"

  # Notifications
  resources :notifications, only: [ :index ] do
    member do
      post :mark_as_read
    end
    collection do
      post :mark_all_as_read
    end
  end
end
