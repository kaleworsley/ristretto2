class RemoveNameFromCustomer < ActiveRecord::Migration
  def self.up
    remove_column :customers, :name
  end

  def self.down
    add_column :customers, :name, :string
  end
end
