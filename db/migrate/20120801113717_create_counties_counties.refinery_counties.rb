# This migration comes from refinery_counties (originally 1)
class CreateCountiesCounties < ActiveRecord::Migration

  def up
    create_table :refinery_counties do |t|
      t.string :name, :null => false
      t.integer :position

      t.timestamps
    end

    add_index :refinery_counties, :name, :unique => true

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-counties"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/counties/counties"})
    end

    drop_table :refinery_counties

  end

end
