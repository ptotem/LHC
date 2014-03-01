class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :rating_scale_id
      t.text :revelation_style
      t.text :expectation_style

      t.timestamps
    end
  end
end
