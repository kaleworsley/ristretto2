class RemoveCreatedByFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :created_by
  end

  def down
    add_column :projects, :created_by, :integer
  end
end
