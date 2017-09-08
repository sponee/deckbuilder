require 'rails_helper'

RSpec.describe CampaignMembership, type: :model do
  let!(:membership) {build(:campaign_membership)}
  it { should validate_presence_of(:campaign_id)}
  it { should validate_presence_of(:user_id)}
  it { should validate_uniqueness_of(:user_id).scoped_to(:campaign_id) }

  describe "#subscribed?" do
    context "when subscribed" do
      it "returns true" do
        membership.receive_notifications = true
        expect(membership.subscribed?).to eq(true)
      end
    end

    context "when not subscribed" do
      it "returns false" do
        membership.receive_notifications = false
        expect(membership.subscribed?).to eq(false)
      end
    end
  end
end
