class AddCacheOphToQuestions < ActiveRecord::Migration
  def change
    add_column :refinery_questions, :cache_oph, :decimal, :precision=>10, :scale => 5
  end
end
