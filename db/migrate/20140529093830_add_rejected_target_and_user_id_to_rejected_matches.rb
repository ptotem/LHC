class AddRejectedTargetAndUserIdToRejectedMatches < ActiveRecord::Migration
  def change
    add_column :rejected_matches, :rejected_target, :integer
    add_column :rejected_matches, :user_id, :integer
  end
end
