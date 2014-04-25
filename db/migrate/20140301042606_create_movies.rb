class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :poster
      t.text :description
      t.date :release_date

      t.timestamps
    end
  end
end
