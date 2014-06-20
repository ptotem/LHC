class AddColumnInstutitionalMailToUser < ActiveRecord::Migration
  def change
    add_column :users, :institutional_mail, :string
  end
end
