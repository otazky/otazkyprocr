class CreateSubtasks < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
      t.references :task
      t.text :content
      t.timestamps
    end
  end
end
