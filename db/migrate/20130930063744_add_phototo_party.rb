class AddPhototoParty < ActiveRecord::Migration
  def up
		add_column :refinery_parties, :photo_id, :integer

  end

  def down
  end
end
