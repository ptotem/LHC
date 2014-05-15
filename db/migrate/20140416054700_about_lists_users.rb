class AboutListsUsers < ActiveRecord::Migration
  def change
    create_table :about_lists_users do |t|
      t.integer :about_list_id
      t.integer :user_id
    end
  end
end
