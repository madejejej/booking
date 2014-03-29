class CreateMovieShows < ActiveRecord::Migration
  def change
    create_table :movie_shows do |t|
      t.integer :movie_id
      t.datetime :date
      t.integer :screen_id

      t.timestamps
    end
  end
end
