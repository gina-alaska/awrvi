class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.integer :order, default: 0
      t.string :name

      t.timestamps
    end
  end
end
