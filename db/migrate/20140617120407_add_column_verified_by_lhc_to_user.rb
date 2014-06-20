class AddColumnVerifiedByLhcToUser < ActiveRecord::Migration
  def change
    add_column :users, :verified_by_lhc, :boolean
  end
end
