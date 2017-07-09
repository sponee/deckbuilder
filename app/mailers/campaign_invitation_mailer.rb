class CampaignInvitationMailer < ApplicationMailer
  default from: "invitations@campaignmanager.xyz"

  def campaign_invitation_email(user, recipient, campaign)
    mail(to: recipient.email, subject: "#{user.email} Invited You to Join #{campaign.name}")
  end
end
