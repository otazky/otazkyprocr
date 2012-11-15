class AddPhotoToRefineryPoliticians < ActiveRecord::Migration
  def change
    add_column :refinery_politicians, :photo_id, :integer
  end
end
