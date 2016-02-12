class DisableNullOnIndexAwrviVersionRelation < ActiveRecord::Migration[5.0]
  def change
    change_column :indices, :awrvi_version_id, :integer, null: false
  end
end
