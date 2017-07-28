task :campaign_reminder_job => :environment do
  CampaignReminderJob.perform_now
end