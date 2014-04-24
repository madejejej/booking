class RenameReservationSeatsToTickets < ActiveRecord::Migration
  def change
    rename_table :reservation_seats, :tickets
  end
end
