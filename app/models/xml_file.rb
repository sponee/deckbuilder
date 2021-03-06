class XmlFile < ActiveRecord::Base
  belongs_to :user
  has_one :pathfinder_deck, dependent: :destroy
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :name, presence: true # Make sure the owner's name is present.

  after_create :create_pathfinder_deck

  def create_pathfinder_deck
    CreatePathfinderDeckJob.perform_later(self.user, self)
  end
end