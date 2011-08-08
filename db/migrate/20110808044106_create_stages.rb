class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.integer :project_id
      t.string :name
      t.date :deadline

      t.timestamps
    end
  end
end
