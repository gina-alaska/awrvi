class ChangeCommunityIdOnIndex < ActiveRecord::Migration[5.0]
  def change
    change_column :indices, :community_id, :integer, null: false
  end
end
