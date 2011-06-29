class AddStaffToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :staff, :boolean
  end

  def self.down
    remove_column :users, :staff
  end
end
