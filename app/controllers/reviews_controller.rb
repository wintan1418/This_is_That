class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_place

  def create
    @review = @place.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @place, notice: "Review added successfully."
    else
      redirect_to @place, alert: @review.errors.full_messages.join(", ")
    end
  end

  def destroy
    @review = @place.reviews.find(params[:id])
    
    if @review.user == current_user
      @review.destroy
      redirect_to @place, notice: "Review removed."
    else
      redirect_to @place, alert: "You can only delete your own reviews."
    end
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
