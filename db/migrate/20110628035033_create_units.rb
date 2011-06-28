class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.integer :customer_id
      t.string :name
      t.text :physical_address
      t.text :postal_address
      t.text :phone
      t.boolean :default

      t.timestamps
    end
  end

  def self.down
    drop_table :units
  end
end
