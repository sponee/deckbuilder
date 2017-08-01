require 'rails_helper'

RSpec.describe CampaignInvitationsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:campaign) {create(:campaign)}
  let!(:campaign_invitation) {create(:campaign_invitation, recipient_email: user.email)}
  before { request.env["HTTP_REFERER"] = root_url }

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

  describe "POST #create" do
    it "creates a new invitation" do
      post :create, {campaign_id: 1, campaign_invitation: {sender_id: 1, campaign_id: 1, recipient_email: "recipient@example.com"}}
      expect(flash[:notice]).to eq("Your Invitation has been sent!")
    end
  end
end
