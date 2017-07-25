class Campaign < ActiveRecord::Base
  has_many :campaign_memberships, dependent: :destroy
  has_many :campaign_invitations, dependent: :destroy
  has_many :campaign_notes, dependent: :destroy
  has_many :users, through: :campaign_memberships

  scope :playing_today, -> { where(next_session: Date.today) }
end
