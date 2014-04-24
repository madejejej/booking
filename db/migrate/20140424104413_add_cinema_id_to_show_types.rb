class AddCinemaIdToShowTypes < ActiveRecord::Migration
  def change
    add_column :show_types, :cinema_id, :integer
  end
end
