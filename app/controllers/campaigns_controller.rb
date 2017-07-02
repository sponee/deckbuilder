class CampaignsController < ApplicationController
	before_action :authenticate_user!

	def show
		@user = User.find(current_user)
		@campaign = Campaign.find(params[:campaign_id])
	end

	def new
		@user = User.find(current_user)
		@campaign = Campaign.new
	end

	def create
		@user = User.find(current_user)
		@campaign = Campaign.new(campaign_params)

     if @campaign.save
        redirect_to campaigns_path, notice: "The campaign begins!"
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
     def campaing_params
     params.require(:campaign).permit(:gm_user_id, :name, :description, :simulator_url, :next_session)
  end
end