class AddColumnUserIdToProfessions < ActiveRecord::Migration
  def change
    add_column :professions, :user_id, :integer
  end
end
