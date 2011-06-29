class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.integer :phoneable_id
      t.string :phoneable_type
      t.string :label
      t.string :number

      t.timestamps
    end
  end

  def self.down
    drop_table :phones
  end
end
