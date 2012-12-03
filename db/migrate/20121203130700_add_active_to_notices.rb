class AddActiveToNotices < ActiveRecord::Migration
  def change
    add_column :refinery_notices, :active, :boolean, :default=>false
  end
end
