class CreateCitizensTasks < ActiveRecord::Migration
  def change
    create_table :citizens_tasks do |t|
      t.references :task
      t.references :citizen


      t.integer :hours
      t.timestamps
    end

    add_index :citizens_tasks, :citizen_id
    add_index :citizens_tasks, :task_id
    add_index :citizens_tasks, [:citizen_id, :task_id], :unique => true

  end
end
