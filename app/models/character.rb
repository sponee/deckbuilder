class Character < ActiveRecord::Base
  belongs_to :user
  has_many :character_campaign_memberships
  has_many :campaigns, through: :character_campaign_memberships
  mount_uploader :attachment, CharacterUploader # Tells rails to use this uploader for this model.

  validates_presence_of :name, :user_id, :attachment

  def not_playing
    self.user.campaigns - self.campaigns
  end
end
