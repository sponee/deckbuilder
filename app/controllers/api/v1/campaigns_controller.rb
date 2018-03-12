module Api
  module V1
    class CampaignsController < ActionController::API
      include Response
      # GET api/v1/campaign_notes/:id
      def show
        @campaign = Campaign.find(params[:id])
        json_response(@campaign)
      end
    end
  end
end