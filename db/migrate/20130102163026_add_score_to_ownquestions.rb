class AddScoreToOwnquestions < ActiveRecord::Migration
  def change
    add_column :refinery_own_questions, :score, :integer, :default=>0
  end
end
