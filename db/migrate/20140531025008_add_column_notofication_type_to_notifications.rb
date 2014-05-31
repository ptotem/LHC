class AddColumnNotoficationTypeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :notification_type, :string
    add_column :notifications, :notification_seen, :boolean,:default => false

  end
end
