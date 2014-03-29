class CreateMovieScreenSeats < ActiveRecord::Migration
  def change
    create_table :movie_screen_seats do |t|
      t.integer :screen_id

      t.timestamps
    end
  end
end
