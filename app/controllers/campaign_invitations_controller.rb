class CampaignInvitationsController < ApplicationController
  before_action :authenticate_user!

  def show
    CampaignMembership.find(params[:id]) if :verified_recipient
  end

  def index
    CampaignMembership.pending_for(current_user.email)
  end

  def create
    @user = User.find(current_user)
    @campaign_invitation = CampaignInvitation.new(campaign_invitation_params)
    if @campaign_invitation.save!
      redirect_to :back, notice: "Your Invitation has been sent!"
    else
      redirect_to :back, notice: "Your Invitation could not be sent."
    end
  end

  private

  def 

  def verified_recipient
    CampaignInvitation.find_by(token: params[:token]).recipient_email == current_user.email
  end

  def campaign_invitation_params
    params.require(:campaign_invitation).permit(:sender_id, :recipient_email, :campaign_id)
  end
end
