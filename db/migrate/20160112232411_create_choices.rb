class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.references :category, index: true, foreign_key: true
      t.decimal :index, precision: 6, scale: 5
      t.text :description

      t.timestamps
    end
  end
end
