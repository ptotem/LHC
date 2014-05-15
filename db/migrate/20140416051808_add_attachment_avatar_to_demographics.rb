class AddAttachmentAvatarToDemographics < ActiveRecord::Migration
  def self.up
    change_table :demographics do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :demographics, :avatar
  end
end
