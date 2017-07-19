class CampaignReminderMailer < ApplicationMailer
  default from: "reminders@campaignmanager.xyz"

  def campaign_reminder_email(recipient, campaign)
    @recipient = recipient
    @campaign = campaign
    mail(to: @recipient.email, subject: "Reminder: #{@campaign.name} has a Session Today")
  end
end