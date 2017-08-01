require 'rails_helper'

RSpec.describe CampaignNotesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:campaign) {create(:campaign, user_id: user.id)}
  let!(:campaign_note) { create(:campaign_note, user_id: user.id, campaign_id: campaign.id) }
  let!(:note_params) { {campaign_id: campaign.id, user_id: user.id, name: "name", description: "description", session_date: "2017-01-01", content: "content"} }

  before { request.env["HTTP_REFERER"] = root_url }
  before { sign_in user }

  describe "GET #index" do
    it "returns http success" do
      get :index, {campaign_id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, {campaign_id: 1}
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      post :create, {campaign_id: campaign_note.campaign_id, campaign_note: note_params}
      expect(flash[:notice]).to eq("Your note has been created.")
    end
  end

  describe "PUT #update" do
    it "returns http success" do
      put :update, {campaign_id: campaign_note.campaign_id, id: campaign_note.id, campaign_note: {name: "updated name"}}

      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to eq("Your note has been updated.")
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: campaign_note.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      #get :destroy
      #expect(response).to have_http_status(:success)
    end
  end

end
