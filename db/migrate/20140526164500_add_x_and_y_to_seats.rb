class AddXAndYToSeats < ActiveRecord::Migration
  def change
    add_column :seats, :x, :integer
    add_column :seats, :y, :integer
  end
end
