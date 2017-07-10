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
    @campaign = Campaign.new(campaign_params)

     if @campaign.save
        CampaignMembership.create!(user_id: @user.id, campaign_id: @campaign.id)
        redirect_to campaign_path(@campaign), notice: "The campaign begins!"
     else
        render "new"
     end
  end

  def edit
    if verified_membership
      @user = User.find(current_user)
      @campaign = Campaign.find(params[:id])
    else
      redirect_to :back, notice: "That isn't your campaign."
    end
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update!(campaign_params) && verified_membership
      redirect_to @campaign, notice: "The campaign has been updated."
    end
  end

  def destroy
    if verified_membership
       @user = User.find(current_user)
       @campaign = Campaign.find(params[:id])
       @campaign.destroy
       redirect_to campaigns_path, notice:  "The campaign is over."
     else
      redirect_to :back, notice: "That isn't your campaign."
    end
  end

  def index
    @user = User.find(current_user)
    @campaigns = @user.campaigns
  end

  private

  def pending_invitations
    if CampaignInvitation.pending_for(@user.email).count > 0
      flash.now[:notice] = %Q[<a href="/pending_invitations">You have pending invitations</a>]
    end
  end

  def verified_membership
    user = current_user
    CampaignMembership.find_by(campaign_id: params[:id], user_id: user.id)
  end

  def campaign_params
    params.require(:campaign).permit(:name, :description, :simulator_url, :next_session, :user_id)
  end
end