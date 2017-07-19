require "rails_helper"

RSpec.describe CampaignReminderMailer, type: :mailer do
  describe "campaign_reminder_email" do
    let(:mail) { CampaignReminderMailer.campaign_reminder_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Campaign reminder email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
