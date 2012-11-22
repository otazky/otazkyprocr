class AddHoursToSubtasks < ActiveRecord::Migration
  def change
    add_column :subtasks, :hours, :decimal, :precision=>6,:scale => 1
    add_column :subtasks, :hours_done, :decimal, :precision=>6, :scale => 1
    add_column :subtasks, :state, :integer, :default => 0
  end
end
