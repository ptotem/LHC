class RemoveCityFromDemographic < ActiveRecord::Migration
  def change
    remove_column :demographics, :city, :string
  end
end
