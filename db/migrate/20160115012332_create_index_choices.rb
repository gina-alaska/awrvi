class CreateIndexChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :index_choices do |t|
      t.integer :index_id
      t.integer :choice_id

      t.timestamps
    end
  end
end
