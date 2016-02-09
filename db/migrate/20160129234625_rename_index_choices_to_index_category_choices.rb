class RenameIndexChoicesToIndexCategoryChoices < ActiveRecord::Migration[5.0]
  def change
    rename_table :index_choices, :index_category_choices
    add_reference :index_category_choices, :category, index: true, foreign_key: true
  end
end
