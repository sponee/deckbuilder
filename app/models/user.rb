class User < ActiveRecord::Base
  has_many :xml_files, dependent: :destroy
  has_many :pathfinder_decks, dependent: :destroy
  has_many :campaign_memberships, dependent: :destroy
  has_many :campaign_notes, dependent: :destroy
  has_many :campaigns, through: :campaign_memberships, dependent: :destroy
  has_many :campaign_invitations, foreign_key: :recipient_email, dependent: :destroy
  has_many :characters, dependent: :destroy

  scope :subscribed_to, -> (campaign) { includes(:campaign_memberships).where(campaign_memberships: { receive_notifications: :true, campaign_id: campaign.id }) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def characters_not_playing(campaign_id)
    self.characters.where.not(id: CharacterCampaignMembership.where(campaign_id: campaign_id).pluck(:character_id))
  end
end
