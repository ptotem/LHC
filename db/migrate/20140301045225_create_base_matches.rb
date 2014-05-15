class CreateBaseMatches < ActiveRecord::Migration
  def change
    create_table :base_matches do |t|
      t.integer :user_id
      t.integer :target_id
      t.boolean :gender_fit
      t.boolean :age_fit
      t.boolean :smoking_fit
      t.boolean :drinking_fit

      t.timestamps
    end
  end
end
