# This migration comes from refinery_notices (originally 1)
class CreateNoticesNotices < ActiveRecord::Migration

  def up
    create_table :refinery_notices do |t|
      t.string :title
      t.text :content
      t.string :link
      t.integer :img_id
      t.integer :type
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-notices"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/notices/notices"})
    end

    drop_table :refinery_notices

  end

end
