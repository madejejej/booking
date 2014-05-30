class RenameCoverUrlToCover < ActiveRecord::Migration
  def change
    rename_column :movies, :cover_url, :cover
  end
end
