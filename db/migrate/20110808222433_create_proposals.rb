class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.integer :project_id
      t.date :date
      t.string :version
      t.integer :hourly_rate
      t.text :content

      t.timestamps
    end
  end
end

