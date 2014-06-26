class AddColumnGenderAndInstituteNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :boolean
    add_column :users, :institute_name, :string
  end
end
