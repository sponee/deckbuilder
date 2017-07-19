class CampaignReminderJob < ActiveJob::Base
  queue_as :default

  def perform
    Campaign.playing_today.find_each do |campaign|
      campaign.users.each { |user| CampaignReminderMailer.campaign_reminder_email(user, campaign).deliver_later }
    end
  end
end
