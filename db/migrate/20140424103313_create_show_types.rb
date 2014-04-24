class CreateShowTypes < ActiveRecord::Migration
  def change
    create_table :show_types do |t|
      t.string :name
      t.timestamps
    end

    add_column :shows, :show_type_id, :integer
  end
end
