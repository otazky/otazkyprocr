class AddAcceptedAtToSubtasks < ActiveRecord::Migration
  def change
    add_column :subtasks, :accepted_at, :datetime
  end
end
