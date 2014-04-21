class AddColumnCurrentRouteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_route, :string ,:default => "/fill_dob"
  end
end
