class CreateOqVotes < ActiveRecord::Migration
  def change
    create_table :oq_votes do |t|
      t.references :user
      t.references :own_question
      t.integer :value
      t.timestamps
    end
  end
end
