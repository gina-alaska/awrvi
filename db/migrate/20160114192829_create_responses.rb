class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.decimal :awrvi_index, precision: 6, scale: 5
      t.string :awrvi_text
      t.string :raw_value

      t.timestamps
    end
  end
end
