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

  def upvote
    @review = @place.reviews.find(params[:id])
    vote(@review, 1)
  end

  def downvote
    @review = @place.reviews.find(params[:id])
    vote(@review, -1)
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end

  def vote(review, value)
    existing_vote = review.votes.find_by(user: current_user)
    
    if existing_vote
      if existing_vote.value == value
        # Toggle off - remove vote
        existing_vote.destroy
      else
        # Change vote direction
        existing_vote.update(value: value)
      end
    else
      # New vote
      review.votes.create(user: current_user, value: value)
    end

    respond_to do |format|
      format.html { redirect_to @place }
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "review_votes_#{review.id}",
          partial: "reviews/vote_buttons",
          locals: { review: review, place: @place }
        )
      }
    end
  end
end
