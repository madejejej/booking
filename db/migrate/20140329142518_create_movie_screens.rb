class CreateMovieScreens < ActiveRecord::Migration
  def change
    create_table :movie_screens do |t|
      t.string :name

      t.timestamps
    end
  end
end
