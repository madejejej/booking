class CreateReservationSeats < ActiveRecord::Migration
  def change
    create_table :reservation_seats do |t|
      t.integer :reservation_id
      t.integer :seat_id
      t.timestamps
    end
  end
end
