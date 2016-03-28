class AddIndexAdminFieldToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :index_admin, :boolean, default: false, null: false
  end
end
