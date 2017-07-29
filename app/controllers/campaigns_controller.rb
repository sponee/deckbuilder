class CampaignsController < ApplicationController
  before_action :authenticate_user!, :pending_invitations

  def show
    @campaign = Campaign.find(params[:id])
  end

  def new
    @campaign = @user.campaigns.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    begin
      if @campaign.save!
        CampaignMembership.create!(user_id: @user.id, campaign_id: @campaign.id)
        redirect_to campaign_path(@campaign), notice: "The campaign begins!"
      end
    rescue => e
      flash[:error] = e.message
      redirect_to :back
    end
  end

  def edit
    if verified_membership
      @campaign = Campaign.find(params[:id])
    else
      redirect_to campaigns_path, notice: "That isn't your campaign."
    end
  end

  def update
    @campaign = Campaign.find(params[:id])
    begin
      if @campaign.update!(campaign_params) && verified_membership
        redirect_to @campaign, notice: "The campaign has been updated."
      end
    rescue => e
      flash[:error] = e.message
      redirect_to :back
    end
  end

  def destroy
    if verified_membership
       @campaign = Campaign.find(params[:id])
       @campaign.destroy
       redirect_to campaigns_path, notice:  "The campaign is over."
     else
      redirect_to campaigns_path, notice: "That isn't your campaign."
    end
  end

  def index
    @campaigns = @user.campaigns
  end

  private

  def pending_invitations
    user = current_user
    if CampaignInvitation.pending_for(user.email).count > 0
      flash.now[:notice] = %Q[<a href="/pending_invitations">You have pending invitations</a>]
    end
  end

  def verified_membership
    CampaignMembership.find_by(campaign_id: params[:id], user_id: @user.id)
  end

  def campaign_params
    params.require(:campaign).permit(:name, :description, :simulator_url, :next_session, :user_id)
  end
end