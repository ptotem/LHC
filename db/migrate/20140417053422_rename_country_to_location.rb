class RenameCountryToLocation < ActiveRecord::Migration
  def change
    rename_column :demographics, :country, :location
  end
end
