class AddMovieApiidToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :movie_api_id, :integer
  end
end
