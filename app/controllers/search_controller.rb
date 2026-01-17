class SearchController < ApplicationController
  # Require login for all search actions
  before_action :authenticate_user!

  def index
    @categories = Category.alphabetical
    @recent_searches = current_user.search_histories.recent.limit(5)
  end

  # POST /search/find_matches
  # Find matching places in a new city
  def find_matches
    @query = params[:query]
    @home_city = params[:home_city]
    @new_city = params[:new_city]
    @category = params[:category]
    @categories = Category.alphabetical
    
    # Save to search history
    current_user.search_histories.create(
      home_city: @home_city,
      new_city: @new_city,
      category: @category,
      query: @query
    )
    
    # Resolve the category object for saving matches
    @selected_category = if @category.present?
      Category.find_by(yelp_alias: @category)
    else
      # If no specific category selected (text search), try to find by name or default to first
      Category.find_by("LOWER(name) LIKE ?", "%#{@query.to_s.downcase}%") || Category.first
    end

    service = YelpSearchService.new
    
    # First, search for places in home city
    @home_results = service.search(
      query: @category.present? ? @category : @query,
      location: @home_city
    )

    # Then, search for similar places in new city
    @match_results = service.search(
      query: @category.present? ? @category : @query,
      location: @new_city
    )

    # Always render HTML, disable turbo_stream for simplicity
    render :find_matches, formats: [:html]
  end
end
