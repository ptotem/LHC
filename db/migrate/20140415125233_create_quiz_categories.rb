class CreateQuizCategories < ActiveRecord::Migration
  def change
    create_table :quiz_categories do |t|
      t.string :name
      t.text :intro
      t.boolean :status

      t.timestamps
    end
  end
end
