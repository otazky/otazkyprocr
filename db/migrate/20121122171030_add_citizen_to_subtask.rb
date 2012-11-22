class AddCitizenToSubtask < ActiveRecord::Migration
  def change
    add_column :subtasks, :citizen_id, :integer
  end
end
