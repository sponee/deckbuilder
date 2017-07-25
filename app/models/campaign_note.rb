class CampaignNote < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user

  validates_presence_of :description, :content, :session_date
end
