class AddColumnIceStatusToIceBreakers < ActiveRecord::Migration
  def change
    add_column :ice_breakers, :ice_status, :boolean , :default => false
  end
end
