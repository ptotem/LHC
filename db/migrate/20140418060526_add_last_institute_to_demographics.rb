class AddLastInstituteToDemographics < ActiveRecord::Migration
  def change
    add_column :demographics, :last_institute, :integer
  end
end
