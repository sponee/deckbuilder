module CampaignMembershipsHelper
  def subscription_link(campaign_membership)
    subscribe = campaign_membership.subscribed? ? "Disable Session Reminders" : "Enable Session Reminders" 
    button_to(subscribe,
              update_subscription_path(campaign_membership,
                                       campaign_membership: {id: campaign_membership.id,
                                                             receive_notifications: !campaign_membership.receive_notifications}), 
              method: :patch, 
              class: "btn btn-default")
  end
end
