class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :message
      t.string :notification_type, default: 'info'
      t.string :link
      t.boolean :read, default: false
      t.timestamps
    end

    add_index :notifications, [ :user_id, :read ]
    add_index :notifications, :created_at
  end
end
