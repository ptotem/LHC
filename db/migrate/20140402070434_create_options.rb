class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :name
      t.integer :question_id
      t.boolean :correct
      t.timestamps
    end
  end
end
