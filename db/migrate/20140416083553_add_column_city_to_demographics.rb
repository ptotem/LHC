class AddColumnCityToDemographics < ActiveRecord::Migration
  def change
    add_column :demographics, :city, :string
  end
end
