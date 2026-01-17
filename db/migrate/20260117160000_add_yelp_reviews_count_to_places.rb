class AddYelpReviewsCountToPlaces < ActiveRecord::Migration[8.0]
  def change
    add_column :places, :yelp_reviews_count, :integer
  end
end
