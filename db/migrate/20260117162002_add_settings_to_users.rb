class AddSettingsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :email_notifications, :boolean, default: true
    add_column :users, :theme, :string, default: 'dark'
  end
end
