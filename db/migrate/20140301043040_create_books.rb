class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :cover
      t.string :author
      t.text :synopsis
      t.date :release_date

      t.timestamps
    end
  end
end
