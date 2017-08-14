class CampaignMembershipsController < ApplicationController
  before_action :authenticate_user!

  def update
    @campaign_membership = CampaignMembership.find(params[:campaign_membership][:id])
    begin
      if @campaign_membership.update!(campaign_membership_params) && verified_membership(@campaign_membership)
        redirect_to :back, notice: "Your subscription has been updated."
      end
    rescue => e
      flash[:notice] = "Something went wrong!"
      redirect_to :back
    end
  end

  private

  def verified_membership(campaign_membership)
    CampaignMembership.find_by(id: campaign_membership.id, user_id: current_user.id)
  end

  def campaign_membership_params
    params.require(:campaign_membership).permit(:receive_notifications)
  end
end
