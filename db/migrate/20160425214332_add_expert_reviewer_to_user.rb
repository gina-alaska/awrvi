class AddExpertReviewerToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :expert_reviewer, :boolean, default: false, null: false
  end
end
