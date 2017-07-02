class CampaignsController < ApplicationController
	before_action :authenticate_user!

	def show
		@user = User.find(current_user)
		@campaign = Campaign.find(params[:id])
	end

	def new
		@user = User.find(current_user)
		@campaign = Campaign.new
	end

	def create
		@user = User.find(current_user)
		@gm_id = User.find_by(email: params[:gm_email])
		@campaign = Campaign.new(new_campaign)

     if @campaign.save
        redirect_to campaign_path(@campaign), notice: "The campaign begins!"
     else
        render "new"
     end
	end

	def edit
		@user = User.find(current_user)
		@campaign = Campaign.find(params[:campaign_id])
	end

  def destroy
     @user = User.find(current_user)
     @campaign = Campaign.find(params[:campaign_id])
     @campaign.destroy
     redirect_to campaigns_path, notice:  "The campaign is over."
  end

  private

  def campaign_params
     params.require(:campaign).permit(:gm_user_id, :name, :description, :simulator_url, :next_session)
  end

  def new_campaign
  	new_campaign_params = campaign_params
  	new_campaign_params[:gm_user_id] = User.find_by(email: campaign_params[:gm_email])
  	new_campaign_params
  end
end