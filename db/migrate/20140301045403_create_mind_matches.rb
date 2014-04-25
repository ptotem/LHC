class CreateMindMatches < ActiveRecord::Migration
  def change
    create_table :mind_matches do |t|
      t.integer :user_id
      t.integer :target_id
      t.integer :question_id
      t.integer :valuediff
      t.boolean :mind_fit

      t.timestamps
    end
  end
end
