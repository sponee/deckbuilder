class CampaignMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign

  validates_uniqueness_of :user_id, scope: :campaign_id
end
