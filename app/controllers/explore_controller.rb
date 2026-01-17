class ExploreController < ApplicationController
  def index
    @places = Place.includes(:category, :user, :reviews)
                   .where.not(is_home_place: true)
                   .order(created_at: :desc)
                   .limit(30)
  end
end
