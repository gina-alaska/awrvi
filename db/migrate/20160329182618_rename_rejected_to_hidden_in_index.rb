class RenameRejectedToHiddenInIndex < ActiveRecord::Migration[5.0]
  def change
    rename_column :indices, :rejected_at, :hidden_at
    rename_column :indices, :rejected_reason, :hidden_reason
    add_column :indices, :hidden, :boolean, default: false, null: false
  end
end
