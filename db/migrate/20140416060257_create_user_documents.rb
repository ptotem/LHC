class CreateUserDocuments < ActiveRecord::Migration
  def change
    create_table :user_documents do |t|

      t.timestamps
    end
  end
end
