class AddColumnCountryToDemographics < ActiveRecord::Migration
  def change
    add_column :demographics, :country, :string
  end
end
