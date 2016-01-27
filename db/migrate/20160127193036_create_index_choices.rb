class CreateIndexChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :index_choices do |t|
      t.references :index, index: true, foreign_key: true
      t.references :choice, index: true, foreign_key: true

      t.timestamps
    end
  end
end
