class AddAdminUsersBoolanToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin_users, :boolean, default: false, null: false
  end
end
