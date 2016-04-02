class RemoveAwrviIndexFromIndices < ActiveRecord::Migration[5.0]
  def change
    remove_column :indices, :awrvi_index
  end
end
