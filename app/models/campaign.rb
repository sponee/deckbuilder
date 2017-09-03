class Campaign < ActiveRecord::Base
  has_many :campaign_memberships, dependent: :destroy
  has_many :character_campaign_memberships, dependent: :destroy
  has_many :campaign_invitations, dependent: :destroy
  has_many :campaign_notes, dependent: :destroy
  has_many :users, through: :campaign_memberships
  has_many :characters, through: :character_campaign_memberships
  belongs_to :game_master, foreign_key: "user_id", class_name: "User"

  scope :playing_today, -> { where(next_session: Date.today) }
  validates_presence_of :name, :description, :next_session
end
