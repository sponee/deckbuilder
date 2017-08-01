require 'rails_helper'

RSpec.describe CampaignInvitationsController, type: :controller do
  let!(:user) { create(:user) }
  before { sign_in user }

  describe "GET #pending" do
    it "returns http success" do
      get :pending
      expect(response).to have_http_status(:success)
    end
  end

end
