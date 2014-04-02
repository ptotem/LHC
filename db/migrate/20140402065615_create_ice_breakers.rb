class CreateIceBreakers < ActiveRecord::Migration
  def change
    create_table :ice_breakers do |t|

      t.timestamps
    end
  end
end
