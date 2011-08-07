class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.string :name
      t.string :state
      t.decimal :time_estimate
      t.integer :assigned_to_id
      t.text :description

      t.timestamps
    end
  end
end
