class CharacterCampaignMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_s3_client, only: [:download]

  def create
    @character_campaign_membership = CharacterCampaignMembership.new(character_campaign_membership_params)

    respond_to do |format|
      if @character_campaign_membership.save!
        format.html { redirect_to campaign_path(id: @character_campaign_membership.campaign_id), notice: 'Character joined the campaign.' }
        format.json { render :show, status: :created, location: @character_campaign_membership.campaign_id }
      else
        format.html { render :new }
        format.json { render json: @character_campaign_membership.campaign_id.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @character_campaign_membership = CharacterCampaignMembership.find_by(campaign_id: params[:campaign_id], character_id: params[:character_id])
    @character_campaign_membership.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Character left the campaign.' }
      format.json { head :no_content }
    end
  end

  private

  def character_campaign_membership_params
    params.require(:character_campaign_membership).permit(:campaign_id, :character_id)
  end
end
