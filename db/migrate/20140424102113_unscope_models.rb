class UnscopeModels < ActiveRecord::Migration
  def change
    rename_table :movie_screen_seats, :seats
    rename_table :movie_screens, :screens
    rename_table :movie_shows, :shows
  end
end
