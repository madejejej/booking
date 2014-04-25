class RenameTicketTypeTypeToName < ActiveRecord::Migration
  def change
    change_table :ticket_types do |t|
      t.rename :type, :name
    end
  end
end
