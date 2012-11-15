class DropTeamExits < ActiveRecord::Migration
  def up
    drop_table :team_exits
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
