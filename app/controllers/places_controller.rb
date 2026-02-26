class PlacesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_place, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def index
    @places = Place.includes(:category, :user).order(created_at: :desc).limit(20)
  end

  def show
    @reviews = @place.reviews.includes(:user).recent
    @review = Review.new
  end

  def new
    @place = Place.new
    @categories = Category.alphabetical
  end

  def create
    @place = current_user.places.build(place_params)

    if @place.save
      redirect_to @place, notice: "Place was successfully created."
    else
      @categories = Category.alphabetical
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = Category.alphabetical
  end

  def update
    if @place.update(place_params)
      redirect_to @place, notice: "Place was successfully updated."
    else
      @categories = Category.alphabetical
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @place.destroy
    redirect_to my_places_path, notice: "Place was removed."
  end

  # POST /places/:id/save_match
  # Save a matched place from search results
  def save_match
    place_data = params.require(:place).permit(
      :yelp_id, :name, :address, :city, :state, :country,
      :latitude, :longitude, :image_url, :rating, :price,
      :phone, :url, :category_id, :yelp_reviews_count
    )

    @place = current_user.places.build(place_data)
    @place.is_home_place = false
    @yelp_id = place_data[:yelp_id]

    if @place.save
      respond_to do |format|
        format.html { redirect_to @place, notice: "Place saved to your matches!" }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "save_button_#{@yelp_id}",
            partial: "places/saved_button",
            locals: { place: @place }
          )
        }
      end
    else
      respond_to do |format|
        format.html { redirect_back fallback_location: search_path, alert: "Could not save place." }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "save_button_#{@yelp_id}",
            html: %(<turbo-frame id="save_button_#{@yelp_id}"><span class="px-3 py-1.5 text-sm text-red-400">Failed to save</span></turbo-frame>).html_safe
          )
        }
      end
    end
  end

  def toggle_favorite
    @place = current_user.places.find(params[:id])
    @place.update(is_favorite: !@place.is_favorite)

    respond_to do |format|
      format.html { redirect_back fallback_location: @place }
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "favorite_button_#{@place.id}",
          partial: "places/favorite_button",
          locals: { place: @place }
        )
      }
    end
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def authorize_user!
    unless @place.user == current_user
      redirect_to places_path, alert: "You are not authorized to perform this action."
    end
  end

  def place_params
    params.require(:place).permit(
      :name, :address, :city, :state, :country, :latitude, :longitude,
      :image_url, :rating, :price, :phone, :url, :yelp_id,
      :is_home_place, :category_id, :image
    )
  end
end
