class RemoveNameFromTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :name
  end

  def down
    add_column :tasks, :name, :string
  end
end
