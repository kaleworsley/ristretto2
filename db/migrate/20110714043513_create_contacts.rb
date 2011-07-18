class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :unit_id
      t.integer :user_id
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
