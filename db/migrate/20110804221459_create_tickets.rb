class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :unit_id
      t.integer :requested_by_id
      t.string :requested_by_name
      t.integer :assigned_to_id
      t.text :description
      t.string :state

      t.timestamps
    end
  end
end
