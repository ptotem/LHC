class CreateIceBreakers < ActiveRecord::Migration
  def change
    create_table :ice_breakers do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.timestamps
    end
  end
end
