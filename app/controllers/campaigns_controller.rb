class CampaignsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user)
    @campaign = Campaign.find(params[:id])
  end

  def new
    @user = User.find(current_user)
    @campaign = @user.campaigns.new
  end

  def create
    @user = User.find(current_user)
    @campaign = @user.campaigns.new(campaign_params)

     if @campaign.save
        redirect_to campaign_path(@campaign), notice: "The campaign begins!"
     else
        render "new"
     end
  end

  def edit
    @user = User.find(current_user)
    @campaign = Campaign.find(params[:id])
  end

  def destroy
     @user = User.find(current_user)
     @campaign = Campaign.find(params[:id])
     @campaign.destroy
     redirect_to campaigns_path, notice:  "The campaign is over."
  end

  def index
    @user = User.find(current_user)
    @campaigns = @user.campaigns
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :description, :simulator_url, :next_session)
  end
end