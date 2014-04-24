class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :booker
      t.integer :user_id
      t.integer :show_id
      t.timestamps
    end
  end
end
