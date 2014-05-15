class AddAttachmentAvatarToQuizCategories < ActiveRecord::Migration
  def self.up
    change_table :quiz_categories do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :quiz_categories, :avatar
  end
end
