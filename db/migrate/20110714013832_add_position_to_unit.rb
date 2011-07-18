class AddPositionToUnit < ActiveRecord::Migration
  def self.up
    add_column :units, :position, :decimal
  end

  def self.down
    remove_column :units, :position
  end
end
