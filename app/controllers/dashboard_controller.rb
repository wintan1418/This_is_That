class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @home_places = current_user.home_places.includes(:category).limit(6)
    @matched_places = current_user.matched_places.includes(:category).limit(6)
    @recent_reviews = current_user.reviews.includes(:place).recent.limit(5)
    
    # For "View All" visibility
    @total_home_places = current_user.home_places.count
    @total_matched_places = current_user.matched_places.count
  end

  def my_places
    @home_places = current_user.home_places.includes(:category, :reviews)
  end

  def my_matches
    @matched_places = current_user.matched_places.includes(:category, :reviews)
  end

  def favorites
    @favorite_places = current_user.places.favorites.includes(:category, :reviews)
  end
end
