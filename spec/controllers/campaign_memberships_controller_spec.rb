require 'rails_helper'

RSpec.describe CampaignMembershipsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:campaign) {create(:campaign)}
  let!(:campaign_membership) {create(:campaign_membership, user_id: user.id, campaign_id: campaign.id)}
  before { request.env["HTTP_REFERER"] = root_url }

  before { sign_in user }

  describe "PATCH #update" do
    it "returns http redirect" do
      put :update, {campaign_membership: {id: campaign_membership.id, receive_notifications: false}}

      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to eq("Your subscription has been updated.")
    end
  end
end