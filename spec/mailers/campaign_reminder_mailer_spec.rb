require "rails_helper"

RSpec.describe CampaignReminderMailer, type: :mailer do
  describe "campaign_reminder_email" do
    let(:recipient) { create(:user) }
    let(:campaign) { create(:campaign, user_id: recipient.id) }
    let(:mail) { CampaignReminderMailer.campaign_reminder_email(recipient, campaign) }

    it "renders the headers" do
      expect(mail.subject).to eq("Reminder: #{campaign.name} has a Session Today")
      expect(mail.to).to eq(["#{recipient.email}"])
      expect(mail.from).to eq(["reminders@campaignmanager.xyz"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi #{recipient.email}")
    end

    it "sends an email" do
      expect{mail.deliver_now}.to change{ActionMailer::Base.deliveries.count}.by(1)
    end
  end
end