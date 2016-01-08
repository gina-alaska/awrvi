class CreateCommunities < ActiveRecord::Migration[5.0]
  def change
    create_table :communities do |t|
      t.string :name
      t.string :gnis_id
      t.string :census_id
      t.text :location

      t.timestamps
    end
  end
end
