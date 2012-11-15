class AddHoursMovedToCitizensQuestions < ActiveRecord::Migration
  def change
    add_column :citizens_questions, :hours_moved, :integer, :default => 0
  end
end
