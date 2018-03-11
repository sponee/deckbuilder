class CampaignInvitation < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  #belongs_to :recipient, class_name: "User", foreign_key: "recipient_email", primary_key: "email"

  validates               :recipient_email, :email_format => { :message => 'does not look like an email' }
  validates               :sender_id, :recipient_email, :campaign_id, presence: true
  validates_uniqueness_of :campaign_id, scope: [:sender_id, :recipient_email]
  validates_uniqueness_of :recipient_email, scope: [:campaign_id]

  after_create :send_invitation

  scope :pending_for, -> (email) { where(recipient_email: email, accepted: nil) }

  def accept!
    self.accepted = true
    create_campaign_membership
    save!
  end

  def decline!
    self.accepted = false
    save!
  end

  private

  def create_campaign_membership
    CampaignMembership.create!(user_id: User.find_by(email: self.recipient_email).id,
                               campaign_id: self.campaign_id)
  end

  def send_invitation
    CampaignInvitationMailer.campaign_invitation_email(User.find(self.sender_id),
                                                       self.recipient_email.downcase,
                                                       Campaign.find(self.campaign_id)).deliver_later
  end
end