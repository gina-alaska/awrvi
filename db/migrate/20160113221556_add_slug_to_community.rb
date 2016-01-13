class AddSlugToCommunity < ActiveRecord::Migration[5.0]
  def change
    add_column :communities, :slug, :string
  end
end
