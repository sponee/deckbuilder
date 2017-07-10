class Campaign < ActiveRecord::Base
  has_many :campaign_memberships, dependent: :destroy
  has_many :campaign_invitations, dependent: :destroy
  has_many :users, through: :campaign_memberships
end
