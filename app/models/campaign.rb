class Campaign < ActiveRecord::Base
    
  has_many :campaign_memberships
  has_many :users, through: :campaign_memberships
end
