class Character < ActiveRecord::Base
  belongs_to :user
  has_many :character_campaign_memberships
  has_many :campaigns, through: :character_campaign_memberships
  mount_uploader :attachment, CharacterUploader # Tells rails to use this uploader for this model.

  validates_presence_of :name, :user_id, :attachment

  def not_playing
    self.user.campaigns - self.campaigns
  end

  def ability_score_modifier(ability_score)
    if ability_score
      score = ((ability_score - 10) / 2).round
      if score > 0
        score = "+" + score.to_s
      end
    else
      score = "N/A"
    end
    score
  end
end