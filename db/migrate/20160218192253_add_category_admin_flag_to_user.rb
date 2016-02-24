class AddCategoryAdminFlagToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :category_admin, :boolean, default: false, null: false
  end
end
