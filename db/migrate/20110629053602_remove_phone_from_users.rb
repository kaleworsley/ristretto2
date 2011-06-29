class RemovePhoneFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :phone
  end

  def self.down
    add_column :users, :phone, :text
  end
end
