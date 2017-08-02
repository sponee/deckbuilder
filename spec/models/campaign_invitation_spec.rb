require 'rails_helper'

RSpec.describe CampaignInvitation, type: :model do
  let!(:campaign_invitation) { build(:campaign_invitation) }
  let!(:user) { create(:user) }
  let!(:campaign) { create(:campaign) }

  it { should validate_presence_of(:recipient_email) }
  it { should validate_presence_of(:sender_id) }
  it { should validate_presence_of(:campaign_id) }
  
  describe "#decline!" do
    it "sets its accepted attribute to false" do
      campaign_invitation.decline!
      expect(campaign_invitation.accepted).to be(false)
    end
  end

  describe "#accept!" do
    let!(:user) {create(:user, email: campaign_invitation.recipient_email)}

    it "sets its accepted attribute to true" do
      campaign_invitation.accept!
      expect(campaign_invitation.accepted).to be(true)
    end

    it "creates a new CampaignMembership" do
      expect{campaign_invitation.accept!}.to change{CampaignMembership.count}.by(1)
    end
  end

  describe "after create" do
    it "sends a campaign_invitation_email" do
      expect_any_instance_of(CampaignInvitationMailer).to receive(:campaign_invitation_email)
      campaign_invitation.save!
    end
  end
end
