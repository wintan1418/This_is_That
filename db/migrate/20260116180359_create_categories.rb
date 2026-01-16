class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :yelp_alias
      t.string :icon

      t.timestamps
    end
  end
end
