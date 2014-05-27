class AddFirstVisitToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_visit, :boolean, :default => false
  end
end
