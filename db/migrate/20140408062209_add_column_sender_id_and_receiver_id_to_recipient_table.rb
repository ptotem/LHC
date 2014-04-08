class AddColumnSenderIdAndReceiverIdToRecipientTable < ActiveRecord::Migration
  def change
    add_column :recipients, :sender_id, :integer
    add_column :recipients, :receiver_id, :integer
  end
end
