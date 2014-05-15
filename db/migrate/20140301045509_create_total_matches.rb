class CreateTotalMatches < ActiveRecord::Migration
  def change
    create_table :total_matches do |t|
      t.integer :user_id
      t.integer :target_id
      t.integer :total_fit

      t.timestamps
    end
  end
end
