class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :name
      t.integer :ice_breaker_id
      t.timestamps
    end
  end
end
