class CreateTicketTypes < ActiveRecord::Migration
  def change
    create_table :ticket_types do |t|
      t.string :type
      t.integer :price_in_eurocents
      t.integer :show_type_id

      t.timestamps
    end

    add_column :tickets, :ticket_type_id, :integer
  end
end
