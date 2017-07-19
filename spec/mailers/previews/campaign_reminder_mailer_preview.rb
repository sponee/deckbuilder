# Preview all emails at http://localhost:3000/rails/mailers/campaign_reminder_mailer
class CampaignReminderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/campaign_reminder_mailer/campaign_reminder_email
  def campaign_reminder_email
    CampaignReminderMailer.campaign_reminder_email
  end

end
