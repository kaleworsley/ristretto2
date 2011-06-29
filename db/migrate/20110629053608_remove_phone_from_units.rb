class RemovePhoneFromUnits < ActiveRecord::Migration
  def self.up
    remove_column :units, :phone
  end

  def self.down
    add_column :units, :phone, :text
  end
end
