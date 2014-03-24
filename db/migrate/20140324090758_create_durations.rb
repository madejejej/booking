class CreateDurations < ActiveRecord::Migration
  def change
    create_table :durations do |t|
      t.integer :seconds
      t.references :movie, index: true

      t.timestamps
    end
  end
end
