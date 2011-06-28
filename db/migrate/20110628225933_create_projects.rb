class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :customer_id
      t.integer :created_by
      t.string :name
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
