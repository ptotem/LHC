class AddAttachmentAvatarToSiteContents < ActiveRecord::Migration
  def self.up
    change_table :site_contents do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :site_contents, :avatar
  end
end
