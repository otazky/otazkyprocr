class AddCitizenToOwnQuestions < ActiveRecord::Migration
  def change
    add_column :refinery_own_questions, :citizen_id, :integer
  end
end
