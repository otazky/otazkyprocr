class AddDoneToRefineryElections < ActiveRecord::Migration
  def change
    add_column :refinery_elections, :done, :boolean, :default => false
  end
end
