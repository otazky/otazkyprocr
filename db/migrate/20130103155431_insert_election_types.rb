#encoding: utf-8
class InsertElectionTypes < ActiveRecord::Migration
  def up
    Refinery::Elections::ElectionType.create(
        [ { name: 'Otázky voličů' },
          { name: 'Dámská 50' }        ])

  end

  def down
  end
end
