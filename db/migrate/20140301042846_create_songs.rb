class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :album
      t.string :band
      t.text :lyrics
      t.date :release_date

      t.timestamps
    end
  end
end
