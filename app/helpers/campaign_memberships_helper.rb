module CampaignMembershipsHelper
  def subscription_link(campaign_membership)
    if campaign_membership.subscribed?
      button_to("Disable Session Reminders",
                update_subscription_path(campaign_membership,
                                         campaign_membership: {id: campaign_membership.id,
                                                               receive_notifications: false}), 
                method: :patch, 
                class: "btn btn-default")
    else
      button_to("Enable Session Reminders",
                update_subscription_path(campaign_membership,
                                         campaign_membership: {id: campaign_membership.id,
                                                               receive_notifications: true}),
                method: :patch, 
                class: "btn btn-default")
    end
  end
end
