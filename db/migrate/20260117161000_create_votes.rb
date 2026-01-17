class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true
      t.integer :value, null: false # 1 for upvote, -1 for downvote

      t.timestamps
    end

    # Each user can only vote once per review
    add_index :votes, [:user_id, :review_id], unique: true
  end
end
