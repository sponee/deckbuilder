require 'rails_helper'

RSpec.describe CampaignInvitation, type: :model do
  let!(:campaign_invitation) { build(:campaign_invitation) }
  before { allow(campaign_invitation).to receive(:create_campaign_membership) {nil} }
  before { allow(campaign_invitation).to receive(:send_invitation) {nil} }

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
    it "sets its accepted attribute to true" do
      campaign_invitation.accept!
      expect(campaign_invitation.accepted).to be(true)
    end

    it "triggers #create_campaign_membership" do
      expect(campaign_invitation).to receive(:create_campaign_membership)
      campaign_invitation.accept!
    end
  end

  describe "triggers #send_invitation after save" do
    it "sends a campaign_invitation_email" do
      expect(campaign_invitation).to receive(:send_invitation)
      campaign_invitation.save!
    end
  end
end
