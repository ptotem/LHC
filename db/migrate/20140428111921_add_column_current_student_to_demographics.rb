class AddColumnCurrentStudentToDemographics < ActiveRecord::Migration
  def change
    add_column :demographics, :current_student, :boolean ,:default => false
  end
end
