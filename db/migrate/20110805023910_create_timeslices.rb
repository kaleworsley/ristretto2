class CreateTimeslices < ActiveRecord::Migration
  def change
    create_table :timeslices do |t|
      t.integer :timetrackable_id
      t.string :timetrackable_type
      t.integer :created_by_id
      t.text :description
      t.datetime :started
      t.datetime :finished

      t.timestamps
    end
  end
end

