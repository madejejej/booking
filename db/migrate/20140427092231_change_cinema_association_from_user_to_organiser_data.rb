class ChangeCinemaAssociationFromUserToOrganiserData < ActiveRecord::Migration
  def change
    add_column :cinemas, :organiser_data_id, :integer
  end
end
