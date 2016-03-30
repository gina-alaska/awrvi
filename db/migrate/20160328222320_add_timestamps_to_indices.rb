class AddTimestampsToIndices < ActiveRecord::Migration[5.0]
  def change
    add_column :indices, :created_at, :datetime
    add_column :indices, :updated_at, :datetime
  end
end
