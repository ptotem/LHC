class HobbyListsUsers < ActiveRecord::Migration
  def change
    create_table :hobby_lists_users do |t|
      t.integer :hobby_list_id
      t.integer :user_id
    end
  end
end
