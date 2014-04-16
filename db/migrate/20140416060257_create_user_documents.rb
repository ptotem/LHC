class CreateUserDocuments < ActiveRecord::Migration
  def change
    create_table :user_documents do |t|
      t.string :verification_text

      t.timestamps
    end
  end
end
