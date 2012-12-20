class CreateOwnQuestionsOwnQuestions < ActiveRecord::Migration

  def up
    create_table :refinery_own_questions do |t|
      t.text :content
      t.string :title
      t.integer :position
      t.references :user
      t.timestamps
      t.datetime :deleted_at
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-own_questions"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/own_questions/own_questions"})
    end

    drop_table :refinery_own_questions

  end

end
