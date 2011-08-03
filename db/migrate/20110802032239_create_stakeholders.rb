class CreateStakeholders < ActiveRecord::Migration
  def change
    create_table :stakeholders do |t|
      t.integer :user_id
      t.string :role
      t.integer :project_id

      t.timestamps
    end
  end
end
