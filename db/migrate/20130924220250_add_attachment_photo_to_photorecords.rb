class AddAttachmentPhotoToPhotorecords < ActiveRecord::Migration[4.2]
  def self.up
    add_attachment :photorecords, :photo
  end

  def self.down
    remove_attachment :photorecord, :photo
  end
end
