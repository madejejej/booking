class AddOrganiserDataIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :organiser_data_id, :integer
  end
end
