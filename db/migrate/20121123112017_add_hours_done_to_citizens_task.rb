class AddHoursDoneToCitizensTask < ActiveRecord::Migration
  def change

    add_column :citizens_tasks, :hours_done, :decimal, :precision=>5, :scale => 1
    change_column :citizens_tasks, :hours, :decimal, :precision=>5, :scale => 1
    change_column :tasks, :hours, :decimal, :precision=>5, :scale => 1
  end
end
