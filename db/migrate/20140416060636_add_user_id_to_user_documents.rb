class AddUserIdToUserDocuments < ActiveRecord::Migration
  def change
    add_column :user_documents, :user_id, :integer
  end
end
