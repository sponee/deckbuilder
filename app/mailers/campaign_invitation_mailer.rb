class CampaignInvitationMailer < ApplicationMailer
  default from: "invitations@campaignmanager.xyz"

  def campaign_invitation_email(user, recipient, campaign)
    @user = user
    @recipient = recipient
    @campaign = campaign
    mail(to: @recipient, subject: "You're Invited to Join #{@campaign.name}")
  end
end
