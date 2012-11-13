class AddDisabledToRefineryQuestions < ActiveRecord::Migration
  def change
    add_column :refinery_questions, :disabled, :boolean, default: false
  end
end
