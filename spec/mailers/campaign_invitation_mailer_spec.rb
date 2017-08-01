require "rails_helper"

RSpec.describe CampaignInvitationMailer, type: :mailer do
  describe "campaign_invitation_email" do
    let(:user) { create(:user) }
    let(:recipient) { create(:user, email: "recipient@example.com") }
    let(:campaign) { create(:campaign, user_id: recipient.id) }
    let(:mail) { CampaignInvitationMailer.campaign_invitation_email(user, recipient, campaign) }

    it "renders the headers" do
      expect(mail.subject).to eq("You're Invited to Join #{campaign.name}")
      expect(mail.to).to eq("#{recipient}")
      expect(mail.from).to eq(["invitations@campaignmanager.xyz"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi #{recipient}")
    end

    it "sends an email" do
      expect{mail.deliver_now}.to change{ActionMailer::Base.deliveries.count}.by(1)
    end
  end
end
