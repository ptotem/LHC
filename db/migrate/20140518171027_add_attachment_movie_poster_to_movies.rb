class AddAttachmentMoviePosterToMovies < ActiveRecord::Migration
  def self.up
    change_table :movies do |t|
      t.attachment :movie_poster
    end
  end

  def self.down
    drop_attached_file :movies, :movie_poster
  end
end
