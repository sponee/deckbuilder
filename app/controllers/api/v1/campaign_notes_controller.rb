module Api
  module V1
    class CampaignNotesController < ActionController::API
      include Response
      # GET api/v1/campaigns/:id
      def show
        @campaign_note = CampaignNote.find(params[:id])
        json_response(@campaign_note)
      end
    end
  end
end