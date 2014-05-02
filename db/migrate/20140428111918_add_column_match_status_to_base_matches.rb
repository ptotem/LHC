class AddColumnMatchStatusToBaseMatches < ActiveRecord::Migration
  def change
    add_column :base_matches, :match_status, :boolean
  end
end
