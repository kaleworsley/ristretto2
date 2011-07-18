class RemoveDefaultFromUnit < ActiveRecord::Migration
  def self.up
    remove_column :units, :default
  end

  def self.down
    add_column :units, :default, :boolean
  end
end
