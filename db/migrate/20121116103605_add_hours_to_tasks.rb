class AddHoursToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :hours, :integer, :default => 0
  end
end
