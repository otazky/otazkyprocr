class TaskState < ActiveRecord::Migration
  def up
    add_column :tasks, :state, :integer, :default => 0
  end

  def down
  end
end
