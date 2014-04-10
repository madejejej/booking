class CreateOrganiserData < ActiveRecord::Migration
  def change
    create_table :organiser_data do |t|
      t.string :name
      t.text :description
      t.string :nip

      t.timestamps
    end
  end
end
