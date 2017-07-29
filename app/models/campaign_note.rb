class CampaignNote < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user

  validates_presence_of :name, :description, :content, :session_date
end
