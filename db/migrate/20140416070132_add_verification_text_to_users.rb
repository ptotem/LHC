class AddVerificationTextToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verification_text, :string
  end
end
