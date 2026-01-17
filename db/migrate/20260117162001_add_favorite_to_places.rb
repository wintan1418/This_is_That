class AddFavoriteToPlaces < ActiveRecord::Migration[8.0]
  def change
    add_column :places, :is_favorite, :boolean, default: false
  end
end
