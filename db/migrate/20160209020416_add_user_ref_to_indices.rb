class AddUserRefToIndices < ActiveRecord::Migration[5.0]
  def change
    add_reference :indices, :user, index: true, foreign_key: true
  end
end
