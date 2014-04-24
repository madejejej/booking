class CreateCinemas < ActiveRecord::Migration
  def change
    create_table :cinemas do |t|
      t.string :name
      t.string :location
      t.string :phone

      t.timestamps
    end

    add_column :screens, :cinema_id, :integer
  end
end
