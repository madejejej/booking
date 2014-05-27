class AddWidthAndHeightToScreen < ActiveRecord::Migration
  def change
    add_column :screens, :width, :integer
    add_column :screens, :height, :integer
  end
end
