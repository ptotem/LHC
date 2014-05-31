class AddColumnVerificationRequestSentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verification_request_sent, :boolean
    add_column :users, :verification_request_sent_at, :timestamp
  end
end
