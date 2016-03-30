class RenameIndexFinalizeToIndexPublish < ActiveRecord::Migration[5.0]
  def change
    rename_column :indices, :finalized_at, :published_at
  end
end
