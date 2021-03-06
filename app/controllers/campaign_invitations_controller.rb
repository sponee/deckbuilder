class CampaignInvitationsController < ApplicationController
  before_action :authenticate_user!

  def pending
    add_breadcrumb "invitations", pending_invitations_path(@user.id)
    @campaign_invitations = CampaignInvitation.pending_for(@user.email)
  end

  def create
    @campaign_invitation = CampaignInvitation.new(campaign_invitation_params)
    begin
      if @campaign_invitation.save!
        redirect_back(fallback_location: root_url, notice: "Your Invitation has been sent!")
      end
    rescue
      redirect_back(fallback_location: root_url, notice: "Your Invitation could not be sent.")
    end
  end

  def accept
    @campaign_invitation = CampaignInvitation.find(params[:id])
    if @campaign_invitation.accept!
      redirect_to campaign_path(@campaign_invitation.campaign_id), notice: "You joined the campaign!"
    else
      redirect_to pending_invitations_path, notice: "Something went wrong"
    end
  end

  def decline
    @campaign_invitation = CampaignInvitation.find(params[:id])
    if @campaign_invitation.decline!
      redirect_to pending_invitations_path, notice: "You declined joining the campaign!"
    else
      redirect_to pending_invitations_path
    end
  end

  private

  def campaign_invitation_params
    params.require(:campaign_invitation).permit(:sender_id, :recipient_email, :campaign_id)
  end
end
