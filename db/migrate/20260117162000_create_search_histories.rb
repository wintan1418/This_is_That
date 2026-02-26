class CreateSearchHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :search_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :home_city
      t.string :new_city
      t.string :category
      t.string :query

      t.timestamps
    end

    add_index :search_histories, [ :user_id, :created_at ]
  end
end
