class CreateIndex < ActiveRecord::Migration[5.0]
  def change
    create_table :indices do |t|
      t.datetime :finalized_at
      t.references :awrvi_version, index: true
      t.decimal :awrvi_index, precision: 6, scale: 5
      t.datetime :rejected_at
      t.text :rejected_reason
    end
    add_foreign_key :indices, :categories, column: :awrvi_version_id
  end
end
