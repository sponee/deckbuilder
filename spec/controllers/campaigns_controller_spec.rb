require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:campaign) {create(:campaign, user_id: user.id)}
  let!(:campaign_membership) {create(:campaign_membership, campaign_id: campaign.id, user_id: user.id)}

  before { request.env["HTTP_REFERER"] = root_url }
  before { sign_in user }

  describe "GET #index" do
    it "returns http success" do
      get :index, params: {campaign_id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: {campaign_id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      post :create, params: {campaign: {user_id: user.id, description: "descriptive", name: "name", next_session: "2017-01-01" }}
      expect(flash[:notice]).to eq("The campaign begins!")
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "returns http redirect" do
        put :update, params: {id: campaign.id, campaign: {name: "updated name"}}

        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]).to eq("The campaign has been updated.")
      end
    end

    context "with invalid params" do
      it "returns http redirect" do
        put :update, params: {id: campaign.id, campaign: {name: ""}}

        expect(response).to have_http_status(:redirect)
        expect(flash[:error]).to include("Validation failed")
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: {id: campaign.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #destroy" do
    it "returns http success" do
      delete :destroy, params: {id: campaign.id}
      expect(flash[:notice]).to eq("The campaign is over.")
    end
  end

end
