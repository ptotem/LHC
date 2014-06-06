class CreateQuizResults < ActiveRecord::Migration
  def change
    create_table :quiz_results do |t|
      t.string :name
      t.integer :min_value
      t.integer :max_value
      t.integer :quiz_id

      t.timestamps
    end
  end
end
