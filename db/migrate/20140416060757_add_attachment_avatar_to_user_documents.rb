class AddAttachmentAvatarToUserDocuments < ActiveRecord::Migration
  def self.up
    change_table :user_documents do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :user_documents, :avatar
  end
end
