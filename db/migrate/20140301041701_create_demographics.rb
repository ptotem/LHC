class CreateDemographics < ActiveRecord::Migration
  def change
    create_table :demographics do |t|
      t.integer :user_id
      t.string :name
      t.boolean :male
      t.string :religion
      t.date :dob
      t.string :smoking
      t.string :drinking
      t.text :description
      t.text :goal
      t.integer :diffthresh

      t.timestamps
    end
  end
end
