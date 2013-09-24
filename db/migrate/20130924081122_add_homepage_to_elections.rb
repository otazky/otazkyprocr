class AddHomepageToElections < ActiveRecord::Migration
  def change
		add_column :refinery_elections, :homepage, :boolean, :default => false
  end
end
