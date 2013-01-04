class AddD50ToOwqQuestions < ActiveRecord::Migration
  def change
    add_column :refinery_own_questions, :d50, :boolean, :default=>false
  end
end
