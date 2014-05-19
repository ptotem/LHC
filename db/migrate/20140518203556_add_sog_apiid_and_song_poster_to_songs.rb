class AddSogApiidAndSongPosterToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :song_api_id, :integer
    add_column :songs, :song_poster, :string
  end
end
