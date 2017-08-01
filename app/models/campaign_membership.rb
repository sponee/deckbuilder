class CampaignMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :campaign

  validates_uniqueness_of :user_id, scope: :campaign_id
  validates_presence_of :user_id, :campaign_id
end
