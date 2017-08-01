require 'rails_helper'

RSpec.describe CampaignInvitationsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:campaign) {create(:campaign)}
  let!(:campaign_invitation) {create(:campaign_invitation, recipient_email: user.email)}

  before { sign_in user }

  describe "GET #pending" do
    it "returns http success" do
      get :pending
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #decline" do
    it "declines the given invitation" do
      post :decline, {id: campaign_invitation.id}
      campaign_invitation.reload
      expect(campaign_invitation.accepted?).to be(false)
    end
  end

  describe "POST #accept" do
    before {campaign_invitation.update_attributes(accepted: nil)}
    it "accepts the given invitation" do
      post :accept, {id: campaign_invitation.id}
      campaign_invitation.reload
      expect(campaign_invitation.accepted?).to be(true)
    end
  end
end
