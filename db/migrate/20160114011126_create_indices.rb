class CreateIndices < ActiveRecord::Migration[5.0]
  def change
    create_table :indices do |t|
      t.datetime :finalized_at
      t.integer :category_id
      t.decimal :awrvi_index, precision: 6, scale: 5
      t.datetime :rejected_at
      t.text :rejected_reason

      t.timestamps
    end
  end
end
