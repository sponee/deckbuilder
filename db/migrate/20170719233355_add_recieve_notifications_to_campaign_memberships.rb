class AddRecieveNotificationsToCampaignMemberships < ActiveRecord::Migration
  def change
    add_column :campaign_memberships, :receive_notifications, :boolean, default: :true
  end
end
