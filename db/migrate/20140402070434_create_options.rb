class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :name
      t.integer :quest_id
      t.timestamps
    end
  end
end
